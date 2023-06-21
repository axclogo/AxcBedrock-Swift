//
//  AxcNSNumberEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/21.
//

import Foundation
import CoreGraphics

public extension AxcSpace where Base: NSNumber {
    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> NSNumber? {
        guard let unifiedValue = unifiedValue else { return nil }
        var newValue: NSNumber?
        if let int = unifiedValue as? Int { newValue = NSNumber(value: int) } else
        if let int8 = unifiedValue as? Int8 { newValue = NSNumber(value: int8) } else
        if let int16 = unifiedValue as? Int16 { newValue = NSNumber(value: int16) } else
        if let int32 = unifiedValue as? Int32 { newValue = NSNumber(value: int32) } else
        if let int64 = unifiedValue as? Int64 { newValue = NSNumber(value: int64) } else
        if let uInt = unifiedValue as? UInt { newValue = NSNumber(value: uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { newValue = NSNumber(value: uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { newValue = NSNumber(value: uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { newValue = NSNumber(value: uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { newValue = NSNumber(value: uInt64) } else
        if let float = unifiedValue as? Float { newValue = NSNumber(value: float) } else
        if let double = unifiedValue as? Double { newValue = NSNumber(value: double) } else
        if let cgFloat = unifiedValue as? CGFloat { newValue = NSNumber(value: Float(cgFloat)) } else
        if let bool = unifiedValue as? Bool { newValue = NSNumber(value: bool.axc.int) } else
        if let string = unifiedValue as? String { newValue = NumberFormatter().number(from: string) ?? 0 } else
        if let char = unifiedValue as? Character { newValue = char.axc.number } else
        if let nsNumber = unifiedValue as? NSNumber { newValue = nsNumber } else
        if let nsString = unifiedValue as? NSString { newValue = nsString.axc.number }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { newValue = NSNumber(value: Float(float80)) }
        #endif
        return newValue
    }

    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> NSNumber {
        return CreateOptional(unifiedValue) ?? .init()
    }
}
