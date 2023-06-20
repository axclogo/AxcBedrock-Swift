//
//  AxcUnifiedNumberTarget.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/4/22.
//

import UIKit

// MARK: 数字统一互转协议
public protocol AxcUnifiedNumberTarget {}
extension Int:          AxcUnifiedNumberTarget {}
extension Int8:         AxcUnifiedNumberTarget {}
extension Int16:        AxcUnifiedNumberTarget {}
extension Int32:        AxcUnifiedNumberTarget {}
extension Int64:        AxcUnifiedNumberTarget {}
extension UInt:         AxcUnifiedNumberTarget {}
extension UInt8:        AxcUnifiedNumberTarget {}
extension UInt16:       AxcUnifiedNumberTarget {}
extension UInt32:       AxcUnifiedNumberTarget {}
extension UInt64:       AxcUnifiedNumberTarget {}
extension Float:        AxcUnifiedNumberTarget {}
extension Double:       AxcUnifiedNumberTarget {}
extension CGFloat:      AxcUnifiedNumberTarget {}
extension Bool:         AxcUnifiedNumberTarget {}
extension String:       AxcUnifiedNumberTarget {}
extension Character:    AxcUnifiedNumberTarget {}
extension NSNumber:     AxcUnifiedNumberTarget {}
extension NSString:     AxcUnifiedNumberTarget {}

