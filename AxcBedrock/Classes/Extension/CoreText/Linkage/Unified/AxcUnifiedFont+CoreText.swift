//
//  AxcUnifiedFont+CoreText.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

import CoreText

// MARK: - CTFont + AxcUnifiedFont

extension CTFont: AxcUnifiedFont { }

public extension AxcSpace where Base: AxcUnifiedFont {
    /// 转换成CTFont
    var ctFont: CTFont {
        return ctFont()
    }

    /// 转换成CTFont
    var ctFont_optional: CTFont? {
        return ctFont_optional()
    }

    /// 转换成带字重的CTFont
    func ctFont(weight: AxcBedrockFontWeight = .regular) -> CTFont {
        return CTFont.Axc.Create(base, weight: weight)
    }

    /// 转换成带字重的CTFont可选
    func ctFont_optional(weight: AxcBedrockFontWeight = .regular) -> CTFont? {
        return CTFont.Axc.CreateOptional(base, weight: weight)
    }
}
