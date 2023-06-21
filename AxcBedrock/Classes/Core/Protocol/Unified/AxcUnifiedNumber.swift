//
//  AxcUnifiedNumber.swift
//  AxcBadrock
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
}

// MARK: 数学转换

public extension AxcSpace where Base: AxcUnifiedNumber {
    /// 绝对值，运算精度Float后7位
    var abs: Base {
        guard !(base is Bool) || !(base is Character) || !(base is NSNumber) else {
            AxcBedrockLib.FatalLog("\(Base.self)类型无法取Abs绝对值！")
        }
        let absValue: Float = Swift.abs(float)
        if base is Int { return Int(absValue) as! Base } else
        if base is Int8 { return Int8(absValue) as! Base } else
        if base is Int16 { return Int16(absValue) as! Base } else
        if base is Int32 { return Int32(absValue) as! Base } else
        if base is Int64 { return Int64(absValue) as! Base } else
        if base is UInt { return UInt(absValue) as! Base } else
        if base is UInt8 { return UInt8(absValue) as! Base } else
        if base is UInt16 { return UInt16(absValue) as! Base } else
        if base is UInt32 { return absValue as! Base } else
        if base is UInt64 { return UInt64(absValue) as! Base } else
        if base is Float { return Float(absValue) as! Base } else
        if base is Double { return Double(absValue) as! Base } else
        if base is CGFloat { return CGFloat(absValue) as! Base } else
        if base is String { return "\(absValue)" as! Base } else
        if base is NSString { return "\(absValue)" as! Base }
        #if arch(x86_64)
        if base is Float80 { return Float80(absValue) as! Base }
        #endif
        return absValue as! Base
    }

    /// 向上取整，运算精度Float后7位
    var ceil: Base {
        guard !(base is Bool) || !(base is Character) || !(base is NSNumber) else {
            AxcBedrockLib.FatalLog("\(Base.self)类型无法向上取整！")
        }
        let ceilValue = Darwin.ceil(float)
        if base is Int { return Int(ceilValue) as! Base } else
        if base is Int8 { return Int8(ceilValue) as! Base } else
        if base is Int16 { return Int16(ceilValue) as! Base } else
        if base is Int32 { return Int32(ceilValue) as! Base } else
        if base is Int64 { return Int64(ceilValue) as! Base } else
        if base is UInt { return UInt(ceilValue) as! Base } else
        if base is UInt8 { return UInt8(ceilValue) as! Base } else
        if base is UInt16 { return UInt16(ceilValue) as! Base } else
        if base is UInt32 { return UInt32(ceilValue) as! Base } else
        if base is UInt64 { return UInt64(ceilValue) as! Base } else
        if base is Float { return Float(ceilValue) as! Base } else
        if base is Double { return ceilValue as! Base } else
        if base is CGFloat { return CGFloat(ceilValue) as! Base } else
        if base is String { return "\(ceilValue)" as! Base } else
        if base is NSString { return "\(ceilValue)" as! Base }
        #if arch(x86_64)
        if base is Float80 { return Float80(ceilValue) as! Base }
        #endif
        return ceilValue as! Base
    }

    /// 向下取整，运算精度Float后7位
    var floor: Base {
        guard !(base is Bool) || !(base is Character) || !(base is NSNumber) else {
            AxcBedrockLib.FatalLog("\(Base.self)类型无法向下取整！")
        }
        let floorValue = Darwin.floor(float)
        if base is Int { return Int(floorValue) as! Base } else
        if base is Int8 { return Int8(floorValue) as! Base } else
        if base is Int16 { return Int16(floorValue) as! Base } else
        if base is Int32 { return Int32(floorValue) as! Base } else
        if base is Int64 { return Int64(floorValue) as! Base } else
        if base is UInt { return UInt(floorValue) as! Base } else
        if base is UInt8 { return UInt8(floorValue) as! Base } else
        if base is UInt16 { return UInt16(floorValue) as! Base } else
        if base is UInt32 { return UInt32(floorValue) as! Base } else
        if base is UInt64 { return UInt64(floorValue) as! Base } else
        if base is Float { return Float(floorValue) as! Base } else
        if base is Double { return floorValue as! Base } else
        if base is CGFloat { return CGFloat(floorValue) as! Base } else
        if base is String { return "\(floorValue)" as! Base } else
        if base is NSString { return "\(floorValue)" as! Base }
        #if arch(x86_64)
        if base is Float80 { return Float80(floorValue) as! Base }
        #endif
        return floorValue as! Base
    }

