//
//  AxcUnifiedFontTarget.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/5/15.
//

import UIKit
import CoreGraphics

// MARK: 字体统一互转协议
public protocol AxcUnifiedFontTarget: AxcUnifiedNumberTarget {}
extension Int:          AxcUnifiedFontTarget {}
extension Int8:         AxcUnifiedFontTarget {}
extension Int16:        AxcUnifiedFontTarget {}
extension Int32:        AxcUnifiedFontTarget {}
extension Int64:        AxcUnifiedFontTarget {}
extension UInt:         AxcUnifiedFontTarget {}
extension UInt8:        AxcUnifiedFontTarget {}
extension UInt16:       AxcUnifiedFontTarget {}
extension UInt32:       AxcUnifiedFontTarget {}
extension UInt64:       AxcUnifiedFontTarget {}
extension Float:        AxcUnifiedFontTarget {}
extension Double:       AxcUnifiedFontTarget {}
extension CGFloat:      AxcUnifiedFontTarget {}
extension Bool:         AxcUnifiedFontTarget {}
extension String:       AxcUnifiedFontTarget {}
extension Character:    AxcUnifiedFontTarget {}
extension NSNumber:     AxcUnifiedFontTarget {}
extension NSString:     AxcUnifiedFontTarget {}
extension UIFont:       AxcUnifiedFontTarget {}
extension CGFont:       AxcUnifiedFontTarget {}
extension CTFont:       AxcUnifiedFontTarget {}

public extension AxcUnifiedFontTarget {
    /// 转换成CTFont
    var axc_ctFont: CTFont {
        return axc_ctFont(weight: .regular)
    }
    /// 转换成带字重的CTFont
    func axc_ctFont(weight: UIFont.Weight) -> CTFont {
        let font = axc_font(weight: weight)
        return CTFontCreateWithName(font.fontName.axc_cfString, font.pointSize, nil)
    }
    
    /// 转换成CGFont
    var axc_cgFont: CGFont? {
        return axc_cgFont(weight: .regular)
    }
    /// 转换成带字重的CGFont 不一定成功
    func axc_cgFont(weight: UIFont.Weight) -> CGFont? {
        return CGFont(axc_font(weight: weight).fontName.axc_cfString)
    }
    
    /// 转换成UIFont
    var axc_font: UIFont {
        return axc_font(weight: .regular)
    }
    /// 转换成带字重的UIFont
    func axc_font(weight: UIFont.Weight) -> UIFont {
        var fontPoint: AxcUnifiedNumberTarget = 0
        var _font = UIFont()
        if let int =      self as? Int      { fontPoint = int }
        if let int8 =     self as? Int8     { fontPoint = int8 }
        if let int16 =    self as? Int16    { fontPoint = int16 }
        if let int32 =    self as? Int32    { fontPoint = int32 }
        if let int64 =    self as? Int64    { fontPoint = int64 }
        if let uInt =     self as? UInt     { fontPoint = uInt }
        if let uInt8 =    self as? UInt8    { fontPoint = uInt8 }
        if let uInt16 =   self as? UInt16   { fontPoint = uInt16 }
        if let uInt32 =   self as? UInt32   { fontPoint = uInt32 }
        if let uInt64 =   self as? UInt64   { fontPoint = uInt64 }
        if let float =    self as? Float    { fontPoint = float }
        if let double =   self as? Double   { fontPoint = double }
        if let cgFloat =  self as? CGFloat  { fontPoint = cgFloat }
        if let bool =     self as? Bool     { fontPoint = bool }
        if let string =   self as? String   { fontPoint = string }
        if let char =     self as? Character{ fontPoint = char }
        if let nsNumber = self as? NSNumber { fontPoint = nsNumber }
        if let nsString = self as? NSString { fontPoint = nsString }
        if let font =     self as? UIFont   { return font }
        _font = UIFont.systemFont(ofSize: fontPoint.axc_cgFloat, weight: weight)
        if let cgFont = AxcCFType(self, as: CGFont.self),
           let name = cgFont.postScriptName?.axc_string,
           let font = UIFont(name: name, size: 12)?.axc_setWeight(weight) {
            return font
        }
        if let ctFont = AxcCFType(self, as: CTFont.self),
           var name = CTFontCopyName(ctFont, kCTFontPostScriptNameKey)?.axc_string{
            name = name.axc_removePrefix(".")
            if let font = UIFont(name: name, size: CTFontGetSize(ctFont))?.axc_setWeight(weight){
                return font
            }else{
                return .systemFont(ofSize: CTFontGetSize(ctFont), weight: weight)
            }
        }
        return _font
    }
    
    /// 转换成三方字体的UIFont
    func axc_font(name: String) -> UIFont {
        return UIFont(name: name, size: self.axc_cgFloat) ?? axc_font
    }
}
