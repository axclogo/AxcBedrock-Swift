//
//  AxcUIntEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/20.
//

import Foundation
import CoreGraphics

// MARK: - UInt + AxcSpaceProtocol

extension UInt: AxcSpaceProtocol { }

public extension AxcSpace where Base == UInt {
    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> Base {
        return CreateOptional(unifiedValue) ?? 0
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> UInt? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let int = unifiedValue as? Int { return UInt(int) } else
        if let int8 = unifiedValue as? Int8 { return UInt(int8) } else
        if let int16 = unifiedValue as? Int16 { return UInt(int16) } else
        if let int32 = unifiedValue as? Int32 { return UInt(int32) } else
        if let int64 = unifiedValue as? Int64 { return UInt(int64) } else
        if let uInt = unifiedValue as? UInt { return uInt } else
        if let uInt8 = unifiedValue as? UInt8 { return UInt(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return UInt(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return UInt(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return UInt(uInt64) } else
        if let float = unifiedValue as? Float { return UInt(float) } else
        if let double = unifiedValue as? Double { return UInt(double) } else
        if let cgFloat = unifiedValue as? CGFloat { return UInt(cgFloat) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return UInt(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.uintValue } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.uintValue } else
        if let nsString = unifiedValue as? NSString { return UInt(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return UInt(float80) }
        #endif
        return nil
    }
}

// MARK: - UInt8 + AxcSpaceProtocol

extension UInt8: AxcSpaceProtocol { }

public extension AxcSpace where Base == UInt8 {
    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> Base {
        return CreateOptional(unifiedValue) ?? 0
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> UInt8? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let int = unifiedValue as? Int { return UInt8(int) } else
        if let int8 = unifiedValue as? Int8 { return UInt8(int8) } else
        if let int16 = unifiedValue as? Int16 { return UInt8(int16) } else
        if let int32 = unifiedValue as? Int32 { return UInt8(int32) } else
        if let int64 = unifiedValue as? Int64 { return UInt8(int64) } else
        if let uInt = unifiedValue as? UInt { return UInt8(uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return uInt8 } else
        if let uInt16 = unifiedValue as? UInt16 { return UInt8(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return UInt8(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return UInt8(uInt64) } else
        if let float = unifiedValue as? Float { return UInt8(float) } else
        if let double = unifiedValue as? Double { return UInt8(double) } else
        if let cgFloat = unifiedValue as? CGFloat { return UInt8(cgFloat) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return UInt8(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.uint8Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.uint8Value } else
        if let nsString = unifiedValue as? NSString { return UInt8(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return UInt8(float80) }
        #endif
        return nil
    }
}

// MARK: - UInt16 + AxcSpaceProtocol

extension UInt16: AxcSpaceProtocol { }

public extension AxcSpace where Base == UInt16 {
    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> Base {
        return CreateOptional(unifiedValue) ?? 0
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> UInt16? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let int = unifiedValue as? Int { return UInt16(int) } else
        if let int8 = unifiedValue as? Int8 { return UInt16(int8) } else
        if let int16 = unifiedValue as? Int16 { return UInt16(int16) } else
        if let int32 = unifiedValue as? Int32 { return UInt16(int32) } else
        if let int64 = unifiedValue as? Int64 { return UInt16(int64) } else
        if let uInt = unifiedValue as? UInt { return UInt16(uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return UInt16(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return uInt16 } else
        if let uInt32 = unifiedValue as? UInt32 { return UInt16(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return UInt16(uInt64) } else
        if let float = unifiedValue as? Float { return UInt16(float) } else
        if let double = unifiedValue as? Double { return UInt16(double) } else
        if let cgFloat = unifiedValue as? CGFloat { return UInt16(cgFloat) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return UInt16(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.uint16Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.uint16Value } else
        if let nsString = unifiedValue as? NSString { return UInt16(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return UInt16(float80) }
        #endif
        return nil
    }
}

// MARK: - UInt32 + AxcSpaceProtocol

extension UInt32: AxcSpaceProtocol { }

public extension AxcSpace where Base == UInt32 {
    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> Base {
        return CreateOptional(unifiedValue) ?? 0
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> UInt32? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let int = unifiedValue as? Int { return UInt32(int) } else
        if let int8 = unifiedValue as? Int8 { return UInt32(int8) } else
        if let int16 = unifiedValue as? Int16 { return UInt32(int16) } else
        if let int32 = unifiedValue as? Int32 { return UInt32(int32) } else
        if let int64 = unifiedValue as? Int64 { return UInt32(int64) } else
        if let uInt = unifiedValue as? UInt { return UInt32(uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return UInt32(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return UInt32(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return uInt32 } else
        if let uInt64 = unifiedValue as? UInt64 { return UInt32(uInt64) } else
        if let float = unifiedValue as? Float { return UInt32(float) } else
        if let double = unifiedValue as? Double { return UInt32(double) } else
        if let cgFloat = unifiedValue as? CGFloat { return UInt32(cgFloat) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return UInt32(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.uint32Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.uint32Value } else
        if let nsString = unifiedValue as? NSString { return UInt32(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return UInt32(float80) }
        #endif
        return nil
    }
}

// MARK: - UInt64 + AxcSpaceProtocol

extension UInt64: AxcSpaceProtocol { }

public extension AxcSpace where Base == UInt64 {
    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> Base {
        return CreateOptional(unifiedValue) ?? 0
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> UInt64? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let int = unifiedValue as? Int { return UInt64(int) } else
        if let int8 = unifiedValue as? Int8 { return UInt64(int8) } else
        if let int16 = unifiedValue as? Int16 { return UInt64(int16) } else
        if let int32 = unifiedValue as? Int32 { return UInt64(int32) } else
        if let int64 = unifiedValue as? Int64 { return UInt64(int64) } else
        if let uInt = unifiedValue as? UInt { return UInt64(uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return UInt64(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return UInt64(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return UInt64(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return uInt64 } else
        if let float = unifiedValue as? Float { return UInt64(float) } else
        if let double = unifiedValue as? Double { return UInt64(double) } else
        if let cgFloat = unifiedValue as? CGFloat { return UInt64(cgFloat) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return UInt64(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.uint64Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.uint64Value } else
        if let nsString = unifiedValue as? NSString { return UInt64(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return UInt64(float80) }
        #endif
        return nil
    }
}