// MARK: 数据转换扩展
public extension AxcUnifiedNumberTarget {
    /// 转换NSNumber类型
    var axc_number: NSNumber {
        if let int =      self as? Int      { return NSNumber(value: int) }
        if let int8 =     self as? Int8     { return NSNumber(value: int8) }
        if let int16 =    self as? Int16    { return NSNumber(value: int16) }
        if let int32 =    self as? Int32    { return NSNumber(value: int32) }
        if let int64 =    self as? Int64    { return NSNumber(value: int64) }
        if let uInt =     self as? UInt     { return NSNumber(value: uInt) }
        if let uInt8 =    self as? UInt8    { return NSNumber(value: uInt8) }
        if let uInt16 =   self as? UInt16   { return NSNumber(value: uInt16) }
        if let uInt32 =   self as? UInt32   { return NSNumber(value: uInt32) }
        if let uInt64 =   self as? UInt64   { return NSNumber(value: uInt64) }
        if let float =    self as? Float    { return NSNumber(value: float) }
        if let double =   self as? Double   { return NSNumber(value: double) }
        if let cgFloat =  self as? CGFloat  { return NSNumber(value: cgFloat.axc_float) }
        if let bool =     self as? Bool     { return NSNumber(value: bool.axc_int) }
        if let string =   self as? String   { return NumberFormatter().number(from: string) ?? 0 }
        if let char =     self as? Character{ return char.axc_string.axc_number }
        if let nsNumber = self as? NSNumber { return nsNumber }
        if let nsString = self as? NSString { return nsString.axc_string.axc_number }
        return NSNumber(value: 0)
    }
    /// 转换Int类型
    var axc_int: Int {
        if let int =      self as? Int      { return Int(int) }
        if let int8 =     self as? Int8     { return Int(int8) }
        if let int16 =    self as? Int16    { return Int(int16) }
        if let int32 =    self as? Int32    { return Int(int32) }
        if let int64 =    self as? Int64    { return Int(int64) }
        if let uInt =     self as? UInt     { return Int(uInt) }
        if let uInt8 =    self as? UInt8    { return Int(uInt8) }
        if let uInt16 =   self as? UInt16   { return Int(uInt16) }
        if let uInt32 =   self as? UInt32   { return Int(uInt32) }
        if let uInt64 =   self as? UInt64   { return Int(uInt64) }
        if let float =    self as? Float    { return Int(float) }
        if let double =   self as? Double   { return Int(double) }
        if let cgFloat =  self as? CGFloat  { return Int(cgFloat) }
        if let bool =     self as? Bool     { return bool ? 1 : 0 }
        if let string =   self as? String   { return string.axc_number.intValue }
        if let char =     self as? Character{ return char.axc_number.intValue }
        if let nsNumber = self as? NSNumber { return nsNumber.intValue }
        if let nsString = self as? NSString { return nsString.intValue.axc_int }
        return 0
    }
    /// 转换Int8类型
    var axc_int8: Int8 {
        if let int =      self as? Int      { return Int8(int) }
        if let int8 =     self as? Int8     { return Int8(int8) }
        if let int16 =    self as? Int16    { return Int8(int16) }
        if let int32 =    self as? Int32    { return Int8(int32) }
        if let int64 =    self as? Int64    { return Int8(int64) }
        if let uInt =     self as? UInt     { return Int8(uInt) }
        if let uInt8 =    self as? UInt8    { return Int8(uInt8) }
        if let uInt16 =   self as? UInt16   { return Int8(uInt16) }
        if let uInt32 =   self as? UInt32   { return Int8(uInt32) }
        if let uInt64 =   self as? UInt64   { return Int8(uInt64) }
        if let float =    self as? Float    { return Int8(float) }
        if let double =   self as? Double   { return Int8(double) }
        if let cgFloat =  self as? CGFloat  { return Int8(cgFloat) }
        if let bool =     self as? Bool     { return Int8(bool.axc_int) }
        if let string =   self as? String   { return string.axc_number.int8Value }
        if let char =     self as? Character{ return char.axc_number.int8Value }
        if let nsNumber = self as? NSNumber { return nsNumber.int8Value }
        if let nsString = self as? NSString { return nsString.intValue.axc_int8 }
        return 0
    }
    /// 转换Int16类型
    var axc_int16: Int16 {
        if let int =      self as? Int      { return Int16(int) }
        if let int8 =     self as? Int8     { return Int16(int8) }
        if let int16 =    self as? Int16    { return Int16(int16) }
        if let int32 =    self as? Int32    { return Int16(int32) }
        if let int64 =    self as? Int64    { return Int16(int64) }
        if let uInt =     self as? UInt     { return Int16(uInt) }
        if let uInt8 =    self as? UInt8    { return Int16(uInt8) }
        if let uInt16 =   self as? UInt16   { return Int16(uInt16) }
        if let uInt32 =   self as? UInt32   { return Int16(uInt32) }
        if let uInt64 =   self as? UInt64   { return Int16(uInt64) }
        if let float =    self as? Float    { return Int16(float) }
        if let double =   self as? Double   { return Int16(double) }
        if let cgFloat =  self as? CGFloat  { return Int16(cgFloat) }
        if let bool =     self as? Bool     { return Int16(bool.axc_int) }
        if let string =   self as? String   { return string.axc_number.int16Value }
        if let char =     self as? Character{ return char.axc_number.int16Value }
        if let nsNumber = self as? NSNumber { return nsNumber.int16Value }
        if let nsString = self as? NSString { return nsString.intValue.axc_int16 }
        return 0
    }
    /// 转换Int32类型
    var axc_int32: Int32 {
        if let int =      self as? Int      { return Int32(int) }
        if let int8 =     self as? Int8     { return Int32(int8) }
        if let int16 =    self as? Int16    { return Int32(int16) }
        if let int32 =    self as? Int32    { return Int32(int32) }
        if let int64 =    self as? Int64    { return Int32(int64) }
        if let uInt =     self as? UInt     { return Int32(uInt) }
        if let uInt8 =    self as? UInt8    { return Int32(uInt8) }
        if let uInt16 =   self as? UInt16   { return Int32(uInt16) }
        if let uInt32 =   self as? UInt32   { return Int32(uInt32) }
        if let uInt64 =   self as? UInt64   { return Int32(uInt64) }
        if let float =    self as? Float    { return Int32(float) }
        if let double =   self as? Double   { return Int32(double) }
        if let cgFloat =  self as? CGFloat  { return Int32(cgFloat) }
        if let bool =     self as? Bool     { return Int32(bool.axc_int) }
        if let string =   self as? String   { return string.axc_number.int32Value }
        if let char =     self as? Character{ return char.axc_number.int32Value }
        if let nsNumber = self as? NSNumber { return nsNumber.int32Value }
        if let nsString = self as? NSString { return nsString.intValue.axc_int32 }
        return 0
    }
    /// 转换Int64类型
    var axc_int64: Int64 {
        if let int =      self as? Int      { return Int64(int) }
        if let int8 =     self as? Int8     { return Int64(int8) }
        if let int16 =    self as? Int16    { return Int64(int16) }
        if let int32 =    self as? Int32    { return Int64(int32) }
        if let int64 =    self as? Int64    { return Int64(int64) }
        if let uInt =     self as? UInt     { return Int64(uInt) }
        if let uInt8 =    self as? UInt8    { return Int64(uInt8) }
        if let uInt16 =   self as? UInt16   { return Int64(uInt16) }
        if let uInt32 =   self as? UInt32   { return Int64(uInt32) }
        if let uInt64 =   self as? UInt64   { return Int64(uInt64) }
        if let float =    self as? Float    { return Int64(float) }
        if let double =   self as? Double   { return Int64(double) }
        if let cgFloat =  self as? CGFloat  { return Int64(cgFloat) }
        if let bool =     self as? Bool     { return Int64(bool.axc_int) }
        if let string =   self as? String   { return string.axc_number.int64Value }
        if let char =     self as? Character{ return char.axc_number.int64Value }
        if let nsNumber = self as? NSNumber { return nsNumber.int64Value }
        if let nsString = self as? NSString { return nsString.intValue.axc_int64 }
        return 0
    }
    
