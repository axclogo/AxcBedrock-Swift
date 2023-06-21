//
//  AxcCGFloatEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/20.
//

import Foundation
import CoreGraphics

// MARK: - CGFloat + AxcSpaceProtocol

extension CGFloat: AxcSpaceProtocol { }

public extension AxcSpace where Base == CGFloat {
    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> CGFloat {
        return CreateOptional(unifiedValue) ?? 0
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> CGFloat? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let int = unifiedValue as? Int { return CGFloat(int) } else
        if let int8 = unifiedValue as? Int8 { return CGFloat(int8) } else
        if let int16 = unifiedValue as? Int16 { return CGFloat(int16) } else
        if let int32 = unifiedValue as? Int32 { return CGFloat(int32) } else
        if let int64 = unifiedValue as? Int64 { return CGFloat(int64) } else
        if let uInt = unifiedValue as? UInt { return CGFloat(uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return CGFloat(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return CGFloat(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return CGFloat(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return CGFloat(uInt64) } else
        if let float = unifiedValue as? Float { return CGFloat(float) } else
        if let double = unifiedValue as? Double { return CGFloat(double) } else
        if let cgFloat = unifiedValue as? CGFloat { return CGFloat(cgFloat) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return CGFloat(Float(string) ?? 0) } else
        if let char = unifiedValue as? Character { return CGFloat(char.axc.number.floatValue) } else
        if let nsNumber = unifiedValue as? NSNumber { return CGFloat(nsNumber.floatValue) } else
        if let nsString = unifiedValue as? NSString { return CGFloat(nsString.floatValue) }
        return nil
    }

    /// 最大值
    static var Max: CGFloat {
        return .greatestFiniteMagnitude
    }

    /// 最小值
    static var Min: CGFloat {
        var min = CGFloat.leastNormalMagnitude
        if min < 0 {
            min = 0.00001
        }
        return min
    }

    /// 无限
    static var Infinity: CGFloat {
        return Float.infinity.axc.cgFloat
    }

    /// 随机
    static var RandomCGFloat: CGFloat {
        let maxValue = UInt32.max
        return .Axc.Create(Random(maxValue))
    }
}
