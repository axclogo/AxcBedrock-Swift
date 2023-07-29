//
//  AxcCTFontEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

import CoreText
import Foundation

// MARK: - CTFont + AxcSpaceProtocol

extension CTFont: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base: CTFont { }

// MARK: - 类方法

public extension AxcSpace where Base: CTFont {
    /// 配合协议用创建方法 具有默认值
    static func Create(_ unifiedValue: AxcUnifiedFont?,
                       weight: AxcBedrockFontWeight = .regular) -> CTFont {
        #if os(macOS)
        return CTFont.Axc.CreateOptional(unifiedValue, weight: weight) ?? CTFont("".axc.cfString, size: 12)
        #elseif os(iOS) || os(tvOS) || os(watchOS)
        return CTFont.Axc.CreateOptional(unifiedValue, weight: weight) ?? CTFont("".axc.cfString, size: 12)
        #endif
    }

    /// 配合协议用创建方法 可选
    static func CreateOptional(_ unifiedValue: AxcUnifiedFont?,
                               weight: AxcBedrockFontWeight = .regular) -> CTFont? {
        guard let unifiedValue = unifiedValue else { return nil }
        var fontPoint: AxcUnifiedNumber?
        if let int = unifiedValue as? Int { fontPoint = int } else
        if let int8 = unifiedValue as? Int8 { fontPoint = int8 } else
        if let int16 = unifiedValue as? Int16 { fontPoint = int16 } else
        if let int32 = unifiedValue as? Int32 { fontPoint = int32 } else
        if let int64 = unifiedValue as? Int64 { fontPoint = int64 } else
        if let uInt = unifiedValue as? UInt { fontPoint = uInt } else
        if let uInt8 = unifiedValue as? UInt8 { fontPoint = uInt8 } else
        if let uInt16 = unifiedValue as? UInt16 { fontPoint = uInt16 } else
        if let uInt32 = unifiedValue as? UInt32 { fontPoint = uInt32 } else
        if let uInt64 = unifiedValue as? UInt64 { fontPoint = uInt64 } else
        if let float = unifiedValue as? Float { fontPoint = float } else
        if let double = unifiedValue as? Double { fontPoint = double } else
        if let cgFloat = unifiedValue as? CGFloat { fontPoint = cgFloat } else
        if let string = unifiedValue as? String { fontPoint = string } else
        if let char = unifiedValue as? Character { fontPoint = char } else
        if let nsNumber = unifiedValue as? NSNumber { fontPoint = nsNumber } else
        if let nsString = unifiedValue as? NSString { fontPoint = nsString }

        if let fontPoint,
           let fontSize = CGFloat.Axc.CreateOptional(fontPoint) {
            return CTFontCreate(size: fontSize, name: ".SFUI-Regular")

        } else if let fontPoint,
                  let platformFont = unifiedValue as? AxcBedrockFont {
            let fontSize = AssertTransformCGFloat(fontPoint)
            return CTFontCreate(size: fontSize, name: platformFont.fontName)

        } else if let fontPoint = fontPoint,
                  let cgFont = AxcBedrockLib.Func.CFType(unifiedValue, as: CGFont.self),
                  let name = cgFont.postScriptName?.axc.string {
            let fontSize = AssertTransformCGFloat(fontPoint)
            return CTFontCreate(size: fontSize, name: name)

        } else if let ctFont = AxcBedrockLib.Func.CFType(unifiedValue, as: CTFont.self) {
            return ctFont
        }
        return nil
    }

    private static func CTFontCreate(size: CGFloat, name: String) -> CTFont? {
        /*
         CoreText note: Client requested name ".SFUI-Regular", it will get TimesNewRomanPSMT rather than the intended font.
         All system UI font access should be through proper APIs such as CTFontCreateUIFontForLanguage() or +[UIFont systemFontOfSize:].
         */
        // SF的系统字体尽量用[UIFont systemFontOfSize:]、CTFontCreateUIFontForLanguage()这种方法创建，
        // 而不要用[UIFont fontWithName:fontName size:fontSize]、 CTFontCreateWithName这种方法创建，iOS13之后会有问题
        if #available(iOS 13.0, *), name.contains("SFUI") {
            return CTFontCreateUIFontForLanguage(CTFontUIFontType.user, size, nil)
        } else {
            // 该方法在创建系统SFUI系列字体时，iOS13以上可能会出问题
            return CTFontCreateWithName(name.axc.cfString,
                                        size, nil)
        }
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: CTFont { }

// MARK: - 属性获取

public extension AxcSpace where Base: CTFont {
    /*
     示例：
     字体文件名称      FZHTJW.ttf
     PostScript 名称  FZHTJW--GB1-0
     全名             方正黑体简体/FZHei-B01S
     系列             方正黑体简体/FZHei-B01S
     样式             常规体/Regular
     */

    /// PostScript 名
    var postScriptName: String {
        return CTFontCopyPostScriptName(base).axc.string
    }

    /// 即字体族名称，名称取决于字体文件定义，如 "Helvetica"、"微软雅黑"
    /// 对于中文字体，为了兼容性推荐使用英文字体族名称，如微软雅黑，应使用 "Microsoft YaHei"
    /// 如果字体族名称中包含空格，需要加上引号（CSS 中单引号、双引号都可以使用）
    var familyName: String {
        return CTFontCopyFamilyName(base).axc.string
    }

    /// 全名
    var fullName: String {
        return CTFontCopyFullName(base).axc.string
    }

    /// 字号
    var fontSize: CGFloat {
        return CTFontGetSize(base)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: CTFont { }
