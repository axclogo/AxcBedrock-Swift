//
//  AxcFile.swift
//  AxcASTEngine
//
//  Created by 赵新 on 1/10/2023.
//

import Cocoa

// MARK: - [AxcFileUtil]

open class AxcFileUtil: NSObject { }

public extension AxcFileUtil {
    /// 文件大小-GB
    /// - Parameter path: 路径
    /// - Returns: 大小，单位GB
    static func FileSize_GB(path: String) -> Double? {
        return FileSize(path: path, units: .useGB)
    }

    /// 文件大小-MB
    /// - Parameter path: 路径
    /// - Returns: 大小，单位MB
    static func FileSize_MB(path: String) -> Double? {
        return FileSize(path: path, units: .useMB)
    }

    /// 文件大小-KB
    /// - Parameter path: 路径
    /// - Returns: 大小，单位KB
    static func FileSize_KB(path: String) -> Double? {
        return FileSize(path: path, units: .useKB)
    }

    /// 文件大小
    /// - Parameters:
    /// - Parameter path: 路径
    ///   - units: 自定单位
    /// - Returns: 大小
    static func FileSize(path: String, units: ByteCountFormatter.Units) -> Double? {
        guard let bytes = FileSize_Bytes(path: path) else { return nil }
        return bytes.axc.storageSpace(units: units)
    }

    /// 文件大小-Bytes
    /// - Parameter path: 路径
    /// - Returns: 大小，单位Bytes
    static func FileSize_Bytes(path: String) -> Int64? {
        var size: Int64?
        if IsDirectory(path: path) { // 是目录则递归
            size = FolderSize_Bytes(path: path)
        } else { // 读取大小信息
            guard let attributed = try? FileManager.default.attributesOfItem(atPath: path) else { return nil }
            size = (attributed[FileAttributeKey.size] as? NSNumber)?.int64Value
        }
        return size
    }

    /// 文件夹大小-GB
    /// - Parameter path: 路径
    /// - Returns: 大小，单位GB
    static func FolderSize_GB(path: String) -> Double? {
        return FolderSize(path: path, units: .useGB)
    }

    /// 文件夹大小-MB
    /// - Parameter path: 路径
    /// - Returns: 大小，单位MB
    static func FolderSize_MB(path: String) -> Double? {
        return FolderSize(path: path, units: .useMB)
    }

    /// 文件夹大小-KB
    /// - Parameter path: 路径
    /// - Returns: 大小，单位KB
    static func FolderSize_KB(path: String) -> Double? {
        return FolderSize(path: path, units: .useKB)
    }

    /// 文件夹大小
    /// - Parameters:
    ///   - path: 路径
    ///   - units: 自定单位
    /// - Returns: 大小
    static func FolderSize(path: String, units: ByteCountFormatter.Units) -> Double? {
        let bytes = FolderSize_Bytes(path: path)
        return bytes.axc.storageSpace(units: units)
    }

    /// 文件夹大小
    /// - Parameters:
    ///   - path: 路径
    /// - Returns: 大小
    static func FolderSize_Bytes(path: String) -> Int64 {
        var totalFileSize: Int64 = 0
        let fileEnumerator = FileManager.default.enumerator(atPath: path)
        while let fileName = fileEnumerator?.nextObject() as? String {
            let filePath = path.axc.nsString.appendingPathComponent(fileName)
            if let fileAttrs = try? FileManager.default.attributesOfItem(atPath: filePath),
               let int64Value = (fileAttrs[FileAttributeKey.size] as? NSNumber)?.int64Value {
                totalFileSize += int64Value
            }
        }
        return totalFileSize
    }

    /// 深度遍历某个文件夹下以及内部的所有文件
    /// - Parameters:
    ///   - path: 目录路径
    ///   - directoryBlock: 回调
    ///   - fileBlock: 回调
    static func VisitDirectory(atPath path: String,
                               directoryBlock: ((_ fileManager: FileManager, _ directoryPath: String, _ directoryName: String) -> Bool)? = nil,
                               fileBlock: (_ fileManager: FileManager, _ filePath: String, _ fileName: String) -> Void) {
        let fileManager = FileManager.default
        do {
            let contents = try fileManager.contentsOfDirectory(atPath: path)
            for content in contents {
                let contentPath = path.axc.appendPathComponent(content)
                if IsDirectory(fileManager: fileManager, path: contentPath) { // 如果是文件夹，递归调用遍历文件夹函数
                    var isVisit = true
                    if let directoryBlock {
                        isVisit = directoryBlock(fileManager, contentPath, content)
                    }
                    if isVisit { // 继续游走
                        VisitDirectory(atPath: contentPath, fileBlock: fileBlock)
                    }
                } else { // 如果是文件，回调
                    fileBlock(fileManager, contentPath, content)
                }
            }
        } catch {
            AxcBedrockLib.FatalLog("Error while enumerating contents of directory: \(error.localizedDescription)")
        }
    }

    /// 是否是目录
    static func IsDirectory(fileManager: FileManager? = nil, path: String) -> Bool {
        let fileManager = fileManager ?? FileManager.default
        var isDirectory: ObjCBool = false
        if fileManager.fileExists(atPath: path, isDirectory: &isDirectory) {
            return isDirectory.boolValue
        }
        return false
    }
}
