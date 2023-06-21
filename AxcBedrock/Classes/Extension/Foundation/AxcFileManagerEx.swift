//
//  AxcFileManagerEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/15.
//

import Foundation

// MARK: - 数据转换

public extension AxcSpace where Base: FileManager { }

// MARK: - 类方法

public extension AxcSpace where Base: FileManager {
    // MARK: - 增

    /// 根据这个路径，创建一个目录
    /// - Parameter path: 路径
    static func CreateDirectory(_ path: String) throws {
        return try FileManager.default.axc.createDirectory(path)
    }

    /// 写入一个文件
    /// - Parameters:
    ///   - path: 路径
    ///   - data: 数据
    ///   - options: 选项
    /// - Returns: 成功与否
    static func WriteFile(_ path: String,
                          data: Data,
                          options: Data.WritingOptions = []) -> Bool {
        return FileManager.default.axc.writeFile(path, data: data, options: options)
    }

    // MARK: - 删

    /// 删除一个文件
    /// - Parameter path: 文件路径
    /// - Returns: 是否成功
    static func DeleteFile(_ path: String) -> Bool {
        return FileManager.default.axc.deleteFile(path)
    }

    // MARK: - 改

    /// 修改文件名
    /// - Parameters:
    ///   - path: 目录路径
    ///   - oldName: 老名字
    ///   - newName: 新名字
    /// - Returns: 是否成功
    static func RenameFile(_ path: String,
                           oldName: String,
                           newName: String) -> Bool {
        return FileManager.default.axc.renameFile(path, oldName: oldName, newName: newName)
    }

    /// 移动文件
    /// - Parameters:
    ///   - fileName: 文件名，需要带后缀
    ///   - fromDir: 原目录
    ///   - toDir: 新目录
    /// - Returns: 是否成功
    static func MoveFile(fileName: String,
                         fromDir: String,
                         toDir: String) -> Bool {
        return FileManager.default.axc.moveFile(fileName: fileName, fromDir: fromDir, toDir: toDir)
    }

    /// 拷贝一个文件
    /// - Parameters:
    ///   - fileName: 文件名，需要带后缀
    ///   - fromDir: 原目录
    ///   - toDir: 新目录
    /// - Returns: 是否成功
    static func CopyFile(fileName: String,
                         fromDir: String,
                         toDir: String) -> Bool {
        return FileManager.default.axc.copyFile(fileName: fileName, fromDir: fromDir, toDir: toDir)
    }

    // MARK: - 查

    /// 读取一个文件
    /// - Parameter path: 路径
    /// - Returns: 文件data数据
    static func ReadFile(_ path: String) -> Data? {
        return FileManager.default.axc.readFile(path)
    }

    /// 遍历获取该目录下所有文件
    /// - Parameters:
    ///   - path: 目录地址
    ///   - filePathBlock: 回调文件目录
    static func FilePaths(_ path: String,
                          filePathBlock: AxcBlock.OneParam<String>) {
        FileManager.default.axc.filePaths(path, filePathBlock: filePathBlock)
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: FileManager {
    // MARK: - 增

    /// 根据这个路径，创建一个目录
    /// - Parameter path: 路径
    func createDirectory(_ path: String) throws {
        guard let dirUrl = path.axc.fileUrl_optional else {
            let log = "路径转换FileUrl错误！\npath:\(path)"
            AxcBedrockLib.Log(log)
            #if DEBUG
            AxcBedrockLib.FatalLog(log)
            #else
            return
            #endif
        }
        let hasDir = base.fileExists(atPath: path)
        if !hasDir { // 不存在，则创建
            return try base.createDirectory(at: dirUrl,
                                            withIntermediateDirectories: true,
                                            attributes: nil)
        }
    }

    /// 写入一个文件
    /// - Parameters:
    ///   - path: 路径
    ///   - data: 数据
    ///   - options: 选项
    /// - Returns: 成功与否
    func writeFile(_ path: String,
                   data: Data,
                   options: Data.WritingOptions = []) -> Bool {
        guard let fileUrl = path.axc.fileUrl_optional else { return false }
        do {
            try data.write(to: fileUrl, options: options)
            return true
        } catch {
            return false
        }
    }

    // MARK: - 删

    /// 删除一个文件
    /// - Parameter path: 文件路径
    /// - Returns: 是否成功
    func deleteFile(_ path: String) -> Bool {
        guard let fileUrl = path.axc.fileUrl_optional else { return false }
        do {
            try base.removeItem(at: fileUrl)
            return true
        } catch {
            return false
        }
    }

    // MARK: - 改

    /// 修改文件名
    /// - Parameters:
    ///   - path: 目录路径
    ///   - oldName: 老名字
    ///   - newName: 新名字
    /// - Returns: 是否成功
    func renameFile(_ path: String,
                    oldName: String,
                    newName: String) -> Bool {
        guard let oldFileUrl = path.axc.appendPathComponent(oldName)
            .axc.fileUrl_optional,
            let newFileUrl = path.axc.appendPathComponent(newName)
            .axc.fileUrl_optional else { return false }
        do {
            try base.moveItem(at: oldFileUrl, to: newFileUrl)
            return true
        } catch {
            return false
        }
    }

    /// 移动文件
    /// - Parameters:
    ///   - fileName: 文件名，需要带后缀
    ///   - fromDir: 原目录
    ///   - toDir: 新目录
    /// - Returns: 是否成功
    func moveFile(fileName: String,
                  fromDir: String,
                  toDir: String) -> Bool {
        guard let originURL = fromDir.axc.appendPathComponent(fileName)
            .axc.fileUrl_optional,
            let destinationURL = toDir.axc.appendPathComponent(fileName)
            .axc.fileUrl_optional else { return false }
        do {
            try base.moveItem(at: originURL, to: destinationURL)
            return true
        } catch {
            return false
        }
    }

    /// 拷贝一个文件
    /// - Parameters:
    ///   - fileName: 文件名，需要带后缀
    ///   - fromDir: 原目录
    ///   - toDir: 新目录
    /// - Returns: 是否成功
    func copyFile(fileName: String,
                  fromDir: String,
                  toDir: String) -> Bool {
        guard let originURL = fromDir.axc.appendPathComponent(fileName)
            .axc.fileUrl_optional,
            let destinationURL = toDir.axc.appendPathComponent(fileName)
            .axc.fileUrl_optional else { return false }
        do {
            try base.copyItem(at: originURL, to: destinationURL)
            return true
        } catch {
            return false
        }
    }

    // MARK: - 查

    /// 读取一个文件
    /// - Parameter path: 路径
    /// - Returns: 文件data数据
    func readFile(_ path: String) -> Data? {
        if let fileContents = base.contents(atPath: path),
           !fileContents.isEmpty {
            return fileContents
        } else {
            return nil
        }
    }

    /// 遍历获取该目录下所有文件
    /// - Parameters:
    ///   - path: 目录地址
    ///   - filePathBlock: 回调文件目录
    func filePaths(_ path: String,
                   filePathBlock: AxcBlock.OneParam<String>) {
        guard let files: [String] = base.subpaths(atPath: path) else { return }
        files.forEach { file in
            let filePath: String = path.axc.appendPathComponent(file)
            let isExists = base.fileExists(atPath: filePath)
            if isExists {
                filePathBlock(filePath)
            }
        }
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: FileManager {
    /// 文件权限是否是读写
    func isWritable(_ filePath: String) -> Bool {
        return base.isWritableFile(atPath: filePath)
    }

    /// 文件权限是否是只读
    func isReadable(_ filePath: String) -> Bool {
        return base.isReadableFile(atPath: filePath)
    }
}
