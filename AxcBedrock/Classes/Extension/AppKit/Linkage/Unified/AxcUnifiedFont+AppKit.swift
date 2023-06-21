//
//  AxcUnifiedFont+UIKit.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/21.
//

#if canImport(AppKit)

import AppKit

// MARK: - NSFont + AxcUnifiedFont

extension NSFont: AxcUnifiedFont { }

public extension AxcSpace where Base: AxcUnifiedFont {
    /// 转换成NSFont 具有默认值
    var nsFont: NSFont {
        return nsFont()
    }

    /// 转换成NSFont 可选
    var nsFont_optional: NSFont? {
        return nsFont()
    }

    /// 转换成带字重的NSFont 具有默认值
    func nsFont(weight: AxcBedrockFontWeight = .regular) -> NSFont {
        return NSFont.Axc.Create(base, weight: weight)
    }

    /// 转换成带字重的NSFont 可选
    func nsFont_optional(weight: AxcBedrockFontWeight = .regular) -> NSFont? {
        return NSFont.Axc.CreateOptional(base, weight: weight)
    }

    /// 转换成三方字体的NSFont 具有默认值
    func nsFont(name: String) -> NSFont {
        return nsFont_optional(name: name) ?? NSFont.systemFont(ofSize: 16)
    }

    /// 转换成三方字体的NSFontt 可选
    func nsFont_optional(name: String) -> NSFont? {
        if let number = base as? AxcUnifiedNumber {
            return NSFont(name: name, size: CGFloat.Axc.Create(number))
        } else {
            return nil
        }
    }
}

#endif