    /// 转换UInt类型
    var axc_uint: UInt {
        if let int =      self as? Int      { return UInt(int) }
        if let int8 =     self as? Int8     { return UInt(int8) }
        if let int16 =    self as? Int16    { return UInt(int16) }
        if let int32 =    self as? Int32    { return UInt(int32) }
        if let int64 =    self as? Int64    { return UInt(int64) }
        if let uInt =     self as? UInt     { return UInt(uInt) }
        if let uInt8 =    self as? UInt8    { return UInt(uInt8) }
        if let uInt16 =   self as? UInt16   { return UInt(uInt16) }
        if let uInt32 =   self as? UInt32   { return UInt(uInt32) }
        if let uInt64 =   self as? UInt64   { return UInt(uInt64) }
        if let float =    self as? Float    { return UInt(float) }
        if let double =   self as? Double   { return UInt(double) }
        if let cgFloat =  self as? CGFloat  { return UInt(cgFloat) }
        if let bool =     self as? Bool     { return UInt(bool.axc_int) }
        if let string =   self as? String   { return string.axc_number.uintValue }
        if let char =     self as? Character{ return char.axc_number.uintValue }
        if let nsNumber = self as? NSNumber { return nsNumber.uintValue }
        if let nsString = self as? NSString { return nsString.intValue.axc_uint }
        return 0
    }
    /// 转换UInt8类型
    var axc_uint8: UInt8 {
        if let int =      self as? Int      { return UInt8(int) }
        if let int8 =     self as? Int8     { return UInt8(int8) }
        if let int16 =    self as? Int16    { return UInt8(int16) }
        if let int32 =    self as? Int32    { return UInt8(int32) }
        if let int64 =    self as? Int64    { return UInt8(int64) }
        if let uInt =     self as? UInt     { return UInt8(uInt) }
        if let uInt8 =    self as? UInt8    { return UInt8(uInt8) }
        if let uInt16 =   self as? UInt16   { return UInt8(uInt16) }
        if let uInt32 =   self as? UInt32   { return UInt8(uInt32) }
        if let uInt64 =   self as? UInt64   { return UInt8(uInt64) }
        if let float =    self as? Float    { return UInt8(float) }
        if let double =   self as? Double   { return UInt8(double) }
        if let cgFloat =  self as? CGFloat  { return UInt8(cgFloat) }
        if let bool =     self as? Bool     { return UInt8(bool.axc_int) }
        if let string =   self as? String   { return string.axc_number.uint8Value }
        if let char =     self as? Character{ return char.axc_number.uint8Value }
        if let nsNumber = self as? NSNumber { return nsNumber.uint8Value }
        if let nsString = self as? NSString { return nsString.intValue.axc_uint8 }
        return 0
    }
    /// 转换UInt8类型
    var axc_uint16: UInt16 {
        if let int =      self as? Int      { return UInt16(int) }
        if let int8 =     self as? Int8     { return UInt16(int8) }
        if let int16 =    self as? Int16    { return UInt16(int16) }
        if let int32 =    self as? Int32    { return UInt16(int32) }
        if let int64 =    self as? Int64    { return UInt16(int64) }
        if let uInt =     self as? UInt     { return UInt16(uInt) }
        if let uInt8 =    self as? UInt8    { return UInt16(uInt8) }
        if let uInt16 =   self as? UInt16   { return UInt16(uInt16) }
        if let uInt32 =   self as? UInt32   { return UInt16(uInt32) }
        if let uInt64 =   self as? UInt64   { return UInt16(uInt64) }
        if let float =    self as? Float    { return UInt16(float) }
        if let double =   self as? Double   { return UInt16(double) }
        if let cgFloat =  self as? CGFloat  { return UInt16(cgFloat) }
        if let bool =     self as? Bool     { return UInt16(bool.axc_int) }
        if let string =   self as? String   { return string.axc_number.uint16Value }
        if let char =     self as? Character{ return char.axc_number.uint16Value }
        if let nsNumber = self as? NSNumber { return nsNumber.uint16Value }
        if let nsString = self as? NSString { return nsString.intValue.axc_uint16 }
        return 0
    }
    /// 转换Int32类型
    var axc_uint32: UInt32 {
        if let int =      self as? Int      { return UInt32(int) }
        if let int8 =     self as? Int8     { return UInt32(int8) }
        if let int16 =    self as? Int16    { return UInt32(int16) }
        if let int32 =    self as? Int32    { return UInt32(int32) }
        if let int64 =    self as? Int64    { return UInt32(int64) }
        if let uInt =     self as? UInt     { return UInt32(uInt) }
        if let uInt8 =    self as? UInt8    { return UInt32(uInt8) }
        if let uInt16 =   self as? UInt16   { return UInt32(uInt16) }
        if let uInt32 =   self as? UInt32   { return UInt32(uInt32) }
        if let uInt64 =   self as? UInt64   { return UInt32(uInt64) }
        if let float =    self as? Float    { return UInt32(float) }
        if let double =   self as? Double   { return UInt32(double) }
        if let cgFloat =  self as? CGFloat  { return UInt32(cgFloat) }
        if let bool =     self as? Bool     { return UInt32(bool.axc_int) }
        if let string =   self as? String   { return string.axc_number.uint32Value }
        if let char =     self as? Character{ return char.axc_number.uint32Value }
        if let nsNumber = self as? NSNumber { return nsNumber.uint32Value }
        if let nsString = self as? NSString { return nsString.intValue.axc_uint32 }
        return 0
    }
    /// 转换UInt64类型
    var axc_uint64: UInt64 {
        if let int =      self as? Int      { return UInt64(int) }
        if let int8 =     self as? Int8     { return UInt64(int8) }
        if let int32 =    self as? Int32    { return UInt64(int32) }
        if let int64 =    self as? Int64    { return UInt64(int64) }
        if let uInt =     self as? UInt     { return UInt64(uInt) }
        if let uInt8 =    self as? UInt8    { return UInt64(uInt8) }
        if let uInt32 =   self as? UInt32   { return UInt64(uInt32) }
        if let uInt64 =   self as? UInt64   { return UInt64(uInt64) }
        if let float =    self as? Float    { return UInt64(float) }
        if let double =   self as? Double   { return UInt64(double) }
        if let cgFloat =  self as? CGFloat  { return UInt64(cgFloat) }
        if let bool =     self as? Bool     { return UInt64(bool.axc_int) }
        if let string =   self as? String   { return string.axc_number.uint64Value }
        if let char =     self as? Character{ return char.axc_number.uint64Value }
        if let nsNumber = self as? NSNumber { return nsNumber.uint64Value }
        if let nsString = self as? NSString { return nsString.intValue.axc_uint64 }
        return 0
    }
    
