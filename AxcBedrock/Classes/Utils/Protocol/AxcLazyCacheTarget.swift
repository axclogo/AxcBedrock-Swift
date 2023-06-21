//
//  AxcLazyCacheTarget.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/10.
//

import Foundation

// MARK: - [AxcLazyCacheTableKeyProtocol]

/// 懒缓存表键值对象
public protocol AxcLazyCacheTableKeyProtocol: NSObject {
    /// 缓存键值
    var cacheKey: String { set get }
    /// 缓存开关
    var enableCache: Bool { set get }
}

// MARK: - [AxcLazyCacheTarget]

public protocol AxcLazyCacheTarget: AxcSharedTarget, AxcLogInfoTarget {
    associatedtype TableKey: AxcLazyCacheTableKeyProtocol

    /// 缓存目录地址
    var systemCachePath: String { get }

    /// 磁盘总缓存目录名
    var diskCacheDir: String { get }

    /// 缓存目录
    var diskCachePath: String { get }
}

// MARK: - 默认实现

fileprivate var k_enableTotalCache = "k_fileprivate.AxcBedrock.enableTotalCache"
fileprivate var k_systemCachePath = "k_fileprivate.AxcBedrock.systemCachePath"
public extension AxcLazyCacheTarget {
    /// 缓存总开关，默认开
    var enableTotalCache: Bool {
        set { AxcRuntime.Set(object: self, key: &k_enableTotalCache, value: newValue) }
        get {
            guard let value: Bool = AxcRuntime.GetObject(self, key: &k_enableTotalCache) else {
                let value: Bool = true
                self.enableTotalCache = value
                return value
            }
            return value
        }
    }

    /// 缓存目录地址
    var systemCachePath: String {
        return AxcSystem.Library.Caches.Path
    }

    /// 磁盘总缓存目录名
    var diskCacheDir: String {
        return "\(Self.self)"
    }

    /// 缓存目录
    var diskCachePath: String {
        return Self._AppendPathComponent(systemCachePath, toString: diskCacheDir)
    }

    // MARK: 日志协议

    var logPrefix: String? {
        return AxcBedrockLib.Shared.logPrefix
    }

    var logType: String? {
        return "懒缓存器日志"
    }
}

// MARK: - 提供方法

// MARK: 内存缓存

public extension AxcLazyCacheTarget {
    /// 通过内存懒加载方式缓存，代码块形式
    /// - Parameter key: 键值
    ///   - loadBlock: 加载代码块
    /// - Returns: 泛型
    static func MemoryCache<T>(table: TableKey,
                               key: String,
                               loadBlock: AxcBlock.Return<T>) -> T {
        // 总缓存开关
        if !Shared.enableTotalCache {
            return loadBlock()
        }
        // 取出表缓存开关
        if !table.enableCache {
            return loadBlock()
        }
        // 先获取缓存
        if let value: T = MemoryCacheRead(table: table, key: key) {
            return value
        } else { // 无缓存走加载块，然后缓存
            let loadValue = loadBlock()
            MemoryCacheWrite(table: table, key: key, value: loadValue)
            return loadValue
        }
    }

    /// 手动读取缓存表
    /// - Returns: 缓存值
    static func MemoryCacheRead<T>(table: TableKey,
                                   key: String) -> T? {
        var tableMap: [String: Any] = [:]
        if let _tableMap = Shared.memoryCacheMap[table.cacheKey] {
            tableMap = _tableMap
        }
        return tableMap[key] as? T
    }

    /// 手动存入缓存
    static func MemoryCacheWrite<T>(table: TableKey,
                                    key: String,
                                    value: T) {
        var tableMap: [String: Any] = [:]
        if let _tableMap = Shared.memoryCacheMap[table.cacheKey] {
            tableMap = _tableMap
        }
        tableMap[key] = value
        Shared.memoryCacheMap[table.cacheKey] = tableMap
    }

    /// 获取内存中某个缓存表
    /// - Parameter table: 表名
    /// - Returns: 表内容
    static func MemoryTable(_ table: TableKey) -> [String: Any]? {
        return Shared.memoryCacheMap[table.cacheKey]
    }

    /// 清除内存缓存
    /// - Parameter table: 表名 空即为全部表
    static func MemoryClear(_ table: TableKey? = nil) {
        if let table = table { // 清空单个表
            Shared.memoryCacheMap[table.cacheKey] = [:]
        } else {
            Shared.memoryCacheMap = [:]
        }
    }

    /// 获取缓存总表
    static var MemoryCacheMap: [String: [String: Any]] {
        return Shared.memoryCacheMap
    }
}

// MARK: 磁盘缓存

