//
//  _AxcAssertUnifiedTransformTarget+Platform.swift
//  Kanna
//
//  Created by 赵新 on 2023/2/28.
//

#if os(macOS)
import AppKit

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit
#endif

extension AxcAssertUnifiedTransformTarget {
    /// （💈跨平台标识）设置颜色相关
    func assertTransformColor(_ color: AxcUnifiedColor) -> AxcBedrockColor {
        return Self.AssertTransformColor(color)
    }

    /// （💈跨平台标识）设置颜色相关
    static func AssertTransformColor(_ color: AxcUnifiedColor) -> AxcBedrockColor {
        guard let color = AxcBedrockColor.Axc.CreateOptional(color) else {
            AxcBedrockLib.Log(FailureContent)
            #if DEBUG
            AxcBedrockLib.FatalLog(FailureContent)
            #else
            return .black
            #endif
        }
        return color
    }
}

extension AxcAssertUnifiedTransformTarget {
    /// （💈跨平台标识）设置字体相关
    func assertTransformFont(_ font: AxcUnifiedFont) -> AxcBedrockFont {
        return Self.AssertTransformFont(font)
    }

    /// （💈跨平台标识）设置字体相关
    static func AssertTransformFont(_ font: AxcUnifiedFont) -> AxcBedrockFont {
        guard let font = AxcBedrockFont.Axc.CreateOptional(font) else {
            AxcBedrockLib.Log(FailureContent)
            #if DEBUG
            AxcBedrockLib.FatalLog(FailureContent)
            #else
            return AssertTransformFont(16)
            #endif
        }
        return font
    }
}