    /// 转换Float类型
    var axc_float: Float {
        if let int =      self as? Int      { return Float(int) }
        if let int8 =     self as? Int8     { return Float(int8) }
        if let int32 =    self as? Int32    { return Float(int32) }
        if let int64 =    self as? Int64    { return Float(int64) }
        if let uInt =     self as? UInt     { return Float(uInt) }
        if let uInt8 =    self as? UInt8    { return Float(uInt8) }
        if let uInt32 =   self as? UInt32   { return Float(uInt32) }
        if let uInt64 =   self as? UInt64   { return Float(uInt64) }
        if let float =    self as? Float    { return Float(float) }
        if let double =   self as? Double   { return Float(double) }
        if let cgFloat =  self as? CGFloat  { return Float(cgFloat) }
        if let bool =     self as? Bool     { return Float(bool.axc_int) }
        if let string =   self as? String   { return string.axc_number.floatValue }
        if let char =     self as? Character{ return char.axc_number.floatValue }
        if let nsNumber = self as? NSNumber { return nsNumber.floatValue }
        if let nsString = self as? NSString { return nsString.floatValue }
        return 0
    }
    
    /// 转换Double类型
    var axc_double: Double {
        if let int =      self as? Int      { return Double(int) }
        if let int8 =     self as? Int8     { return Double(int8) }
        if let int32 =    self as? Int32    { return Double(int32) }
        if let int64 =    self as? Int64    { return Double(int64) }
        if let uInt =     self as? UInt     { return Double(uInt) }
        if let uInt8 =    self as? UInt8    { return Double(uInt8) }
        if let uInt32 =   self as? UInt32   { return Double(uInt32) }
        if let uInt64 =   self as? UInt64   { return Double(uInt64) }
        if let float =    self as? Float    { return Double(float) }
        if let double =   self as? Double   { return Double(double) }
        if let cgFloat =  self as? CGFloat  { return Double(cgFloat) }
        if let bool =     self as? Bool     { return Double(bool.axc_int) }
        if let string =   self as? String   { return string.axc_number.doubleValue }
        if let char =     self as? Character{ return char.axc_number.doubleValue }
        if let nsNumber = self as? NSNumber { return nsNumber.doubleValue }
        if let nsString = self as? NSString { return nsString.doubleValue }
        return 0
    }
    
