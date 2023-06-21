//
//  AxcUnifiedFont+UIKit.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

#if canImport(UIKit)

import UIKit

// MARK: - UIFont + AxcUnifiedFont

extension UIFont: AxcUnifiedFont { }

public extension AxcSpace where Base: AxcUnifiedFont {
    /// 转换成UIFont 具有默认值
    var uiFont: UIFont {
        return uiFont()
    }

    /// 转换成UIFont 可选
    var uiFont_optional: UIFont? {
        return uiFont()
    }

    /// 转换成带字重的UIFont 具有默认值
    func uiFont(weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont.Axc.Create(base, weight: weight)
    }

    /// 转换成带字重的UIFont 可选
    func uiFont_optional(weight: UIFont.Weight = .regular) -> UIFont? {
        return UIFont.Axc.CreateOptional(base, weight: weight)
    }

    /// 转换成三方字体的UIFont 具有默认值
    func uiFont(name: String) -> UIFont {
        return uiFont_optional(name: name) ?? UIFont.systemFont(ofSize: 16)
    }

    /// 转换成三方字体的UIFontt 可选
    func uiFont_optional(name: String) -> UIFont? {
        if let number = base as? AxcUnifiedNumber {
            return UIFont(name: name, size: CGFloat.Axc.Create(number))
        } else {
            return nil
        }
    }
}

#endif
