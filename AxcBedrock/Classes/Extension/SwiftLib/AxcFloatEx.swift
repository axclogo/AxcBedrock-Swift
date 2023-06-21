//
//  AxcFloatEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/20.
//

import Foundation
import CoreGraphics

// MARK: - Float + AxcSpaceProtocol

extension Float: AxcSpaceProtocol { }

public extension AxcSpace where Base == Float {
    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> Float {
        return CreateOptional(unifiedValue) ?? 0
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> Float? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let int = unifiedValue as? Int { return Float(int) } else
        if let int8 = unifiedValue as? Int8 { return Float(int8) } else
        if let int16 = unifiedValue as? Int16 { return Float(int16) } else
        if let int32 = unifiedValue as? Int32 { return Float(int32) } else
        if let int64 = unifiedValue as? Int64 { return Float(int64) } else
        if let uInt = unifiedValue as? UInt { return Float(uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return Float(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return Float(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return Float(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return Float(uInt64) } else
        if let float = unifiedValue as? Float { return float } else
        if let double = unifiedValue as? Double { return Float(double) } else
        if let cgFloat = unifiedValue as? CGFloat { return Float(cgFloat) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return Float(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.floatValue } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.floatValue } else
        if let nsString = unifiedValue as? NSString { return Float(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return Float(float80) }
        #endif
        return nil
    }
}

#if arch(x86_64)
extension Float80: AxcSpaceProtocol { }

public extension AxcSpace where Base == Float80 {
    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> Float80 {
        return CreateOptional(unifiedValue) ?? 0
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> Float80? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let int = unifiedValue as? Int { return Float80(int) } else
        if let int8 = unifiedValue as? Int8 { return Float80(int8) } else
        if let int16 = unifiedValue as? Int16 { return Float80(int16) } else
        if let int32 = unifiedValue as? Int32 { return Float80(int32) } else
        if let int64 = unifiedValue as? Int64 { return Float80(int64) } else
        if let uInt = unifiedValue as? UInt { return Float80(uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return Float80(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return Float80(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return Float80(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return Float80(uInt64) } else
        if let float = unifiedValue as? Float { return Float80(float) } else
        if let double = unifiedValue as? Double { return Float80(double) } else
        if let cgFloat = unifiedValue as? CGFloat { return Float80(cgFloat) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return Float80(string) ?? 0 } else
        if let char = unifiedValue as? Character { return Float80(char.axc.number.floatValue) } else
        if let nsNumber = unifiedValue as? NSNumber { return Float80(nsNumber.floatValue) } else
        if let nsString = unifiedValue as? NSString { return Float80(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return float80 }
        #endif
        return nil
    }
}

#endif