    /// 转换CGFloat类型
    var axc_cgFloat: CGFloat {
        if let int =      self as? Int      { return CGFloat(int) }
        if let int8 =     self as? Int8     { return CGFloat(int8) }
        if let int32 =    self as? Int32    { return CGFloat(int32) }
        if let int64 =    self as? Int64    { return CGFloat(int64) }
        if let uInt =     self as? UInt     { return CGFloat(uInt) }
        if let uInt8 =    self as? UInt8    { return CGFloat(uInt8) }
        if let uInt32 =   self as? UInt32   { return CGFloat(uInt32) }
        if let uInt64 =   self as? UInt64   { return CGFloat(uInt64) }
        if let float =    self as? Float    { return CGFloat(float) }
        if let double =   self as? Double   { return CGFloat(double) }
        if let cgFloat =  self as? CGFloat  { return CGFloat(cgFloat) }
        if let bool =     self as? Bool     { return CGFloat(bool.axc_int) }
        if let string =   self as? String   { return string.axc_number.axc_cgFloat }
        if let char =     self as? Character{ return CGFloat(char.axc_number.floatValue) }
        if let nsNumber = self as? NSNumber { return CGFloat(nsNumber.floatValue) }
        if let nsString = self as? NSString { return nsString.floatValue.axc_cgFloat }
        return 0
    }
    
