//
//  AxcUnifiedColor+UIKit.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

#if canImport(UIKit)

import UIKit

// MARK: - UIColor + AxcUnifiedColor

extension UIColor: AxcUnifiedColor { }

public extension AxcSpace where Base: AxcUnifiedColor {
    /// 转换UIColor颜色 具有默认值
    var uiColor: UIColor {
        return uiColor()
    }

    /// 转换UIColor颜色 可选
    var uiColor_optional: UIColor? {
        return uiColor_optional()
    }

    /// 转换UIColor颜色 具有默认值
    /// - Parameter alpha: 阿尔法通道值
    func uiColor(_ alpha: AxcUnifiedNumber = 1) -> UIColor {
        return UIColor.Axc.Create(base, alpha: alpha)
    }

    /// 转换UIColor颜色 可选
    /// - Parameter alpha: 阿尔法通道值
    func uiColor_optional(_ alpha: AxcUnifiedNumber = 1) -> UIColor? {
        return UIColor.Axc.CreateOptional(base, alpha: alpha)
    }
}

public extension AxcUnifiedColor where Self == UIColor {
    /*  Auto Maintain Code >>>>>> **/
    
    /// 0.0 white
    static var black: UIColor { return .black }

    /// 0.333 white
    static var darkGray: UIColor { return .darkGray }

    /// 0.667 white
    static var lightGray: UIColor { return .lightGray }

    /// 1.0 white
    static var white: UIColor { return .white }

    /// 0.5 white
    static var gray: UIColor { return .gray }

    /// 1.0, 0.0, 0.0 RGB
    static var red: UIColor { return .red }

    /// 0.0, 1.0, 0.0 RGB
    static var green: UIColor { return .green }

    /// 0.0, 0.0, 1.0 RGB
    static var blue: UIColor { return .blue }

    /// 0.0, 1.0, 1.0 RGB
    static var cyan: UIColor { return .cyan }

    /// 1.0, 1.0, 0.0 RGB
    static var yellow: UIColor { return .yellow }

    /// 1.0, 0.0, 1.0 RGB
    static var magenta: UIColor { return .magenta }

    /// 1.0, 0.5, 0.0 RGB
    static var orange: UIColor { return .orange }

    /// 0.5, 0.0, 0.5 RGB
    static var purple: UIColor { return .purple }

    /// 0.6, 0.4, 0.2 RGB
    static var brown: UIColor { return .brown }

    /// 0.0 white, 0.0 alpha
    static var clear: UIColor { return .clear }

    static var systemRed: UIColor { return .systemRed }

    static var systemGreen: UIColor { return .systemGreen }

    static var systemBlue: UIColor { return .systemBlue }

    static var systemOrange: UIColor { return .systemOrange }

    static var systemYellow: UIColor { return .systemYellow }

    static var systemPink: UIColor { return .systemPink }

    static var systemPurple: UIColor { return .systemPurple }

    static var systemTeal: UIColor { return .systemTeal }

    @available(iOS 13.0, *)
    static var systemIndigo: UIColor { return .systemIndigo }

    @available(iOS 13.0, *)
    static var systemBrown: UIColor { return .systemBrown }

    @available(iOS 15.0, *)
    static var systemMint: UIColor { return .systemMint }

    @available(iOS 15.0, *)
    static var systemCyan: UIColor { return .systemCyan }

    static var systemGray: UIColor { return .systemGray }

    @available(iOS 13.0, *)
    static var systemGray2: UIColor { return .systemGray2 }

    @available(iOS 13.0, *)
    static var systemGray3: UIColor { return .systemGray3 }

    @available(iOS 13.0, *)
    static var systemGray4: UIColor { return .systemGray4 }

    @available(iOS 13.0, *)
    static var systemGray5: UIColor { return .systemGray5 }

    @available(iOS 13.0, *)
    static var systemGray6: UIColor { return .systemGray6 }

    @available(iOS 15.0, *)
    static var tintColor: UIColor { return .tintColor }

    @available(iOS 13.0, *)
    static var label: UIColor { return .label }

    @available(iOS 13.0, *)
    static var secondaryLabel: UIColor { return .secondaryLabel }

    @available(iOS 13.0, *)
    static var tertiaryLabel: UIColor { return .tertiaryLabel }

    @available(iOS 13.0, *)
    static var quaternaryLabel: UIColor { return .quaternaryLabel }

    @available(iOS 13.0, *)
    static var link: UIColor { return .link }

    @available(iOS 13.0, *)
    static var placeholderText: UIColor { return .placeholderText }

    @available(iOS 13.0, *)
    static var separator: UIColor { return .separator }

    @available(iOS 13.0, *)
    static var opaqueSeparator: UIColor { return .opaqueSeparator }

    @available(iOS 13.0, *)
    static var systemBackground: UIColor { return .systemBackground }

    @available(iOS 13.0, *)
    static var secondarySystemBackground: UIColor { return .secondarySystemBackground }

    @available(iOS 13.0, *)
    static var tertiarySystemBackground: UIColor { return .tertiarySystemBackground }

    @available(iOS 13.0, *)
    static var systemGroupedBackground: UIColor { return .systemGroupedBackground }

    @available(iOS 13.0, *)
    static var secondarySystemGroupedBackground: UIColor { return .secondarySystemGroupedBackground }

    @available(iOS 13.0, *)
    static var tertiarySystemGroupedBackground: UIColor { return .tertiarySystemGroupedBackground }

    @available(iOS 13.0, *)
    static var systemFill: UIColor { return .systemFill }

    @available(iOS 13.0, *)
    static var secondarySystemFill: UIColor { return .secondarySystemFill }

    @available(iOS 13.0, *)
    static var tertiarySystemFill: UIColor { return .tertiarySystemFill }

    @available(iOS 13.0, *)
    static var quaternarySystemFill: UIColor { return .quaternarySystemFill }

    /// for a dark background
    static var lightText: UIColor { return .lightText }

    /// for a light background
    static var darkText: UIColor { return .darkText }

    static var groupTableViewBackground: UIColor { return .groupTableViewBackground }

    /* <<<<<< Auto Maintain Code **/
}

#endif
