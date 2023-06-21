//
//  AxcUnifiedString.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/21.
//

import Foundation

// MARK: 字符串统一互转协议
public protocol AxcUnifiedString: AxcUnifiedNumber { }
extension Int:          AxcUnifiedString {}
extension Int8:         AxcUnifiedString {}
extension Int16:        AxcUnifiedString {}
extension Int32:        AxcUnifiedString {}
extension Int64:        AxcUnifiedString {}

extension UInt:         AxcUnifiedString {}
extension UInt8:        AxcUnifiedString {}
extension UInt16:       AxcUnifiedString {}
extension UInt32:       AxcUnifiedString {}
extension UInt64:       AxcUnifiedString {}

extension Float:        AxcUnifiedString {}
extension Double:       AxcUnifiedString {}
extension CGFloat:      AxcUnifiedString {}
extension Bool:         AxcUnifiedString {}

extension String:       AxcUnifiedString {}
extension Substring:    AxcUnifiedString {}
extension Character:    AxcUnifiedString {}

extension NSString:             AxcUnifiedString {}
extension CFString:             AxcUnifiedString {}
extension NSAttributedString:   AxcUnifiedString {}

extension URL:  AxcUnifiedString {}
extension Data: AxcUnifiedString {}
extension Date: AxcUnifiedString {}

// MARK: 数据转换扩展

public extension AxcSpace where Base: AxcUnifiedString {
    /// 转换String类型
    var string: String {
        return .Axc.Create(base)
    }

    /// 转换String类型
    var string_optional: String? {
        return .Axc.CreateOptional(base)
    }

    /// 转换富文本
    var attributedStr: NSAttributedString {
        return .Axc.Create(base)
    }

    /// 转换富文本
    var attributedStr_optional: NSAttributedString? {
        return .Axc.CreateOptional(base)
    }

    /// 转换NSString类型
    var nsString: NSString {
        return string as NSString
    }
}