    /// 转换Bool类型 非0即是
    var axc_bool: Bool {
        if let int =      self as? Int      { return int != 0 }
        if let int8 =     self as? Int8     { return int8 != 0 }
        if let int32 =    self as? Int32    { return int32 != 0 }
        if let int64 =    self as? Int64    { return int64 != 0 }
        if let uInt =     self as? UInt     { return uInt != 0 }
        if let uInt8 =    self as? UInt8    { return uInt8 != 0 }
        if let uInt32 =   self as? UInt32   { return uInt32 != 0 }
        if let uInt64 =   self as? UInt64   { return uInt64 != 0 }
        if let float =    self as? Float    { return float != 0 }
        if let double =   self as? Double   { return double != 0 }
        if let cgFloat =  self as? CGFloat  { return cgFloat != 0 }
        if let bool =     self as? Bool     { return bool }
        if let nsNumber = self as? NSNumber { return nsNumber.boolValue }
        if let char =     self as? Character{ return char != "0" }
        if let string =   self as? String   {
            switch string.axc_trimmed.lowercased() {
            case Axc_true, "yes", "1": return true
            default: return false
            }
        }
        if let nsString = self as? NSString { return String(nsString).axc_bool }
        return false
    }
    
    /// 转换String类型
    var axc_string: String {
        if let int =      self as? Int      { return String(int) }
        if let int8 =     self as? Int8     { return String(int8) }
        if let int32 =    self as? Int32    { return String(int32) }
        if let int64 =    self as? Int64    { return String(int64) }
        if let uInt =     self as? UInt     { return String(uInt) }
        if let uInt8 =    self as? UInt8    { return String(uInt8) }
        if let uInt32 =   self as? UInt32   { return String(uInt32) }
        if let uInt64 =   self as? UInt64   { return String(uInt64) }
        if let float =    self as? Float    { return String(float) }
        if let double =   self as? Double   { return String(double) }
        if let cgFloat =  self as? CGFloat  { return String(cgFloat.axc_float) }
        if let bool =     self as? Bool     { return bool ? Axc_true : Axc_false }
        if let string =   self as? String   { return string }
        if let char =     self as? Character{ return String(char) }
        if let nsNumber = self as? NSNumber { return nsNumber.stringValue }
        if let nsString = self as? NSString { return String(nsString) }
        return ""
    }
    
    /// 转换NSString类型
    var axc_nsString: NSString {
        if let int =      self as? Int      { return NSString(string: "\(int)") }
        if let int8 =     self as? Int8     { return NSString(string: "\(int8)") }
        if let int32 =    self as? Int32    { return NSString(string: "\(int32)") }
        if let int64 =    self as? Int64    { return NSString(string: "\(int64)") }
        if let uInt =     self as? UInt     { return NSString(string: "\(uInt)") }
        if let uInt8 =    self as? UInt8    { return NSString(string: "\(uInt8)") }
        if let uInt32 =   self as? UInt32   { return NSString(string: "\(uInt32)") }
        if let uInt64 =   self as? UInt64   { return NSString(string: "\(uInt64)") }
        if let float =    self as? Float    { return NSString(string: "\(float)") }
        if let double =   self as? Double   { return NSString(string: "\(double)") }
        if let cgFloat =  self as? CGFloat  { return NSString(string: "\(cgFloat)") }
        if let bool =     self as? Bool     { return NSString(string: bool ? Axc_true : Axc_false) }
        if let string =   self as? String   { return NSString(string: string) }
        if let char =     self as? Character{ return NSString(string: "\(char)") }
        if let nsNumber = self as? NSNumber { return NSString(string: nsNumber.stringValue) }
        if let nsString = self as? NSString { return nsString }
        return ""
    }
}

// MARK: UIKit转换
public extension AxcUnifiedNumberTarget {
    
    /// 转换成CGRect
    var axc_cgRect: CGRect { return CGRect(self.axc_cgFloat) }
    /// 转换成CGPoint
    var axc_cgPoint: CGPoint { return CGPoint(self.axc_cgFloat) }
    /// 转换成CGSize
    var axc_cgSize: CGSize { return CGSize(self.axc_cgFloat) }
    
