//
//  AxcCacheManager.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/6.
//

import UIKit

open class AxcCacheManager: NSObject {
    // MARK: - 实例化
    /// 私有实例化
    private override init(){
        super.init()
        createDir(axc_cacheRootDir) // 创建根目录
    }
    /// 单例实例化
    public static let shared: AxcCacheManager = {
        let cache = AxcCacheManager()
        
        return cache
    }()
    
    // MARK: - Api
    // MARK: 内存缓存方法
    /// 缓存的Block声明
    public typealias AxcMemoryCacheBlock = (_ key: String, _ area: String?, _ validityTime: AxcDateChunk?) -> Data
    
    /// 内存缓存存取Block
    /// - Parameters:
    ///   - key: 键值
    ///   - area: 区名
    ///   - validityTime: 有效期
    ///   - cacheBlock: 实现计算需要的数据
    /// - Returns: 数据
    open func axc_memoryCache(_ key: String, area: String? = nil, validityTime: AxcDateChunk? = nil, cacheBlock: AxcMemoryCacheBlock) -> Data {
        let cacheData = axc_readMemoryCache(key: key, area: area) // 尝试取出缓存
        if let data = cacheData {   // 缓存中有数据
            return data // 返回
        }else {
            let data = cacheBlock(key, area, validityTime)   // 从代码块中获取缓存
            axc_saveMemoryCache(data, key: key, area: area, validityTime: validityTime) // 存储
            return data
        }
    }
    
    /// 存入内存缓存
    /// - Parameters:
    ///   - data: 数据
    ///   - key: 键值
    ///   - area: 区名
    ///   - validityTime: 有效期
    open func axc_saveMemoryCache(_ data: Data, key: String, area: String? = nil, validityTime: AxcDateChunk? = nil) {
        let area = axc_memoryCacheFolderArea(area) // 获取存储区
        var mapArea: [String : Any] = [:]
        if let _area = memoryCacheDic[area] as? [String : Any] { // 尝试获取存储区表
            mapArea = _area
        }
        var timeStamp = cacheFilePlaceholderName
        if let overdueTime = validityTime { // 设置过期时间戳
            let saveTime = Date() + overdueTime
            timeStamp = saveTime.axc_iso8601Str
        }
        mapArea[key] = [ kDataStr : data , kTimeStr : timeStamp]    // 存储
        memoryCacheDic[area] = mapArea  // 存入区表
    }
    
    /// 读取内存缓存
    /// - Parameters:
    ///   - key: 键值
    ///   - area: 区名
    /// - Returns: 数据
    open func axc_readMemoryCache(key: String, area: String? = nil) -> Data? {
        let area = axc_memoryCacheFolderArea(area) // 获取存储区
        guard var mapArea = memoryCacheDic[area] as? [String : Any] else {
            AxcLog("未找到该存储区！\nArea:\(area)", level: .warning)
            return nil
        }
        guard let dataMap = mapArea[key] as? [String : Any] else {
            AxcLog("未找到该存储区对应的数据！\nArea:\(area)\nKey:\(key)", level: .warning)
            return nil
        }
        guard let timeStr = dataMap[kTimeStr] as? String else {
            AxcLog("该存储区对应数据的时间戳格式错误！\nArea:\(area)\nKey:\(key)", level: .warning)
            return nil
        }
        if timeStr != cacheFilePlaceholderName { // 有有效期设置
            guard let date = Date(dateString: timeStr, format: AxcTimeStamp.iso8601) else {
                AxcLog("有效期解析失败！\nTimeStamp:\(timeStr)", level: .warning)
                return nil
            }
            guard date > Date() else { // 数据已过期，删除
                mapArea.removeValue(forKey: key)
                return nil
            }
        }
        guard let data = dataMap[kDataStr] as? Data else {
            AxcLog("未找到该存储区对应格式的数据！\nArea:\(area)\nKey:\(key)", level: .warning)
            return nil
        }
        return data
    }
    
    /// 清除某个区的所有缓存
    /// - Parameter area: 需要清除的区名称，默认 默认缓存区块
    open func axc_clearMemoryCache(_ area: String? = nil) {
        let area = axc_memoryCacheFolderArea(area) // 获取存储区
        memoryCacheDic.removeValue(forKey: area) // 移除该存储区
    }
    
