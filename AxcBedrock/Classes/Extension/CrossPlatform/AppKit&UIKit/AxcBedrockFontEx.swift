//
//  AxcBedrock.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/11.
//

#if os(macOS)
import AppKit

/// （💈跨平台标识）字体类型
public typealias AxcBedrockFont = NSFont

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit

/// （💈跨平台标识）字体类型
public typealias AxcBedrockFont = UIFont
#endif

// MARK: - 数据转换

public extension AxcSpace where Base: AxcBedrockFont { }

// MARK: - 类方法

public extension AxcSpace where Base: AxcBedrockFont {
    /// （💈跨平台标识）配合协议用创建方法 具有默认值
    static func Create(_ unifiedValue: AxcUnifiedFont?,
                       weight: AxcBedrockFontWeight = .regular) -> AxcBedrockFont {
        return CreateOptional(unifiedValue, weight: weight) ?? .init()
    }

    /// （💈跨平台标识）配合协议用创建方法 可选
    static func CreateOptional(_ unifiedValue: AxcUnifiedFont?,
                               weight: AxcBedrockFontWeight = .regular) -> AxcBedrockFont? {
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

        if let fontPoint = fontPoint,
           let fontSize = CGFloat.Axc.CreateOptional(fontPoint) {
            return AxcBedrockFont.Axc.SystemFont(ofSize: fontSize, weight: weight)

        } else if let font = unifiedValue as? AxcBedrockFont {
            return font

        } else if let cgFont = AxcBedrockLib.Func.CFType(unifiedValue, as: CGFont.self),
                  let name = cgFont.postScriptName?.axc.string,
                  let fontSize = CGFloat.Axc.CreateOptional(fontPoint) {
            let font = AxcBedrockFont(name: name, size: fontSize)?.axc.weight(weight)
            return font

        } else if let ctFont = AxcBedrockLib.Func.CFType(unifiedValue, as: CTFont.self) {
            var fontName = ctFont.axc.postScriptName
            // 需要移除点，UIFont在创建声明名称时不需要写明.
            fontName = fontName.axc.removePrefix(string: ".")
            /*
             CoreText note: Client requested name ".SFUI-Regular", it will get TimesNewRomanPSMT rather than the intended font.
             All system UI font access should be through proper APIs such as CTFontCreateUIFontForLanguage() or +[UIFont systemFontOfSize:].
             */
            // SF的系统字体尽量用[UIFont systemFontOfSize:]、CTFontCreateUIFontForLanguage()这种方法创建，
            // 而不要用[UIFont fontWithName:fontName size:fontSize]、 CTFontCreateWithName这种方法创建，iOS13之后会有问题
            if #available(iOS 13.0, *), fontName.contains("SFUI") {
                return AxcBedrockFont.Axc.SystemFont(ofSize: ctFont.axc.fontSize, weight: weight)

            } else {
                // 该方法在创建系统SFUI系列字体时，iOS13以上可能会出问题
                if var platformFont = AxcBedrockFont(name: fontName, size: ctFont.axc.fontSize) {
                    platformFont = platformFont.axc.weight(weight) // 配置字重
                    return platformFont
                } else {
                    return AxcBedrockFont.Axc.SystemFont(ofSize: ctFont.axc.fontSize, weight: weight)
                }
            }
        }
        return nil
    }

    /// （💈跨平台标识）跨平台创建方法
    /// - Parameters:
    ///   - fontSize: 字号
    ///   - weight: 字重
    /// - Returns: 字体
    static func SystemFont(ofSize: CGFloat,
                           weight: AxcBedrockFontWeight = .regular) -> AxcBedrockFont {
        #if os(macOS)
        var descriptor = NSFont.systemFont(ofSize: ofSize).fontDescriptor
        descriptor = descriptor.addingAttributes([
            NSFontDescriptor.AttributeName.traits: [
                NSFontDescriptor.TraitKey.weight: weight.weightPoint,
            ],
        ])
        return NSFont(descriptor: descriptor, size: ofSize)!

        #elseif os(iOS) || os(tvOS) || os(watchOS)

        let weight: UIFont.Weight = UIFont.Weight(rawValue: weight.weightPoint)
        return UIFont.systemFont(ofSize: ofSize, weight: weight)
        #endif
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: AxcBedrockFont {
    /// （💈跨平台标识）设置字重
    /// - Parameter weight: 字重
    /// - Returns: 字体
    func weight(_ weight: AxcBedrockFontWeight) -> AxcBedrockFont {
        return AxcBedrockFont.Axc.SystemFont(ofSize: base.pointSize,
                                           weight: weight)
    }

    /// （💈跨平台标识）设置字体特征
    /// - Parameter traits: 特征
    /// - Returns: 字体
    func traits(_ traits: AxcFontDescriptorSymbolicTraits) -> AxcBedrockFont {
        var descriptor = base.fontDescriptor
        #if os(macOS)
        let des = NSFontDescriptor.SymbolicTraits(rawValue: traits.symbolicTraits)
        descriptor = base.fontDescriptor.withSymbolicTraits(des)
        return AxcBedrockFont(descriptor: descriptor, size: 0) ?? base

        #elseif os(iOS) || os(tvOS) || os(watchOS)

        if let _descriptor = base.fontDescriptor.withSymbolicTraits(traits) {
            descriptor = _descriptor
        }
        return AxcBedrockFont(descriptor: descriptor, size: 0)
        #endif
    }

    /// （💈跨平台标识）特征
    var symbolicTraits: AxcFontDescriptorSymbolicTraits {
        #if os(macOS)
        return AxcFontDescriptorSymbolicTraits(symbolicTraits: base.fontDescriptor.symbolicTraits.rawValue)
        #elseif os(iOS) || os(tvOS) || os(watchOS)
        return base.fontDescriptor.symbolicTraits
        #endif
    }

    /// （💈跨平台标识）等宽数字字体
    var monospacedNumbersFont: AxcBedrockFont {
        #if os(macOS)
        let fontDescriptor = base.fontDescriptor.addingAttributes([
            NSFontDescriptor.AttributeName.featureSettings: [
                [
                    NSFontDescriptor.FeatureKey.typeIdentifier: kNumberSpacingType,
                    NSFontDescriptor.FeatureKey.selectorIdentifier: kMonospacedNumbersSelector,
                ],
            ],
        ])
        return AxcBedrockFont(descriptor: fontDescriptor, size: base.pointSize) ?? base

        #elseif os(watchOS)

        let fontDescriptor = UIFontDescriptor(name: base.fontName, size: base.pointSize)
            .addingAttributes([
                UIFontDescriptor.AttributeName.featureSettings: [
                    [
                        UIFontDescriptor.FeatureKey.featureIdentifier: 6,
                        UIFontDescriptor.FeatureKey.typeIdentifier: 0,
                    ],
                ],
            ])
        return AxcBedrockFont(descriptor: fontDescriptor, size: base.pointSize)

        #else

        let fontDescriptor = UIFontDescriptor(name: base.fontName, size: base.pointSize)
            .addingAttributes([
                UIFontDescriptor.AttributeName.featureSettings: [
                    [
                        UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
                        UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector,
                    ],
                ],
            ])
        return AxcBedrockFont(descriptor: fontDescriptor, size: base.pointSize)
        #endif
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: AxcBedrockFont { }
