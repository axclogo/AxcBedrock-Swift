//
//  AxcUIntEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2022/1/20.
//

import Foundation
import CoreGraphics

// MARK: - 浮点转无符号整型的安全辅助

/// 将 BinaryFloatingPoint 安全转换为无符号整数（处理 NaN / Infinity / 负数 / 溢出）
/// 非有限值返回 nil
private func _safeFloatToUInt<F: BinaryFloatingPoint, I: FixedWidthInteger & UnsignedInteger>(_ value: F, as: I.Type) -> I? {
    guard value.isFinite else { return nil }
    if value <= 0 { return 0 }
    if value >= F(I.max) { return I.max }
    return I(value)
}

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
        if let int = unifiedValue as? Int { return UInt(clamping: int) } else
        if let int8 = unifiedValue as? Int8 { return UInt(clamping: int8) } else
        if let int16 = unifiedValue as? Int16 { return UInt(clamping: int16) } else
        if let int32 = unifiedValue as? Int32 { return UInt(clamping: int32) } else
        if let int64 = unifiedValue as? Int64 { return UInt(clamping: int64) } else
        if let uInt = unifiedValue as? UInt { return uInt } else
        if let uInt8 = unifiedValue as? UInt8 { return UInt(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return UInt(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return UInt(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return UInt(clamping: uInt64) } else
        if let float = unifiedValue as? Float { return _safeFloatToUInt(float, as: UInt.self) } else
        if let double = unifiedValue as? Double { return _safeFloatToUInt(double, as: UInt.self) } else
        if let cgFloat = unifiedValue as? CGFloat { return _safeFloatToUInt(cgFloat, as: UInt.self) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return UInt(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.uintValue } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.uintValue } else
        if let nsString = unifiedValue as? NSString { return UInt(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return _safeFloatToUInt(float80, as: UInt.self) }
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
        if let int = unifiedValue as? Int { return UInt8(clamping: int) } else
        if let int8 = unifiedValue as? Int8 { return UInt8(clamping: int8) } else
        if let int16 = unifiedValue as? Int16 { return UInt8(clamping: int16) } else
        if let int32 = unifiedValue as? Int32 { return UInt8(clamping: int32) } else
        if let int64 = unifiedValue as? Int64 { return UInt8(clamping: int64) } else
        if let uInt = unifiedValue as? UInt { return UInt8(clamping: uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return uInt8 } else
        if let uInt16 = unifiedValue as? UInt16 { return UInt8(clamping: uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return UInt8(clamping: uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return UInt8(clamping: uInt64) } else
        if let float = unifiedValue as? Float { return _safeFloatToUInt(float, as: UInt8.self) } else
        if let double = unifiedValue as? Double { return _safeFloatToUInt(double, as: UInt8.self) } else
        if let cgFloat = unifiedValue as? CGFloat { return _safeFloatToUInt(cgFloat, as: UInt8.self) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return UInt8(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.uint8Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.uint8Value } else
        if let nsString = unifiedValue as? NSString { return UInt8(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return _safeFloatToUInt(float80, as: UInt8.self) }
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
        if let int = unifiedValue as? Int { return UInt16(clamping: int) } else
        if let int8 = unifiedValue as? Int8 { return UInt16(clamping: int8) } else
        if let int16 = unifiedValue as? Int16 { return UInt16(clamping: int16) } else
        if let int32 = unifiedValue as? Int32 { return UInt16(clamping: int32) } else
        if let int64 = unifiedValue as? Int64 { return UInt16(clamping: int64) } else
        if let uInt = unifiedValue as? UInt { return UInt16(clamping: uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return UInt16(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return uInt16 } else
        if let uInt32 = unifiedValue as? UInt32 { return UInt16(clamping: uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return UInt16(clamping: uInt64) } else
        if let float = unifiedValue as? Float { return _safeFloatToUInt(float, as: UInt16.self) } else
        if let double = unifiedValue as? Double { return _safeFloatToUInt(double, as: UInt16.self) } else
        if let cgFloat = unifiedValue as? CGFloat { return _safeFloatToUInt(cgFloat, as: UInt16.self) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return UInt16(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.uint16Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.uint16Value } else
        if let nsString = unifiedValue as? NSString { return UInt16(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return _safeFloatToUInt(float80, as: UInt16.self) }
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
        if let int = unifiedValue as? Int { return UInt32(clamping: int) } else
        if let int8 = unifiedValue as? Int8 { return UInt32(clamping: int8) } else
        if let int16 = unifiedValue as? Int16 { return UInt32(clamping: int16) } else
        if let int32 = unifiedValue as? Int32 { return UInt32(clamping: int32) } else
        if let int64 = unifiedValue as? Int64 { return UInt32(clamping: int64) } else
        if let uInt = unifiedValue as? UInt { return UInt32(clamping: uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return UInt32(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return UInt32(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return uInt32 } else
        if let uInt64 = unifiedValue as? UInt64 { return UInt32(clamping: uInt64) } else
        if let float = unifiedValue as? Float { return _safeFloatToUInt(float, as: UInt32.self) } else
        if let double = unifiedValue as? Double { return _safeFloatToUInt(double, as: UInt32.self) } else
        if let cgFloat = unifiedValue as? CGFloat { return _safeFloatToUInt(cgFloat, as: UInt32.self) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return UInt32(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.uint32Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.uint32Value } else
        if let nsString = unifiedValue as? NSString { return UInt32(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return _safeFloatToUInt(float80, as: UInt32.self) }
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
        if let int = unifiedValue as? Int { return UInt64(clamping: int) } else
        if let int8 = unifiedValue as? Int8 { return UInt64(clamping: int8) } else
        if let int16 = unifiedValue as? Int16 { return UInt64(clamping: int16) } else
        if let int32 = unifiedValue as? Int32 { return UInt64(clamping: int32) } else
        if let int64 = unifiedValue as? Int64 { return UInt64(clamping: int64) } else
        if let uInt = unifiedValue as? UInt { return UInt64(uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return UInt64(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return UInt64(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return UInt64(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return uInt64 } else
        if let float = unifiedValue as? Float { return _safeFloatToUInt(float, as: UInt64.self) } else
        if let double = unifiedValue as? Double { return _safeFloatToUInt(double, as: UInt64.self) } else
        if let cgFloat = unifiedValue as? CGFloat { return _safeFloatToUInt(cgFloat, as: UInt64.self) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return UInt64(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.uint64Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.uint64Value } else
        if let nsString = unifiedValue as? NSString { return UInt64(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return _safeFloatToUInt(float80, as: UInt64.self) }
        #endif
        return nil
    }
}