    /// 获取内存存储区的区名
    /// - Parameter area: 区名
    /// - Returns: 区名
    open func axc_memoryCacheFolderArea(_ area: String? = nil) -> String {
        var saveAreaName = cacheDefaultRootName
        if let areaName = area {    // 设置默认存储区名称
            saveAreaName = areaName
        }
        return saveAreaName  // 存储区名
    }
    
    // MARK: 私有
    /// 内存缓存对象
    private var memoryCacheDic: [String: Any] = [:]
    /// data字段Key
    private let kDataStr = "Data"
    /// 时间戳字段Key
    private let kTimeStr = "Time"
    
    // MARK: 文件缓存方法
    /// 缓存的Block声明
    public typealias AxcFileCacheBlock = (_ key: String, _ folder: String?, _ validityTime: AxcDateChunk?) -> Data
    
    /// 缓存存取Block
    /// - Parameters:
    ///   - key: 存取键值
    ///   - folder: 存入文件夹名称
    ///   - validityTime: 有效时常
    ///   - cacheBlock: 实现计算需要的数据
    /// - Returns: 数据
    open func axc_fileCache(_ key: String, folder: String? = nil, validityTime: AxcDateChunk? = nil, cacheBlock: AxcFileCacheBlock) -> Data {
        let cacheData = axc_readFileCache(key: key, folder: folder) // 尝试取出缓存
        if let data = cacheData {   // 缓存中有数据
            return data // 返回
        }else {
            let data = cacheBlock(key, folder, validityTime)   // 从代码块中获取缓存
            axc_saveFileCache(data, key: key, folder: folder, validityTime: validityTime) // 存储
            return data
        }
    }
    
    /// 存储一个数据文件
    /// - Parameters:
    ///   - data: data数据
    ///   - key: 键值
    ///   - folder: 存储文件名
    ///   - validityTime: 有效时间 如 3.axc_day 代表3天
    open func axc_saveFileCache(_ data: Data, key: String, folder: String? = nil, validityTime: AxcDateChunk? = nil) {
        let saveDir = axc_fileCacheFolderPath(folder)
        let md5SaveKey = axc_fileCacheAbstract(key)
        let fileDir = saveDir.appending("/\(md5SaveKey)")
        createDir(fileDir) // 写文件前移除该目录下所有文件
        var contentsOfPath: [String]?   // 目录文件集合
        do { contentsOfPath = try fileManager.contentsOfDirectory(atPath: fileDir)}
        catch { AxcLog("读取缓存根目录文件失败！\n\(error)", level: .warning) }    // 警告级
        contentsOfPath?.forEach{    // 遍历删除
            if let fileUrlPath = "\(fileDir)/\($0)".axc_fileUrl {
                do { try fileManager.removeItem(at: fileUrlPath) }
                catch { AxcLog("删除文件失败！\nError:\(error)", level: .warning) }
            }
        } // 设置时间戳
        var timeStamp = cacheFilePlaceholderName
        if let overdueTime = validityTime { // 设置过期时间戳
            let saveTime = Date() + overdueTime
            timeStamp = saveTime.axc_iso8601Str
        }
        let saveDataPath = fileDir.appending("/\(timeStamp)") // 存储文件地址
        guard let saveUrl = saveDataPath.axc_fileUrl else {
            AxcLog("缓存文件Url转换失败！\nPath:\(saveDataPath)", level: .warning)
            return
        } // 写入文件
        do { try data.write(to: saveUrl) }
        catch { AxcLog("写入缓存文件失败！\n\(error)", level: .warning) }    // 警告级
    }
    
