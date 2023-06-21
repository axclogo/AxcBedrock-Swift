//
//  AxcUnifiedColor+CoreGraphic.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

import CoreGraphics

// MARK: - CGColor + AxcUnifiedColor

extension CGColor: AxcUnifiedColor { }

public extension AxcSpace where Base: AxcUnifiedColor {
    /// 转换CGColor颜色 具有默认值
    var cgColor: CGColor {
        return cgColor()
    }

    /// 转换CGColor颜色 可选
    var cgColor_optional: CGColor? {
        return cgColor_optional()
    }

    /// 转换CGColor颜色 具有默认值
    /// - Parameter alpha: 阿尔法通道值
    func cgColor(_ alpha: AxcUnifiedNumber = 1) -> CGColor {
        return CGColor.Axc.Create(base, alpha: alpha)
    }

    /// 转换CGColor颜色 可选
    /// - Parameter alpha: 阿尔法通道值
    func cgColor_optional(_ alpha: AxcUnifiedNumber = 1) -> CGColor? {
        return CGColor.Axc.CreateOptional(base, alpha: alpha)
    }
}
