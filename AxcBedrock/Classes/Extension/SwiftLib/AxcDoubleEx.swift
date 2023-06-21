//
//  AxcDoubleEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/20.
//

import Foundation
import CoreGraphics

// MARK: - Double + AxcSpaceProtocol

extension Double: AxcSpaceProtocol { }

public extension AxcSpace where Base == Double {
    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> Double {
        return CreateOptional(unifiedValue) ?? 0
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> Double? {
        guard let unifiedValue = unifiedValue else { return nil } 
        if let int = unifiedValue as? Int { return Double(int) } else
        if let int8 = unifiedValue as? Int8 { return Double(int8) } else
        if let int16 = unifiedValue as? Int16 { return Double(int16) } else
        if let int32 = unifiedValue as? Int32 { return Double(int32) } else
        if let int64 = unifiedValue as? Int64 { return Double(int64) } else
        if let uInt = unifiedValue as? UInt { return Double(uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return Double(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return Double(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return Double(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return Double(uInt64) } else
        if let float = unifiedValue as? Float { return Double(float) } else
        if let double = unifiedValue as? Double { return double } else
        if let cgFloat = unifiedValue as? CGFloat { return Double(cgFloat) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return Double(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.doubleValue } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.doubleValue } else
        if let nsString = unifiedValue as? NSString { return Double(nsString as String) }
        return nil
    }
}
