//
//  AxcIntEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/20.
//

import Foundation
import CoreGraphics

// MARK: - Int + AxcSpaceProtocol

extension Int: AxcSpaceProtocol { }

public extension AxcSpace where Base == Int {
    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> Base {
        return CreateOptional(unifiedValue) ?? 0
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> Int? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let int = unifiedValue as? Int { return int } else
        if let int8 = unifiedValue as? Int8 { return Int(int8) } else
        if let int16 = unifiedValue as? Int16 { return Int(int16) } else
        if let int32 = unifiedValue as? Int32 { return Int(int32) } else
        if let int64 = unifiedValue as? Int64 { return Int(int64) } else
        if let uInt = unifiedValue as? UInt { return Int(uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return Int(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return Int(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return Int(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return Int(uInt64) } else
        if let float = unifiedValue as? Float { return Int(float) } else
        if let double = unifiedValue as? Double { return Int(double) } else
        if let cgFloat = unifiedValue as? CGFloat { return Int(cgFloat) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return Int(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.intValue } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.intValue } else
        if let nsString = unifiedValue as? NSString { return Int(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return Int(float80) }
        #endif
        return nil
    }
}

// MARK: - Int8 + AxcSpaceProtocol

extension Int8: AxcSpaceProtocol { }

public extension AxcSpace where Base == Int8 {
    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> Base {
        return CreateOptional(unifiedValue) ?? 0
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> Int8? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let int = unifiedValue as? Int { return Int8(int) } else
        if let int8 = unifiedValue as? Int8 { return int8 } else
        if let int16 = unifiedValue as? Int16 { return Int8(int16) } else
        if let int32 = unifiedValue as? Int32 { return Int8(int32) } else
        if let int64 = unifiedValue as? Int64 { return Int8(int64) } else
        if let uInt = unifiedValue as? UInt { return Int8(uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return Int8(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return Int8(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return Int8(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return Int8(uInt64) } else
        if let float = unifiedValue as? Float { return Int8(float) } else
        if let double = unifiedValue as? Double { return Int8(double) } else
        if let cgFloat = unifiedValue as? CGFloat { return Int8(cgFloat) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return Int8(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.int8Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.int8Value } else
        if let nsString = unifiedValue as? NSString { return Int8(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return Int8(float80) }
        #endif
        return nil
    }
}

// MARK: - Int16 + AxcSpaceProtocol

extension Int16: AxcSpaceProtocol { }

public extension AxcSpace where Base == Int16 {
    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> Base {
        return CreateOptional(unifiedValue) ?? 0
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> Int16? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let int = unifiedValue as? Int { return Int16(int) } else
        if let int8 = unifiedValue as? Int8 { return Int16(int8) } else
        if let int16 = unifiedValue as? Int16 { return int16 } else
        if let int32 = unifiedValue as? Int32 { return Int16(int32) } else
        if let int64 = unifiedValue as? Int64 { return Int16(int64) } else
        if let uInt = unifiedValue as? UInt { return Int16(uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return Int16(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return Int16(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return Int16(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return Int16(uInt64) } else
        if let float = unifiedValue as? Float { return Int16(float) } else
        if let double = unifiedValue as? Double { return Int16(double) } else
        if let cgFloat = unifiedValue as? CGFloat { return Int16(cgFloat) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return Int16(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.int16Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.int16Value } else
        if let nsString = unifiedValue as? NSString { return Int16(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return Int16(float80) }
        #endif
        return nil
    }
}

// MARK: - Int32 + AxcSpaceProtocol

extension Int32: AxcSpaceProtocol { }

public extension AxcSpace where Base == Int32 {
    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> Base {
        return CreateOptional(unifiedValue) ?? 0
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> Int32? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let int = unifiedValue as? Int { return Int32(int) } else
        if let int8 = unifiedValue as? Int8 { return Int32(int8) } else
        if let int16 = unifiedValue as? Int16 { return Int32(int16) } else
        if let int32 = unifiedValue as? Int32 { return int32 } else
        if let int64 = unifiedValue as? Int64 { return Int32(int64) } else
        if let uInt = unifiedValue as? UInt { return Int32(uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return Int32(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return Int32(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return Int32(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return Int32(uInt64) } else
        if let float = unifiedValue as? Float { return Int32(float) } else
        if let double = unifiedValue as? Double { return Int32(double) } else
        if let cgFloat = unifiedValue as? CGFloat { return Int32(cgFloat) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return Int32(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.int32Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.int32Value } else
        if let nsString = unifiedValue as? NSString { return Int32(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return Int32(float80) }
        #endif
        return nil
    }
}

// MARK: - Int64 + AxcSpaceProtocol

extension Int64: AxcSpaceProtocol { }

public extension AxcSpace where Base == Int64 {
    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> Base {
        return CreateOptional(unifiedValue) ?? 0
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> Int64? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let int = unifiedValue as? Int { return Int64(int) } else
        if let int8 = unifiedValue as? Int8 { return Int64(int8) } else
        if let int16 = unifiedValue as? Int16 { return Int64(int16) } else
        if let int32 = unifiedValue as? Int32 { return Int64(int32) } else
        if let int64 = unifiedValue as? Int64 { return int64 } else
        if let uInt = unifiedValue as? UInt { return Int64(uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return Int64(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return Int64(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return Int64(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return Int64(uInt64) } else
        if let float = unifiedValue as? Float { return Int64(float) } else
        if let double = unifiedValue as? Double { return Int64(double) } else
        if let cgFloat = unifiedValue as? CGFloat { return Int64(cgFloat) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return Int64(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.int64Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.int64Value } else
        if let nsString = unifiedValue as? NSString { return Int64(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return Int64(float80) }
        #endif
        return nil
    }
}
