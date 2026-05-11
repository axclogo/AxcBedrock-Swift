//
//  AxcUnifiedNumber.swift
//  AxcBedrock
//
//  Created by 赵新 on 2022/1/19.
//

import Foundation

// MARK: - [AxcUnifiedNumber]

/*
 ios中CGFloat和Float有什么区别？

 - CGFloat是Core Graphics框架定义的一种浮点类型，根据不同的操作系统它可以是float或double，用来表示一个32位或64位浮点值。

 - Float是32位浮点数，可以表示大约7位有效数字。
 */

public protocol AxcUnifiedNumber { }

// MARK: - Int + AxcUnifiedNumber

extension Int: AxcUnifiedNumber { }

// MARK: - Int8 + AxcUnifiedNumber

extension Int8: AxcUnifiedNumber { }

// MARK: - Int16 + AxcUnifiedNumber

extension Int16: AxcUnifiedNumber { }

// MARK: - Int32 + AxcUnifiedNumber

extension Int32: AxcUnifiedNumber { }

// MARK: - Int64 + AxcUnifiedNumber

extension Int64: AxcUnifiedNumber { }

// MARK: - UInt + AxcUnifiedNumber

extension UInt: AxcUnifiedNumber { }

// MARK: - UInt8 + AxcUnifiedNumber

extension UInt8: AxcUnifiedNumber { }

// MARK: - UInt16 + AxcUnifiedNumber

extension UInt16: AxcUnifiedNumber { }

// MARK: - UInt32 + AxcUnifiedNumber

extension UInt32: AxcUnifiedNumber { }

// MARK: - UInt64 + AxcUnifiedNumber

extension UInt64: AxcUnifiedNumber { }

// MARK: - Float + AxcUnifiedNumber

extension Float: AxcUnifiedNumber { }

// MARK: - Float80 + AxcUnifiedNumber

#if arch(x86_64)
extension Float80: AxcUnifiedNumber { }
#endif

// MARK: - Double + AxcUnifiedNumber

extension Double: AxcUnifiedNumber { } // Float64

// MARK: - Bool + AxcUnifiedNumber

extension Bool: AxcUnifiedNumber { }

// MARK: - String + AxcUnifiedNumber

extension String: AxcUnifiedNumber { }

// MARK: - NSString + AxcUnifiedNumber

extension NSString: AxcUnifiedNumber { }

// MARK: - Character + AxcUnifiedNumber

extension Character: AxcUnifiedNumber { }

// MARK: - NSNumber + AxcUnifiedNumber

extension NSNumber: AxcUnifiedNumber { }

// MARK: 数据转换扩展

public extension AxcSpace where Base: AxcUnifiedNumber {
    /// 转换NSNumber类型 具有默认值
    var number: NSNumber { return NSNumber.Axc.Create(base) }
    /// 转换NSNumber类型
    var number_optional: NSNumber? { return NSNumber.Axc.CreateOptional(base) }

    /// 转换Int类型 具有默认值
    var int: Int { return Int.Axc.Create(base) }
    /// 转换Int类型
    var int_optional: Int? { return Int.Axc.CreateOptional(base) }

    /// 转换Int8类型 具有默认值
    var int8: Int8 { return Int8.Axc.Create(base) }
    /// 转换Int8类型
    var int8_optional: Int8? { return Int8.Axc.CreateOptional(base) }

    /// 转换Int16类型 具有默认值
    var int16: Int16 { return Int16.Axc.Create(base) }
    /// 转换Int16类型
    var int16_optional: Int16? { return Int16.Axc.CreateOptional(base) }

    /// 转换Int32类型 具有默认值
    var int32: Int32 { return Int32.Axc.Create(base) }
    /// 转换Int32类型
    var int32_optional: Int32? { return Int32.Axc.CreateOptional(base) }

    /// 转换Int64类型 具有默认值
    var int64: Int64 { return Int64.Axc.Create(base) }
    /// 转换Int64类型
    var int64_optional: Int64? { return Int64.Axc.CreateOptional(base) }