    /// 转换成UIEdgeInsets
    var axc_uiEdge: UIEdgeInsets { return UIEdgeInsets(self.axc_cgFloat) }
    /// 转换成UIEdgeInsets的Top，其他为0
    var axc_uiEdgeTop: UIEdgeInsets      { return UIEdgeInsets(self.axc_cgFloat,0,0,0) }
    /// 转换成UIEdgeInsets的Left，其他为0
    var axc_uiEdgeLeft: UIEdgeInsets     { return UIEdgeInsets(0,self.axc_cgFloat,0,0) }
    /// 转换成UIEdgeInsets的Bottom，其他为0
    var axc_uiEdgeBottom: UIEdgeInsets   { return UIEdgeInsets(0,0,self.axc_cgFloat,0) }
    /// 转换成UIEdgeInsets的Right，其他为0
    var axc_uiEdgeRight: UIEdgeInsets    { return UIEdgeInsets(0,0,0,self.axc_cgFloat) }
}

// MARK: 数据转换
public extension AxcUnifiedNumberTarget {
    /// 秒时间转换成Date对象
    var axc_secondsDate: Date {
        return Date(timeIntervalSince1970: axc_double)
    }
}

// MARK: 数学转换
public extension AxcUnifiedNumberTarget {
    /// 角度转弧度
    var axc_angleToRadian: CGFloat { return .pi * axc_cgFloat / 180.axc_cgFloat }
    /// 弧度转角度
    var axc_radianToAngle: CGFloat { return axc_cgFloat * 180 / .pi }
    
    /// 取几次幂
    func axc_power(_ power: AxcUnifiedNumberTarget) -> CGFloat {
        return pow(self.axc_cgFloat, power.axc_cgFloat)
    }
    /// 求平方根
    var axc_sqrtRoot: CGFloat {
        return sqrt(axc_cgFloat)
    }
    
    /// 绝对值
    var axc_abs: CGFloat { return Swift.abs(axc_cgFloat) }
    /// 向上取整
    var axc_ceil: CGFloat { return Foundation.ceil(axc_cgFloat) }
    /// 向下取整
    var axc_floor: CGFloat { return Foundation.floor(axc_cgFloat) }
    /// 保留小数位数
    func axc_position(_ count: AxcUnifiedNumberTarget) -> String {
        let format = "%.\(count)f"
        return String(format: format, axc_double)
    }
}

// MARK: 其他计算方法
public extension AxcUnifiedNumberTarget {
    /// 不得超过，大于(Int)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  Int      { axc_greaterThanNumberTarget(value).axc_int }
    /// 不得超过，大于(Int8)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  Int8     { axc_greaterThanNumberTarget(value).axc_int8 }
    /// 不得超过，大于(Int16)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  Int16    { axc_greaterThanNumberTarget(value).axc_int16 }
    /// 不得超过，大于(Int32)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  Int32    { axc_greaterThanNumberTarget(value).axc_int32 }
    /// 不得超过，大于(Int64)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  Int64    { axc_greaterThanNumberTarget(value).axc_int64 }
    /// 不得超过，大于(UInt)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  UInt     { axc_greaterThanNumberTarget(value).axc_uint }
    /// 不得超过，大于(UInt8)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  UInt8    { axc_greaterThanNumberTarget(value).axc_uint8 }
    /// 不得超过，大于(UInt16)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  UInt16   { axc_greaterThanNumberTarget(value).axc_uint16 }
    /// 不得超过，大于(UInt32)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  UInt32   { axc_greaterThanNumberTarget(value).axc_uint32 }
    /// 不得超过，大于(UInt64)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  UInt64   { axc_greaterThanNumberTarget(value).axc_uint64 }
    /// 不得超过，大于(Float)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  Float    { axc_greaterThanNumberTarget(value).axc_float }
    /// 不得超过，大于(Double)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  Double   { axc_greaterThanNumberTarget(value).axc_double }
    /// 不得超过，大于(CGFloat)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  CGFloat  { axc_greaterThanNumberTarget(value).axc_cgFloat }
    /// 不得超过，大于(Bool)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  Bool     { axc_greaterThanNumberTarget(value).axc_bool }
    /// 不得超过，大于(String)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  String   { axc_greaterThanNumberTarget(value).axc_string }
    /// 不得超过，大于(NSNumber)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  NSNumber { axc_greaterThanNumberTarget(value).axc_number }
    /// 不得超过，大于(NSString)
    func axc_greaterThan(_ value: AxcUnifiedNumberTarget) ->  NSString { axc_greaterThanNumberTarget(value).axc_nsString }
    /// 不得超过，大于(AxcUnifiedNumberTarget)
    func axc_greaterThanNumberTarget(_ value: AxcUnifiedNumberTarget) -> AxcUnifiedNumberTarget {
        var newValue = self.axc_cgFloat
        if newValue > value.axc_cgFloat { newValue = value.axc_cgFloat }
        return newValue
    }
    
