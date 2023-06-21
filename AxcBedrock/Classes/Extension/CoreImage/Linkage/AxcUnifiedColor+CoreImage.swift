//
//  AxcUnifiedColor+CoreImage.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

import CoreImage

// MARK: - CIColor + AxcUnifiedColor

extension CIColor: AxcUnifiedColor { }

public extension AxcSpace where Base: AxcUnifiedColor {
    /// 转换CIColor颜色 具有默认值
    var ciColor: CIColor {
        return ciColor()
    }

    /// 转换CIColor颜色 可选
    var ciColor_optional: CIColor? {
        return ciColor_optional()
    }

    /// 转换CIColor颜色 具有默认值
    /// - Parameter alpha: 阿尔法通道值
    func ciColor(_ alpha: AxcUnifiedNumber = 1) -> CIColor {
        return CIColor.Axc.Create(base, alpha: alpha)
    }

    /// 转换CIColor颜色 可选
    /// - Parameter alpha: 阿尔法通道值
    func ciColor_optional(_ alpha: AxcUnifiedNumber = 1) -> CIColor? {
        return CIColor.Axc.CreateOptional(base, alpha: alpha)
    }
}