    /// 转换UInt类型 具有默认值
    var uint: UInt { return UInt.Axc.Create(base) }
    /// 转换UInt类型 具有默认值
    var uint_optional: UInt? { return UInt.Axc.CreateOptional(base) }

    /// 转换UInt8类型 具有默认值
    var uint8: UInt8 { return UInt8.Axc.Create(base) }
    /// 转换UInt8类型
    var uint8_optional: UInt8? { return UInt8.Axc.CreateOptional(base) }

    /// 转换UInt8类型 具有默认值
    var uint16: UInt16 { return UInt16.Axc.Create(base) }
    /// 转换UInt8类型
    var uint16_optional: UInt16? { return UInt16.Axc.CreateOptional(base) }

    /// 转换Int32类型 具有默认值
    var uint32: UInt32 { return UInt32.Axc.Create(base) }
    /// 转换Int32类型
    var uint32_optional: UInt32? { return UInt32.Axc.CreateOptional(base) }

    /// 转换UInt64类型 具有默认值
    var uint64: UInt64 { return UInt64.Axc.Create(base) }
    /// 转换UInt64类型
    var uint64_optional: UInt64? { return UInt64.Axc.CreateOptional(base) }

    /// 转换Float类型 具有默认值
    var float: Float { return Float.Axc.Create(base) }
    /// 转换Float类型
    var float_optional: Float? { return Float.Axc.CreateOptional(base) }

    #if arch(x86_64)
    /// 转换Float80类型 具有默认值
    var float80: Float80 { return Float80.Axc.Create(base) }
    /// 转换Float08类型
    var float08_optional: Float80? { return Float80.Axc.CreateOptional(base) }
    #endif

    /// 转换Double类型 具有默认值
    var double: Double { return Double.Axc.Create(base) }
    /// 转换Double类型
    var double_optional: Double? { return Double.Axc.CreateOptional(base) }

    /// 转换Bool类型 具有默认值 非0即是
    var bool: Bool { return Bool.Axc.Create(base) }
    /// 转换Bool类型 非0即是
    var bool_optional: Bool? { return Bool.Axc.CreateOptional(base) }
}

// MARK: 数据转换

public extension AxcSpace where Base: AxcUnifiedNumber {
    /// 秒时间转换成Date对象
    var secondsDate: Date {
        return Date(timeIntervalSince1970: double)
    }

    /// 存储空间转换
    /// - Parameter units: 单位
    /// - Returns: 转换值
    func storageSpace(units: ByteCountFormatter.Units, multiple: UInt = 1024) -> Double {
        let bytes = Int64.Axc.Create(base)
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = units
        formatter.countStyle = .binary
        formatter.includesUnit = false
        let string = formatter.string(fromByteCount: bytes).axc.replacing(",", with: "")
        let byteSize = string.axc.double
        return byteSize
    }
}

// MARK: 数学转换

public extension AxcSpace where Base: AxcUnifiedNumber {
    // MARK: - 内部辅助方法

    /// 将 Float 值安全转换为 Int（处理 NaN/Infinity/溢出）
    private func _safeInt(_ value: Float) -> Int {
        guard value.isFinite else { return 0 }
        if value >= Float(Int.max) { return Int.max }
        if value <= Float(Int.min) { return Int.min }
        return Int(value)
    }

