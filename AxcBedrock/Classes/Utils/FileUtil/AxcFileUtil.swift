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
        guard let attributed = try? FileManager.default.attributesOfItem(atPath: path) else { return nil }
        let isDir = (attributed[FileAttributeKey.type] as? FileAttributeType) == FileAttributeType.typeDirectory
        if !isDir {
            size = (attributed[FileAttributeKey.size] as? NSNumber)?.int64Value
        } else {
            size = FolderSize_Bytes(path: path)
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
}
