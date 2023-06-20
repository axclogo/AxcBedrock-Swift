//
//  AxcUnifiedColorTarget.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/5/15.
//

import UIKit

// MARK: 颜色统一互转协议
public protocol AxcUnifiedColorTarget {}
extension Int:          AxcUnifiedColorTarget {}
extension Int8:         AxcUnifiedColorTarget {}
extension Int16:        AxcUnifiedColorTarget {}
extension Int32:        AxcUnifiedColorTarget {}
extension Int64:        AxcUnifiedColorTarget {}
extension UInt:         AxcUnifiedColorTarget {}
extension UInt8:        AxcUnifiedColorTarget {}
extension UInt16:       AxcUnifiedColorTarget {}
extension UInt32:       AxcUnifiedColorTarget {}
extension UInt64:       AxcUnifiedColorTarget {}
extension UIColor:      AxcUnifiedColorTarget {}
extension CGColor:      AxcUnifiedColorTarget {}
extension CIColor:      AxcUnifiedColorTarget {}
extension String:       AxcUnifiedColorTarget {}
extension NSString:     AxcUnifiedColorTarget {}

public extension AxcUnifiedColorTarget {
    /// 获取这个十六进制字符串的CIColor
    var axc_ciColor: CIColor {
        return axc_ciColor()
    }
    /// 获取这个十六进制字符串的CIColor
    /// - Parameter alpha: 透明度
    /// - Returns: CIColor
    func axc_ciColor(_ alpha: AxcUnifiedNumberTarget = 1) -> CIColor {
        return axc_color(alpha).ciColor
    }
    
    /// 获取这个十六进制字符串的CGColor
    var axc_cgColor: CGColor {
        return axc_cgColor()
    }
    /// 获取这个十六进制字符串的CGColor
    /// - Parameter alpha: 透明度
    /// - Returns: CGColor
    func axc_cgColor(_ alpha: AxcUnifiedNumberTarget = 1) -> CGColor {
        return axc_color(alpha).cgColor
    }
    
    /// 获取这个对象的十六进制颜色
    var axc_color: UIColor {
        return axc_color()
    }
    /// 转换颜色颜色
    /// - Parameter alpha: 透明度
    /// - Returns: UIColor
    func axc_color(_ alpha: AxcUnifiedNumberTarget = 1) -> UIColor {
        var _color = UIColor.clear
        if let int =      self as? Int      { _color = UIColor(hexInt: int) }
        if let int8 =     self as? Int8     { _color = UIColor(hexInt: int8.axc_int) }
        if let int16 =    self as? Int16    { _color = UIColor(hexInt: int16.axc_int) }
        if let int32 =    self as? Int32    { _color = UIColor(hexInt: int32.axc_int) }
        if let int64 =    self as? Int64    { _color = UIColor(hexInt: int64.axc_int) }
        if let uInt =     self as? UInt     { _color = UIColor(hexInt: uInt.axc_int) }
        if let uInt8 =    self as? UInt8    { _color = UIColor(hexInt: uInt8.axc_int) }
        if let uInt16 =   self as? UInt16   { _color = UIColor(hexInt: uInt16.axc_int) }
        if let uInt32 =   self as? UInt32   { _color = UIColor(hexInt: uInt32.axc_int) }
        if let uInt64 =   self as? UInt64   { _color = UIColor(hexInt: uInt64.axc_int) }
        if let color =    self as? UIColor  { _color = color }
        if let cgColor = AxcCFType(self, as: CGColor.self )  { _color = UIColor(cgColor: cgColor ) }
        if let ciColor =  self as? CIColor  { _color = UIColor(ciColor: ciColor) }
        if let string =   self as? String   { _color = UIColor(hexStr: string) }
        if let nsString = self as? NSString { _color = UIColor(hexStr: nsString.axc_string) }
        if alpha.axc_cgFloat != 1 { _color = _color.axc_alpha(alpha) } // 优化透明度计算
        return _color
    }
}

