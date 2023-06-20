//
//  AxcUIFontEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/4.
//

import UIKit

/// 字体类型
public enum AxcFontType: String {
    case None = ""
    case Regular = "Regular"
    case Bold = "Bold"
    case DemiBold = "DemiBold"
    case Light = "Light"
    case UltraLight = "UltraLight"
    case Italic = "Italic"
    case Thin = "Thin"
    case Book = "Book"
    case Roman = "Roman"
    case Medium = "Medium"
    case MediumItalic = "MediumItalic"
    case CondensedMedium = "CondensedMedium"
    case CondensedExtraBold = "CondensedExtraBold"
    case SemiBold = "SemiBold"
    case BoldItalic = "BoldItalic"
    case Heavy = "Heavy"
}

/// 字体名称枚举
public enum AxcFontName: String {
    case AmericanTypewriter
    case Avenir
    case AvenirNext
    case Baskerville
    case Didot
    case Futura
    case Geneva
    case GillSans
    case HelveticaNeue
    case Helvetica
    case Menlo
    case PingFang_SC = "PingFang-SC"
    case SanFranciscoDisplay
    case Seravek
}
// MARK: - 类方法/属性
public extension UIFont {
    /// PingFang_SC
    static func axc_pingFang_SC(type: AxcFontType, size: CGFloat) -> UIFont {
        return axc_font(.PingFang_SC, type: type, size: size)
    }
    /// HelveticaNeue
    static func axc_helveticaNeue(type: AxcFontType, size: CGFloat) -> UIFont {
        return axc_font(.HelveticaNeue, type: type, size: size)
    }
    /// AvenirNext
    static func axc_avenirNext(type: AxcFontType, size: CGFloat) -> UIFont {
        return axc_font(.AvenirNext, type: type, size: size)
    }
    /// AvenirNext Bold
    static func axc_avenirNextDemiBold(size: CGFloat) -> UIFont {
        return axc_font(.AvenirNext, type: .DemiBold, size: size)
    }
    /// AvenirNext Regular
    static func axc_avenirNextRegular(size: CGFloat) -> UIFont {
        return axc_font(.AvenirNext, type: .Regular, size: size)
    }
    /// 实例化一个字体
    /// - Parameters:
    ///   - name: 字体名称
    ///   - type: 类型
    ///   - size: 大小
    /// - Returns: 字体
    static func axc_font(_ name: AxcFontName, type: AxcFontType, size: CGFloat) -> UIFont! {
        let fontName = name.rawValue + "-" + type.rawValue
        if let font = UIFont(name: fontName, size: size) {  // 使用类型
            return font
        }
        let fontNameNone = name.rawValue
        if let font = UIFont(name: fontNameNone, size: size) {
            return font
        }
        let fontNameRegular = name.rawValue + "-" + AxcFontType.Regular.rawValue
        if let font = UIFont(name: fontNameRegular, size: size) {
            return font
        }
        return nil
    }
}

// MARK: - 属性 & Api
public extension UIFont {
    /// 设置字重
    /// - Parameter weight: 字重
    /// - Returns: 字体
    func axc_setWeight(_ weight: UIFont.Weight) -> UIFont {
        return UIFont.systemFont(ofSize: pointSize, weight: weight)
    }
    
    /// 设置字体特征
    /// - Parameter traits: 特征
    /// - Returns: 字体
    func axc_setTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        var descriptor = fontDescriptor
        if let _descriptor = fontDescriptor.withSymbolicTraits(traits) {
            descriptor = _descriptor
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
    
}

// MARK: - 【对象特性扩展区】
public extension UIFont {
}

// MARK: - 决策判断
public extension UIFont {
    // MARK: 协议
    // MARK: 扩展
}

// MARK: - 操作符
public extension UIFont {
}

// MARK: - 运算符
public extension UIFont {
}