    /// 角度转弧度，运算精度Float后7位
    var angleToRadian: Base {
        guard !(base is Bool) || !(base is Character) || !(base is NSNumber) else {
            AxcBedrockLib.FatalLog("\(Base.self)类型无法角度转弧度！")
        }
        let radianValue = .pi * float / Float(180)
        if base is Int { return Int(radianValue) as! Base } else
        if base is Int8 { return Int8(radianValue) as! Base } else
        if base is Int16 { return Int16(radianValue) as! Base } else
        if base is Int32 { return Int32(radianValue) as! Base } else
        if base is Int64 { return Int64(radianValue) as! Base } else
        if base is UInt { return UInt(radianValue) as! Base } else
        if base is UInt8 { return UInt8(radianValue) as! Base } else
        if base is UInt16 { return UInt16(radianValue) as! Base } else
        if base is UInt32 { return UInt32(radianValue) as! Base } else
        if base is UInt64 { return UInt64(radianValue) as! Base } else
        if base is Float { return Float(radianValue) as! Base } else
        if base is Double { return Double(radianValue) as! Base } else
        if base is CGFloat { return CGFloat(radianValue) as! Base } else
        if base is String { return "\(radianValue)" as! Base } else
        if base is NSString { return "\(radianValue)" as! Base }
        #if arch(x86_64)
        if base is Float80 { return Float80(radianValue) as! Base }
        #endif
        return radianValue as! Base
    }

    /// 弧度转角度，运算精度Float后7位
    var radianToAngle: Base {
        guard !(base is Bool) || !(base is Character) || !(base is NSNumber) else {
            AxcBedrockLib.FatalLog("\(Base.self)类型无法弧度转角度！")
        }
        let angleValue = float * 180 / .pi
        if base is Int { return Int(angleValue) as! Base } else
        if base is Int8 { return Int8(angleValue) as! Base } else
        if base is Int16 { return Int16(angleValue) as! Base } else
        if base is Int32 { return Int32(angleValue) as! Base } else
        if base is Int64 { return Int64(angleValue) as! Base } else
        if base is UInt { return UInt(angleValue) as! Base } else
        if base is UInt8 { return UInt8(angleValue) as! Base } else
        if base is UInt16 { return UInt16(angleValue) as! Base } else
        if base is UInt32 { return UInt32(angleValue) as! Base } else
        if base is UInt64 { return UInt64(angleValue) as! Base } else
        if base is Float { return Float(angleValue) as! Base } else
        if base is Double { return Double(angleValue) as! Base } else
        if base is CGFloat { return CGFloat(angleValue) as! Base } else
        if base is String { return "\(angleValue)" as! Base } else
        if base is NSString { return "\(angleValue)" as! Base }
        #if arch(x86_64)
        if base is Float80 { return Float80(angleValue) as! Base }
        #endif
        return angleValue as! Base
    }
}

// MARK: 数学转换

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
    func limitThan(less: AxcUnifiedNumber, greater: AxcUnifiedNumber) -> Base {
        guard !(base is Bool) || !(base is Character) || !(base is NSNumber) else {
            AxcBedrockLib.FatalLog("\(Base.self)类型无法做阈值限位！")
        }
        let compareValue: Double = Double.Axc.Create(base)
        var newValue: Double = compareValue
        let lessValue: Double = Double.Axc.Create(less)
        let greaterValue: Double = Double.Axc.Create(greater)
        if newValue < lessValue {
            newValue = lessValue
        }
        if newValue > greaterValue {
            newValue = greaterValue
        }
        if base is Int { return Int(newValue) as! Base } else
        if base is Int8 { return Int8(newValue) as! Base } else
        if base is Int16 { return Int16(newValue) as! Base } else
        if base is Int32 { return Int32(newValue) as! Base } else
        if base is Int64 { return Int64(newValue) as! Base } else
        if base is UInt { return UInt(newValue) as! Base } else
        if base is UInt8 { return UInt8(newValue) as! Base } else
        if base is UInt16 { return UInt16(newValue) as! Base } else
        if base is UInt32 { return UInt32(newValue) as! Base } else
        if base is UInt64 { return UInt64(newValue) as! Base } else
        if base is Float { return Float(newValue) as! Base } else
        if base is Double { return Double(newValue) as! Base } else
        if base is CGFloat { return CGFloat(newValue) as! Base } else
        if base is String { return "\(newValue)" as! Base } else
        if base is NSString { return "\(newValue)" as! Base }
        #if arch(x86_64)
        if base is Float80 { return Float80(newValue) as! Base }
        #endif
        return newValue as! Base
    }
}

// MARK: 类方法

public extension AxcSpace where Base: AxcUnifiedNumber {
    /// 取随机值
    static func Random(_ value: UInt32) -> UInt32 {
        return arc4random() % value
    }
}