    /// 通用数值映射方法，消除类型分发重复代码
    /// - Parameter transform: 对 Float 值进行变换的闭包
    /// - Returns: 变换后的值，保持原始类型
    private func _mapNumericValue(_ transform: (Float) -> Float) -> Base {
        let result = transform(float)
        let intResult = _safeInt(result)
        if let _ = base as? Int { return (intResult as? Base) ?? base } else
        if let _ = base as? Int8 { return (Int8(clamping: intResult) as? Base) ?? base } else
        if let _ = base as? Int16 { return (Int16(clamping: intResult) as? Base) ?? base } else
        if let _ = base as? Int32 { return (Int32(clamping: intResult) as? Base) ?? base } else
        if let _ = base as? Int64 { return (Int64(clamping: intResult) as? Base) ?? base } else
        if let _ = base as? UInt { return (UInt(clamping: intResult) as? Base) ?? base } else
        if let _ = base as? UInt8 { return (UInt8(clamping: intResult) as? Base) ?? base } else
        if let _ = base as? UInt16 { return (UInt16(clamping: intResult) as? Base) ?? base } else
        if let _ = base as? UInt32 { return (UInt32(clamping: intResult) as? Base) ?? base } else
        if let _ = base as? UInt64 { return (UInt64(clamping: intResult) as? Base) ?? base } else
        if let _ = base as? Float { return (Float(result) as? Base) ?? base } else
        if let _ = base as? Double { return (Double(result) as? Base) ?? base } else
        if let _ = base as? CGFloat { return (CGFloat(result) as? Base) ?? base } else
        if let _ = base as? String { return ("\(result)" as? Base) ?? base } else
        if let _ = base as? NSString { return ("\(result)" as? Base) ?? base }
        #if arch(x86_64)
        if let _ = base as? Float80 { return (Float80(result) as? Base) ?? base }
        #endif
        return base
    }

    /// 绝对值，运算精度Float后7位
    var abs: Base {
        guard !(base is Bool), !(base is Character), !(base is NSNumber) else {
            AxcBedrockLib.Log("\(Base.self)类型无法取Abs绝对值！")
            return base
        }
        return _mapNumericValue { Swift.abs($0) }
    }

    /// 向上取整，运算精度Float后7位
    var ceil: Base {
        guard !(base is Bool), !(base is Character), !(base is NSNumber) else {
            AxcBedrockLib.Log("\(Base.self)类型无法向上取整！")
            return base
        }
        return _mapNumericValue { Darwin.ceil($0) }
    }

    /// 向下取整，运算精度Float后7位
    var floor: Base {
        guard !(base is Bool), !(base is Character), !(base is NSNumber) else {
            AxcBedrockLib.Log("\(Base.self)类型无法向下取整！")
            return base
        }
        return _mapNumericValue { Darwin.floor($0) }
    }

    /// 角度转弧度，运算精度Float后7位
    var angleToRadian: Base {
        guard !(base is Bool), !(base is Character), !(base is NSNumber) else {
            AxcBedrockLib.Log("\(Base.self)类型无法角度转弧度！")
            return base
        }
        return _mapNumericValue { .pi * $0 / Float(180) }
    }

    /// 弧度转角度，运算精度Float后7位
    var radianToAngle: Base {
        guard !(base is Bool), !(base is Character), !(base is NSNumber) else {
            AxcBedrockLib.Log("\(Base.self)类型无法弧度转角度！")
            return base
        }
        return _mapNumericValue { $0 * 180 / .pi }
    }
}

public extension AxcSpace where Base: AxcUnifiedNumber {
    /// 保留小数位数
    func position(_ count: AxcUnifiedNumber) -> String {
        let format = "%.\(count)f"
        return String(format: format, double)
    }
}

// MARK: 阈值限位

public extension AxcSpace where Base: AxcUnifiedNumber {
    /// 阈值限位
    func limitThan(min: AxcUnifiedNumber, max: AxcUnifiedNumber) -> Base {
        guard !(base is Bool), !(base is Character), !(base is NSNumber) else {
            AxcBedrockLib.Log("\(Base.self)类型无法做阈值限位！")
            return base
        }
        let lessValue: Double = Double.Axc.Create(min)
        let greaterValue: Double = Double.Axc.Create(max)
        return _mapNumericValue { currentValue in
            var newValue = Double(currentValue)
            if newValue < lessValue { newValue = lessValue }
            if newValue > greaterValue { newValue = greaterValue }
            return Float(newValue)
        }
    }

    /// 最大阈值限位
    func limitMinZero(max: AxcUnifiedNumber) -> Base {
        return limitThan(min: 0, max: max)
    }
}

// MARK: 类方法

public extension AxcSpace where Base: AxcUnifiedNumber {
    /// 取随机值
    static func Random(_ value: UInt32) -> UInt32 {
        return arc4random() % value
    }
}
