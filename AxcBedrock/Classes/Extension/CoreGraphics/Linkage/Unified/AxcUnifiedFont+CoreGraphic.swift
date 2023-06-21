//
//  AxcUnifiedFont+CoreGraphic.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

import CoreGraphics

// MARK: - CGFloat + AxcUnifiedFont

extension CGFloat: AxcUnifiedFont { }

// MARK: - CGFont + AxcUnifiedFont

extension CGFont: AxcUnifiedFont { }

public extension AxcSpace where Base: AxcUnifiedFont {
    /// 转换成CGFont
    var cgFont: CGFont {
        return cgFont()
    }

    /// 转换成CGFont
    var cgFont_optional: CGFont? {
        return cgFont_optional()
    }

    /// 转换成带字重的CGFont 具有默认值
    func cgFont(weight: AxcBedrockFontWeight = .regular) -> CGFont {
        return CGFont.Axc.Create(base, weight: weight)
    }

    /// 转换成带字重的CGFont 可选
    func cgFont_optional(weight: AxcBedrockFontWeight = .regular) -> CGFont? {
        return CGFont.Axc.CreateOptional(base, weight: weight)
    }
}
