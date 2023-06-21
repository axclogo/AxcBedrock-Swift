//
//  AxcUIDeviceEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2022/7/25.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base: UIDevice { }

// MARK: - 类方法

public extension AxcSpace where Base: UIDevice {
    // MARK: 总共磁盘空间

    /// 总共磁盘空间，单位：GB
    @available(*, deprecated, message: "此api有系统级Bug，获取计算的数值与“系统-通用-用量”中显示的不同")
    static var TotalDiskSpace_GB: Double? {
        guard let bytes = TotalDiskSpace_Bytes else { return nil }
        return _SaveSpaceFormatter(bytes, units: .useGB)
    }

    /// 总共磁盘空间，单位：MB
    @available(*, deprecated, message: "此api有系统级Bug，获取计算的数值与“系统-通用-用量”中显示的不同")
    static var TotalDiskSpace_MB: Double? {
        guard let bytes = TotalDiskSpace_Bytes else { return nil }
        return _SaveSpaceFormatter(bytes, units: .useMB)
    }

    /// 总共磁盘空间，自选单位
    @available(*, deprecated, message: "此api有系统级Bug，获取计算的数值与“系统-通用-用量”中显示的不同")
    static func TotalDiskSpace(units: ByteCountFormatter.Units) -> Double? {
        guard let bytes = TotalDiskSpace_Bytes else { return nil }
        return _SaveSpaceFormatter(bytes, units: units)
    }

    /// 总共磁盘空间，单位：Bytes
    @available(*, deprecated, message: "此api有系统级Bug，获取计算的数值与“系统-通用-用量”中显示的不同")
    static var TotalDiskSpace_Bytes: Int64? {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
              let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value else { return nil }
        return space
    }

    // MARK: 可用磁盘空间

    /// 可用磁盘空间，单位：GB
    @available(*, deprecated, message: "此api有系统级Bug，获取计算的数值与“系统-通用-用量”中显示的不同")
    static var FreeDiskSpace_GB: Double? {
        guard let bytes = FreeDiskSpace_Bytes else { return nil }
        return _SaveSpaceFormatter(bytes, units: .useGB)
    }

    /// 可用磁盘空间，单位：MB
    @available(*, deprecated, message: "此api有系统级Bug，获取计算的数值与“系统-通用-用量”中显示的不同")
    static var FreeDiskSpace_MB: Double? {
        guard let bytes = FreeDiskSpace_Bytes else { return nil }
        return _SaveSpaceFormatter(bytes, units: .useMB)
    }

    /// 可用磁盘空间，自选单位
    @available(*, deprecated, message: "此api有系统级Bug，获取计算的数值与“系统-通用-用量”中显示的不同")
    static func FreeDiskSpace(units: ByteCountFormatter.Units) -> Double? {
        guard let bytes = FreeDiskSpace_Bytes else { return nil }
        return _SaveSpaceFormatter(bytes, units: units)
    }

    /// 可用磁盘空间，单位：Bytes
    @available(*, deprecated, message: "此api有系统级Bug，获取计算的数值与“系统-通用-用量”中显示的不同")
    static var FreeDiskSpace_Bytes: Int64? {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
              let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value
        else { return nil }
        return freeSpace
    }

    // MARK: 使用磁盘空间

    /// 使用磁盘空间，单位：GB
    @available(*, deprecated, message: "此api有系统级Bug，获取计算的数值与“系统-通用-用量”中显示的不同")
    static var UsedDiskSpace_GB: Double? {
        guard let bytes = UsedDiskSpace_Bytes else { return nil }
        return _SaveSpaceFormatter(bytes, units: .useGB)
    }

    /// 使用磁盘空间，单位：MB
    @available(*, deprecated, message: "此api有系统级Bug，获取计算的数值与“系统-通用-用量”中显示的不同")
    static var UsedDiskSpace_MB: Double? {
        guard let bytes = UsedDiskSpace_Bytes else { return nil }
        return _SaveSpaceFormatter(bytes, units: .useMB)
    }

    /// 使用磁盘空间，自选单位
    @available(*, deprecated, message: "此api有系统级Bug，获取计算的数值与“系统-通用-用量”中显示的不同")
    static func UsedDiskSpace(units: ByteCountFormatter.Units) -> Double? {
        guard let bytes = UsedDiskSpace_Bytes else { return nil }
        return _SaveSpaceFormatter(bytes, units: units)
    }

    /// 使用磁盘空间，单位：Bytes
    @available(*, deprecated, message: "此api有系统级Bug，获取计算的数值与“系统-通用-用量”中显示的不同")
    static var UsedDiskSpace_Bytes: Int64? {
        guard let TotalDiskSpace_Bytes,
              let FreeDiskSpace_Bytes else { return nil }
        return TotalDiskSpace_Bytes - FreeDiskSpace_Bytes
    }

    // MARK: 单位转换

    /// 单位转换换算器
    /// - Parameters:
    ///   - bytes: bytes大小
    ///   - units: 单位
    /// - Returns: 大小计算结果
    fileprivate static func _SaveSpaceFormatter(_ bytes: Int64,
                                                units: ByteCountFormatter.Units) -> Double {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = units
        formatter.countStyle = .binary
        formatter.includesUnit = false
        let string = formatter.string(fromByteCount: bytes).axc.replacing(",", with: "")
        let byteSize = string.axc.double
        return byteSize
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: UIDevice { }

// MARK: - 决策判断

public extension AxcSpace where Base: UIDevice { }

#endif