/**
// MARK: - 颜色扩展
public extension AxcUnifiedColorTarget {
    // MARK: 纯值颜色
    /// 0.0 white
    static var axc_black: UIColor { return .black }
    /// 0.333 white
    static var axc_darkGray: UIColor { return .darkGray }
    /// 0.667 white
    static var axc_lightGray: UIColor { return .lightGray }
    /// 1.0 white
    static var axc_white: UIColor { return .white }
    /// 0.5 white
    static var axc_gray: UIColor { return .gray }
    /// 1.0, 0.0, 0.0 RGB
    static var axc_red: UIColor { return .red }
    /// 0.0, 1.0, 0.0 RGB
    static var axc_green: UIColor { return .green }
    /// 0.0, 0.0, 1.0 RGB
    static var axc_blue: UIColor { return .blue }
    /// 0.0, 1.0, 1.0 RGB
    static var axc_cyan: UIColor { return .cyan }
    /// 1.0, 1.0, 0.0 RGB
    static var axc_yellow: UIColor { return .yellow }
    /// 1.0, 0.0, 1.0 RGB
    static var axc_magenta: UIColor { return .magenta }
    /// 1.0, 0.5, 0.0 RGB
    static var axc_orange: UIColor { return .orange }
    /// 0.5, 0.0, 0.5 RGB
    static var axc_purple: UIColor { return .purple }
    /// 0.6, 0.4, 0.2 RGB
    static var axc_brown: UIColor { return .brown }
    /// 0.0 white, 0.0 alpha
    static var axc_clear: UIColor { return .clear }
    /// 对于黑暗的背景
    static var axc_lightText: UIColor { return .lightText }
    /// 对于灯光背景
    static var axc_darkText: UIColor { return .darkText }
    
    // MARK: 系统颜色
    /// 系统红
    static var axc_systemRed: UIColor { return .systemRed }
    /// 系统绿
    static var axc_systemGreen: UIColor { return .systemGreen }
    /// 系统蓝
    static var axc_systemBlue: UIColor { return .systemBlue }
    /// 系统橘
    static var axc_systemOrange: UIColor { return .systemOrange }
    /// 系统黄
    static var axc_systemYellow: UIColor { return .systemYellow }
    /// 系统粉
    static var axc_systemPink: UIColor { return .systemPink }
    /// 系统紫
    static var axc_systemPurple: UIColor { return .systemPurple }
    /// 系统天蓝
    static var axc_systemTeal: UIColor { return .systemTeal }
    /// 系统靛蓝
    @available(iOS 13.0, *)
    static var axc_systemIndigo: UIColor { return .systemIndigo }
    /// 系统灰
    static var axc_systemGray: UIColor { return .systemGray }
    /// 系统灰2
    @available(iOS 13.0, *)
    static var axc_systemGray2: UIColor { return .systemGray2 }
    /// 系统灰3
    @available(iOS 13.0, *)
    static var axc_systemGray3: UIColor { return .systemGray3 }
    /// 系统灰4
    @available(iOS 13.0, *)
    static var axc_systemGray4: UIColor { return .systemGray4 }
    /// 系统灰5
    @available(iOS 13.0, *)
    static var axc_systemGray5: UIColor { return .systemGray5 }
    /// 系统灰6
    @available(iOS 13.0, *)
    static var axc_systemGray6: UIColor { return .systemGray6 }

    // MARK: 其他颜色
    @available(iOS 13.0, *)
    static var axc_label: UIColor { return .label }

    @available(iOS 13.0, *)
    static var axc_secondaryLabel: UIColor { return .secondaryLabel }

    @available(iOS 13.0, *)
    static var axc_tertiaryLabel: UIColor { return .tertiaryLabel }

    @available(iOS 13.0, *)
    static var axc_quaternaryLabel: UIColor { return .quaternaryLabel }

    @available(iOS 13.0, *)
    static var axc_link: UIColor { return .link }

    @available(iOS 13.0, *)
    static var axc_placeholderText: UIColor { return .placeholderText }

    @available(iOS 13.0, *)
    static var axc_separator: UIColor { return .separator }

    @available(iOS 13.0, *)
    static var axc_opaqueSeparator: UIColor { return .opaqueSeparator }

    @available(iOS 13.0, *)
    static var axc_systemBackground: UIColor { return .systemBackground }

    @available(iOS 13.0, *)
    static var axc_secondarySystemBackground: UIColor { return .secondarySystemBackground }

    @available(iOS 13.0, *)
    static var axc_tertiarySystemBackground: UIColor { return .tertiarySystemBackground }

    @available(iOS 13.0, *)
    static var axc_systemGroupedBackground: UIColor { return .systemGroupedBackground }

    @available(iOS 13.0, *)
    static var axc_secondarySystemGroupedBackground: UIColor { return .secondarySystemGroupedBackground }

    @available(iOS 13.0, *)
    static var axc_tertiarySystemGroupedBackground: UIColor { return .tertiarySystemGroupedBackground }

    @available(iOS 13.0, *)
    static var axc_systemFill: UIColor { return .systemFill }

    @available(iOS 13.0, *)
    static var axc_secondarySystemFill: UIColor { return .secondarySystemFill }

    @available(iOS 13.0, *)
    static var axc_tertiarySystemFill: UIColor { return .tertiarySystemFill }

    @available(iOS 13.0, *)
    static var axc_quaternarySystemFill: UIColor { return .quaternarySystemFill }

    @available(iOS, introduced: 2.0, deprecated: 13.0)
    static var axc_groupTableViewBackground: UIColor { return .groupTableViewBackground }
}
*/
