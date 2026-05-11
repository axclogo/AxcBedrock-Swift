//
//  AxcIntEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2022/1/20.
//

import Foundation
import CoreGraphics

// MARK: - 浮点转整型的安全辅助

/// 将 BinaryFloatingPoint 安全转换为整数（处理 NaN / Infinity / 溢出）
/// 非有限值返回 nil
private func _safeFloatToInt<F: BinaryFloatingPoint, I: FixedWidthInteger>(_ value: F, as: I.Type) -> I? {
    guard value.isFinite else { return nil }
    if value >= F(I.max) { return I.max }
    if value <= F(I.min) { return I.min }
    return I(value)
}

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
        if let int64 = unifiedValue as? Int64 { return Int(clamping: int64) } else
        if let uInt = unifiedValue as? UInt { return Int(clamping: uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return Int(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return Int(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return Int(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return Int(clamping: uInt64) } else
        if let float = unifiedValue as? Float { return _safeFloatToInt(float, as: Int.self) } else
        if let double = unifiedValue as? Double { return _safeFloatToInt(double, as: Int.self) } else
        if let cgFloat = unifiedValue as? CGFloat { return _safeFloatToInt(cgFloat, as: Int.self) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return Int(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.intValue } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.intValue } else
        if let nsString = unifiedValue as? NSString { return Int(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return _safeFloatToInt(float80, as: Int.self) }
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
        if let int = unifiedValue as? Int { return Int8(clamping: int) } else
        if let int8 = unifiedValue as? Int8 { return int8 } else
        if let int16 = unifiedValue as? Int16 { return Int8(clamping: int16) } else
        if let int32 = unifiedValue as? Int32 { return Int8(clamping: int32) } else
        if let int64 = unifiedValue as? Int64 { return Int8(clamping: int64) } else
        if let uInt = unifiedValue as? UInt { return Int8(clamping: uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return Int8(clamping: uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return Int8(clamping: uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return Int8(clamping: uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return Int8(clamping: uInt64) } else
        if let float = unifiedValue as? Float { return _safeFloatToInt(float, as: Int8.self) } else
        if let double = unifiedValue as? Double { return _safeFloatToInt(double, as: Int8.self) } else
        if let cgFloat = unifiedValue as? CGFloat { return _safeFloatToInt(cgFloat, as: Int8.self) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return Int8(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.int8Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.int8Value } else
        if let nsString = unifiedValue as? NSString { return Int8(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return _safeFloatToInt(float80, as: Int8.self) }
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
        if let int = unifiedValue as? Int { return Int16(clamping: int) } else
        if let int8 = unifiedValue as? Int8 { return Int16(int8) } else
        if let int16 = unifiedValue as? Int16 { return int16 } else
        if let int32 = unifiedValue as? Int32 { return Int16(clamping: int32) } else
        if let int64 = unifiedValue as? Int64 { return Int16(clamping: int64) } else
        if let uInt = unifiedValue as? UInt { return Int16(clamping: uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return Int16(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return Int16(clamping: uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return Int16(clamping: uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return Int16(clamping: uInt64) } else
        if let float = unifiedValue as? Float { return _safeFloatToInt(float, as: Int16.self) } else
        if let double = unifiedValue as? Double { return _safeFloatToInt(double, as: Int16.self) } else
        if let cgFloat = unifiedValue as? CGFloat { return _safeFloatToInt(cgFloat, as: Int16.self) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return Int16(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.int16Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.int16Value } else
        if let nsString = unifiedValue as? NSString { return Int16(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return _safeFloatToInt(float80, as: Int16.self) }
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
        if let int = unifiedValue as? Int { return Int32(clamping: int) } else
        if let int8 = unifiedValue as? Int8 { return Int32(int8) } else
        if let int16 = unifiedValue as? Int16 { return Int32(int16) } else
        if let int32 = unifiedValue as? Int32 { return int32 } else
        if let int64 = unifiedValue as? Int64 { return Int32(clamping: int64) } else
        if let uInt = unifiedValue as? UInt { return Int32(clamping: uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return Int32(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return Int32(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return Int32(clamping: uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return Int32(clamping: uInt64) } else
        if let float = unifiedValue as? Float { return _safeFloatToInt(float, as: Int32.self) } else
        if let double = unifiedValue as? Double { return _safeFloatToInt(double, as: Int32.self) } else
        if let cgFloat = unifiedValue as? CGFloat { return _safeFloatToInt(cgFloat, as: Int32.self) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return Int32(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.int32Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.int32Value } else
        if let nsString = unifiedValue as? NSString { return Int32(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return _safeFloatToInt(float80, as: Int32.self) }
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
        if let uInt = unifiedValue as? UInt { return Int64(clamping: uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return Int64(uInt8) } else
        if let uInt16 = unifiedValue as? UInt16 { return Int64(uInt16) } else
        if let uInt32 = unifiedValue as? UInt32 { return Int64(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return Int64(clamping: uInt64) } else
        if let float = unifiedValue as? Float { return _safeFloatToInt(float, as: Int64.self) } else
        if let double = unifiedValue as? Double { return _safeFloatToInt(double, as: Int64.self) } else
        if let cgFloat = unifiedValue as? CGFloat { return _safeFloatToInt(cgFloat, as: Int64.self) } else
        if let bool = unifiedValue as? Bool { return bool ? 1 : 0 } else
        if let string = unifiedValue as? String { return Int64(string) ?? 0 } else
        if let char = unifiedValue as? Character { return char.axc.number.int64Value } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.int64Value } else
        if let nsString = unifiedValue as? NSString { return Int64(nsString as String) }
        #if arch(x86_64)
        if let float80 = unifiedValue as? Float80 { return _safeFloatToInt(float80, as: Int64.self) }
        #endif
        return nil
    }
}
