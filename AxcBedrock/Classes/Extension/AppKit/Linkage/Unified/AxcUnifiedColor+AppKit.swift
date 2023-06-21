//
//  AxcUnifiedColor+AppKit.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

#if canImport(AppKit)

import AppKit

extension NSColor: AxcUnifiedColor { }

public extension AxcSpace where Base: AxcUnifiedColor {
    /// 转换NSColor颜色 具有默认值
    var nsColor: NSColor {
        return nsColor()
    }

    /// 转换NSColor颜色 可选
    var nsColor_optional: NSColor? {
        return nsColor_optional()
    }

    /// 转换NSColor颜色 具有默认值
    /// - Parameter alpha: 阿尔法通道值
    func nsColor(_ alpha: AxcUnifiedNumber = 1) -> NSColor {
        return NSColor.Axc.Create(base, alpha: alpha)
    }

    /// 转换NSColor颜色 可选
    /// - Parameter alpha: 阿尔法通道值
    func nsColor_optional(_ alpha: AxcUnifiedNumber = 1) -> NSColor? {
        return NSColor.Axc.CreateOptional(base, alpha: alpha)
    }
}


#endif