    /// 不得低于，小于(Int)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  Int      { axc_lessThanNumberTarget(value).axc_int }
    /// 不得低于，小于(Int8)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  Int8     { axc_lessThanNumberTarget(value).axc_int8 }
    /// 不得低于，小于(Int16)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  Int16    { axc_lessThanNumberTarget(value).axc_int16 }
    /// 不得低于，小于(Int32)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  Int32    { axc_lessThanNumberTarget(value).axc_int32 }
    /// 不得低于，小于(Int64)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  Int64    { axc_lessThanNumberTarget(value).axc_int64 }
    /// 不得低于，小于(UInt)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  UInt     { axc_lessThanNumberTarget(value).axc_uint }
    /// 不得低于，小于(UInt8)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  UInt8    { axc_lessThanNumberTarget(value).axc_uint8 }
    /// 不得低于，小于(UInt16)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  UInt16   { axc_lessThanNumberTarget(value).axc_uint16 }
    /// 不得低于，小于(UInt32)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  UInt32   { axc_lessThanNumberTarget(value).axc_uint32 }
    /// 不得低于，小于(UInt64)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  UInt64   { axc_lessThanNumberTarget(value).axc_uint64 }
    /// 不得低于，小于(Float)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  Float    { axc_lessThanNumberTarget(value).axc_float }
    /// 不得低于，小于(Double)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  Double   { axc_lessThanNumberTarget(value).axc_double }
    /// 不得低于，小于(CGFloat)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  CGFloat  { axc_lessThanNumberTarget(value).axc_cgFloat }
    /// 不得低于，小于(Bool)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  Bool     { axc_lessThanNumberTarget(value).axc_bool }
    /// 不得低于，小于(String)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  String   { axc_lessThanNumberTarget(value).axc_string }
    /// 不得低于，小于(NSNumber)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  NSNumber { axc_lessThanNumberTarget(value).axc_number }
    /// 不得低于，小于(NSString)
    func axc_lessThan(_ value: AxcUnifiedNumberTarget) ->  NSString { axc_lessThanNumberTarget(value).axc_nsString }
    /// 不得低于，小于(AxcUnifiedNumberTarget)
    func axc_lessThanNumberTarget(_ value: AxcUnifiedNumberTarget) -> AxcUnifiedNumberTarget {
        var newValue = self.axc_cgFloat
        if newValue < value.axc_cgFloat { newValue = value.axc_cgFloat }
        return newValue
    }
}

// MARK: 类方法
public extension AxcUnifiedNumberTarget {
    /// 取随机值
    static func axc_random(_ value: UInt32) -> UInt32 {
        return arc4random() % value
    }
}

// MARK: 运算符
infix operator *^
prefix operator √
extension AxcUnifiedNumberTarget {
    
    /// 取几次幂
    static func *^ (lhs: AxcUnifiedNumberTarget, rhs: AxcUnifiedNumberTarget) -> CGFloat {
        return lhs.axc_power(rhs)
    }
    
    /// 求平方根
    static prefix func √ (rhs: AxcUnifiedNumberTarget) -> CGFloat {
        return rhs.axc_sqrtRoot
    }
}