public extension AxcLazyCacheTarget {
    /// 通过磁盘方式缓存，代码块形式
    /// - Parameter:
    ///   - fileName: 文件名
    ///   - loadBlock: 加载代码块
    ///   - expiry: 有效期，nil为永久
    /// - Returns: Data
    static func DiskCache(table: TableKey,
                          fileName: String,
                          expiry: AxcTimeMark? = nil,
                          loadBlock: AxcBlock.Return<Data>) -> Data {
        // 读取/创建表目录
        let tablePath = _AppendPathComponent(Shared.diskCachePath, toString: table.cacheKey)
        do {
            try _FileManager.createDirectory(at: URL(fileURLWithPath: tablePath),
                                             withIntermediateDirectories: true,
                                             attributes: nil)
        } catch let err {
            let log = """
                文件目录创建失败！
                \(err.localizedDescription)
                """
            Shared.log(log)
        }
        // 获取文件路径
        let filePath = _AppendPathComponent(tablePath, toString: fileName)

        // 创建内部读写文件函数
        func _readAndWriteFile() -> Data {
            let loadValue = loadBlock()
            let fileUrl = URL(fileURLWithPath: filePath)
            do {
                try loadValue.write(to: fileUrl, options: .atomic)
            } catch let err {
                let log = """
                    文件写入失败！
                    Url: \(fileUrl)
                    \(err.localizedDescription)
                    """
                Shared.log(log)
            }
            return loadValue
        }

        // 读取文件
        if let content = _FileManager.contents(atPath: filePath) {
            // 设置了有效期
            if let expiry = expiry {
                do {
                    let fileAttributes = try _FileManager.attributesOfItem(atPath: filePath)
                    // 获取文件修改日期
                    if let modificationDate = fileAttributes[.modificationDate] as? Date {
                        let validityDate = modificationDate.axc.addTimeMark(expiry) // 日期叠加
                        if Date() > validityDate { // 文件已失效
                            return _readAndWriteFile() // 执行读写逻辑
                        }
                    }
                } catch let err {
                    let log = """
                        文件修改时间获取失败！
                        Path: \(filePath)
                        \(err.localizedDescription)
                        """
                    Shared.log(log)
                }
            }
            return content
        } else { // 没有读到文件，执行读取加写入逻辑
            return _readAndWriteFile()
        }
    }

    /// 获取磁盘缓存的大小
    /// - Returns: 单位为M
    static func DiskCacheSize(_ table: TableKey? = nil) -> Float {
        var allSize: Int = 0
        DiskforEachFilePaths(table: table) { filePath in
            let fileSize = FileSize(filePath)
            allSize += fileSize
        }
        return Float(allSize) / (1024.0 * 1024.0)
    }

    /// 计算单个文件大小
    /// - Parameter filePath: 文件路径
    /// - Returns: 字节大小
    private static func FileSize(_ filePath: String) -> Int {
        guard _FileManager.fileExists(atPath: filePath) else { return 0 }
        if let fileAttributes = try? _FileManager.attributesOfItem(atPath: filePath),
           let fileSize = fileAttributes[.size] as? Int {
            return fileSize
        }
        return 0
    }

    /// 清除磁盘缓存
    /// - Parameter table: 表名 空即为全部表
    static func DiskClear(_ table: TableKey? = nil) {
        DiskforEachFilePaths(table: table) { filePath in
            do {
                try _FileManager.removeItem(atPath: filePath)
            } catch let err {
                let log = """
                    文件移除失败！
                    FilePath：\(filePath)
                    \(err.localizedDescription)
                    """
                Shared.log(log)
            }
        }
    }

    /// 遍历获取所有磁盘缓存文件地址
    /// - Parameters:
    ///   - table: 表名 空即为全部表
    ///   - filePathBlock: 缓存文件地址回调
    static func DiskforEachFilePaths(table: TableKey? = nil,
                                     filePathBlock: AxcBlock.OneParam<String>) {
        var floderPath = Shared.diskCachePath
        if let table = table {
            floderPath = _AppendPathComponent(floderPath, toString: table.cacheKey)
        }
        _FilePaths(_FileManager, path: floderPath, filePathBlock: filePathBlock)
    }
}

// MARK: - 内部使用

fileprivate var k_memoryCacheMap = "k_fileprivate.AxcBedrock.memoryCacheMap"
fileprivate var k_fileManager = "k_fileprivate.AxcBedrock.fileManager"
fileprivate extension AxcLazyCacheTarget {
    /// 缓存表
    typealias CacheMap = [String: [String: Any]]

    /// 内存缓存总表
    var memoryCacheMap: CacheMap {
        set { AxcRuntime.Set(object: self, key: &k_memoryCacheMap, value: newValue) }
        get {
            guard let value: CacheMap = AxcRuntime.GetObject(self, key: &k_memoryCacheMap) else {
                let value: CacheMap = [:]
                self.memoryCacheMap = value
                return value
            }
            return value
        }
    }

    /// 文件管理对象
    static var _FileManager: FileManager {
        set { AxcRuntime.Set(object: self, key: &k_fileManager, value: newValue) }
        get {
            guard let value: FileManager = AxcRuntime.GetObject(self, key: &k_fileManager) else {
                let value: FileManager = .default
                self._FileManager = value
                return value
            }
            return value
        }
    }
}

// MARK: - 不进行复用的

/// 因为子组件要求，这个方法不能依赖String
fileprivate extension AxcLazyCacheTarget {
    /// 拼接方法
    static func _AppendPathComponent(_ string: String, toString: String) -> String {
        let nsString = string as NSString
        return nsString.appendingPathComponent(toString)
    }

    static func _FilePaths(_ fileManager: FileManager,
                           path: String,
                           filePathBlock: AxcBlock.OneParam<String>) {
        guard let files: [String] = fileManager.subpaths(atPath: path) else { return }
        files.forEach { file in
            let filePath: String = _AppendPathComponent(path, toString: file)
            let isExists = fileManager.fileExists(atPath: filePath)
            if isExists {
                filePathBlock(filePath)
            }
        }
    }
}
