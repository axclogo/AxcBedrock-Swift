//
//  AxcBedrock.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/11.
//

/// （💈跨平台标识）字重样式
public typealias AxcBedrockFontWeight = AxcEnum.FontWeight

#if os(macOS)
import AppKit

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit

// public extension AxcBedrockLib {
//    typealias FontWeight = UIFont.Weight
// }

#endif

// MARK: - [AxcBedrockLib.FontWeight]

public extension AxcEnum {
    /// 字重
    enum FontWeight {
        case ultraLight
        case thin
        case light
        case regular
        case medium
        case semibold
        case bold
        case heavy
        case black
    }
}

// MARK: - [AxcBedrockLib.FontWeight]

public extension AxcBedrockFontWeight {
    /// 字重值
    var weightPoint: CGFloat {
        #if os(macOS)
        switch self {
        case .ultraLight: return -0.8
        case .thin: return -0.6
        case .light: return -0.4
        case .regular: return 0.0
        case .medium: return 0.23
        case .semibold: return 0.3
        case .bold: return 0.4
        case .heavy: return 0.56
        case .black: return 0.62
        }

        #elseif os(iOS) || os(tvOS) || os(watchOS)

        switch self {
        case .ultraLight: return UIFont.Weight.ultraLight.rawValue
        case .thin: return UIFont.Weight.thin.rawValue
        case .light: return UIFont.Weight.light.rawValue
        case .regular: return UIFont.Weight.regular.rawValue
        case .medium: return UIFont.Weight.medium.rawValue
        case .semibold: return UIFont.Weight.semibold.rawValue
        case .bold: return UIFont.Weight.bold.rawValue
        case .heavy: return UIFont.Weight.heavy.rawValue
        case .black: return UIFont.Weight.black.rawValue
        }
        #endif
    }
}

// MARK: - AxcBedrockFontWeight + CustomStringConvertible

extension AxcBedrockFontWeight: CustomStringConvertible {
    /// 描述
    public var description: String {
        switch self {
        case .ultraLight: return "UltraLight"
        case .thin: return "Thin"
        case .light: return "Light"
        case .regular: return "Regular"
        case .medium: return "Medium"
        case .semibold: return "Semibold"
        case .bold: return "Bold"
        case .heavy: return "Heavy"
        case .black: return "Black"
        }
    }
}
