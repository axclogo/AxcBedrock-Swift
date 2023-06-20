//
//  AxcUnifiedStringTarget.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/7/13.
//

import UIKit

// MARK: 字符串统一互转协议
public protocol AxcUnifiedStringTarget: AxcUnifiedNumberTarget { }
extension URL:          AxcUnifiedStringTarget {}
extension Data:         AxcUnifiedStringTarget {}
extension Date:         AxcUnifiedStringTarget {}
extension UIColor:      AxcUnifiedStringTarget {}
extension IndexPath:    AxcUnifiedStringTarget {}
extension CGRect:       AxcUnifiedStringTarget {}
extension CGSize:       AxcUnifiedStringTarget {}
extension CGPoint:      AxcUnifiedStringTarget {}
extension CFString:     AxcUnifiedStringTarget {}
extension String:       AxcUnifiedStringTarget {}
extension Substring:       AxcUnifiedStringTarget {}
extension NSAttributedString:   AxcUnifiedStringTarget {}

// MARK: 数据转换扩展
public extension AxcUnifiedStringTarget {
    /// 转换String类型
    var axc_string: String {
        var _string = ""
        if let url =        self as? URL        { _string = url.absoluteString }
        if let data =       self as? Data       { _string = data.axc_string() ?? "" }
        if let date =       self as? Date       { _string = date.axc_string() }
        if let uiColor =    self as? UIColor    { _string = uiColor.axc_string() }
        if let indexPath =  self as? IndexPath  { _string = "\(indexPath.section)-\(indexPath.row)" }
        if let cgRect =     self as? CGRect     { _string = "\(cgRect.axc_x)-\(cgRect.axc_y)-\(cgRect.axc_width)-\(cgRect.axc_height)" }
        if let cgSize =     self as? CGSize     { _string = "\(cgSize.width)-\(cgSize.height)" }
        if let cgPoint =    self as? CGPoint    { _string = "\(cgPoint.x)-\(cgPoint.y)" }
        if let string =     self as? String     { _string = string }
        if let subString =  self as? Substring  { _string = String(subString) }
        if let cfString =           AxcCFType(self, as: CFString.self)          { _string = cfString as String }
        if let cfMutableString =    AxcCFType(self, as: CFMutableString.self)   { _string = cfMutableString as String }
        if let nsMutableString =    self as? NSMutableString                    { _string = nsMutableString as String }
        if let nsAttString =        self as? NSAttributedString                 { _string = nsAttString.string }
        if let nsMutableAttString = self as? NSMutableAttributedString          { _string = nsMutableAttString.string }
        return _string
    }
    
    /// 转换NSString类型
    var axc_nsString: NSString {
        return axc_string as NSString
    }
    
    /// 转换成富文本
    var axc_attributedString : NSAttributedString {
        if let attStr = self as? NSAttributedString             { return attStr }
        if let attStr_M = self as? NSMutableAttributedString    { return attStr_M }
        return axc_string.axc_attributedStr
    }
}