    /// 缓存文件读取
    /// - Parameters:
    ///   - key: 键值
    ///   - folder: 文件名
    /// - Returns: 缓存数据
    open func axc_readFileCache(key: String, folder: String? = nil) -> Data? {
        let saveDir = axc_fileCacheFolderPath(folder)
        let md5SaveKey = axc_fileCacheAbstract(key)
        let cacheDir = saveDir.appending("/\(md5SaveKey)") // 缓存文件目录
        var contents: [String]?   // 根目录文件集合
        do { contents = try fileManager.contentsOfDirectory(atPath: cacheDir)}
        catch { AxcLog("读取缓存根目录文件失败！\n\(error)", level: .warning) }    // 警告级
        guard contents?.count == 1 else {   // 保证只存在一个文件
            AxcLog("缓存文件目录结构错误！\nPath:\(cacheDir)\nContents:%@",contents , level: .warning)
            return nil
        }
        let fileName = contents?.first;
        guard let contentFileName = fileName else { // 未找到
            AxcLog("\(cacheDir)目录下未找到\(key)对应的缓存文件！", level: .warning)
            return nil
        }
        let cacheFilePath = cacheDir.appending("/\(contentFileName)")    // 拼接文件地址
        guard let cacheFileUrl = cacheFilePath.axc_fileUrl else {   // 转url
            AxcLog("缓存文件Url转换失败！\nPath:\(cacheFilePath)", level: .warning)
            return nil
        } // 校验有效期
        if contentFileName != cacheFilePlaceholderName { // 有有效期设置
            guard let date = Date(dateString: contentFileName, format: AxcTimeStamp.iso8601) else {
                AxcLog("有效期解析失败！\nTimeStamp:\(contentFileName)", level: .warning)
                return nil
            }
            guard date > Date() else { // 文件已过期，删除
                if let deleteUrl = cacheDir.axc_fileUrl {
                    do { try fileManager.removeItem(at: deleteUrl) }
                    catch { AxcLog("删除文件失败！\nError:\(error)", level: .warning) }
                }
                return nil
            }
        } // 有效期大于当前时间 或 无有效期  有效
        var data: Data?
        do { data = try Data(contentsOf: cacheFileUrl) }
        catch { AxcLog("获取文件失败！\n\(error)", level: .warning) }
        guard let _data = data else {
            AxcLog("获取文件为空！", level: .warning)
            return nil
        }
        return _data
    }
    
    /// 清除文件夹所有缓存
    /// - Parameter folder: 需要清除的文件夹名称，默认 默认缓存文件夹
    open func axc_clearFileCache(_ folder: String? = nil) {
        let saveDir = axc_fileCacheFolderPath(folder)
        guard let rootUrl = axc_cacheRootDir.axc_fileUrl else { // 目录url
            AxcLog("缓存文件Url转换失败！\nPath:\(saveDir)", level: .warning)
            return
        } // 移除根目录下所有缓存
        do { try fileManager.removeItem(at: rootUrl) }
        catch { AxcLog("删除文件失败！\nError:\(error)", level: .warning) }
    }
    
    /// 获取缓存根目录地址
    open var axc_cacheRootDir: String {
        return cachePath.appending(cacheFolderName)
    }
    
    /// 获取缓存文件夹路径
    /// - Parameter folder: 文件夹
    /// - Returns: 路径
    open func axc_fileCacheFolderPath(_ folder: String? = nil) -> String {
        var saveFolderName = cacheDefaultRootName
        if let folderName = folder {    // 设置默认存储文件夹名称
            saveFolderName = folderName
        }
        return axc_cacheRootDir.appending("/\(saveFolderName)")  // 存储目录
    }
    
    /// 根据键值获取文件摘要字段
    /// - Parameter key: 键值
    /// - Returns: 摘要字段
    open func axc_fileCacheAbstract(_ key: String) -> String {
        let saveKey = key.axc_hashDigestStr(.md5)   // md5化
        guard let md5SaveKey = saveKey else {
            AxcLog("键值MD5失败！\n:%@", saveKey, level: .warning)
            return key
        }
        return md5SaveKey
    }
    
    // MARK: 私有
    /// 文件管理器
    private let fileManager = Axc_fileManager
    /// 缓存根目录
    private var cachePath = Axc_documentsPath
    /// 缓存文件夹名
    private var cacheFolderName = "/AxcBadrockCache"
    /// 默认缓存根目录名
    private var cacheDefaultRootName = "default"
    /// 缓存文件占位名
    private var cacheFilePlaceholderName = "none"
    /// 创建目录
    private func createDir(_ path: String) {
        let exist = fileManager.fileExists(atPath: path)
        if !exist { // 目录不存在，创建
            do { try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil) }
            catch { AxcLog("创建缓存目录失败！\n\(error)", level: .warning) }
        }
    }
}
