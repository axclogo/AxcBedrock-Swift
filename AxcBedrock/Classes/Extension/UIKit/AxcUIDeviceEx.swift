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
    /// 总共磁盘空间，单位：MB
    /// 总共磁盘空间，自选单位
    /// 总共磁盘空间，单位：Bytes
    // MARK: 可用磁盘空间

    /// 可用磁盘空间，单位：GB
    /// 可用磁盘空间，单位：MB
    /// 可用磁盘空间，自选单位
    /// 可用磁盘空间，单位：Bytes
    // MARK: 使用磁盘空间

    /// 使用磁盘空间，单位：GB
    /// 使用磁盘空间，单位：MB
    /// 使用磁盘空间，自选单位
    /// 使用磁盘空间，单位：Bytes
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
