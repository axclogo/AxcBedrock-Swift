//
//  AxcUILabelEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/18.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base: UILabel { }

// MARK: - 类方法

public extension AxcSpace where Base: UILabel {
    /// 实例化字体样式
    /// - Parameters:
    ///   - text: text
    ///   - font: font
    ///   - color: color
    ///   - alignment: alignment
    static func Create(text: String? = nil,
                       font: AxcUnifiedFont? = nil,
                       color: AxcUnifiedColor? = UIColor.black,
                       alignment: NSTextAlignment = .left) -> Base {
        let label: Base = .init()
        if let _text = text {
            label.text = _text
        }
        if let _font = font {
            label.font = AssertTransformFont(_font)
        }
        if let _color = color {
            label.textColor = AssertTransformColor(_color)
        }
        label.textAlignment = alignment
        return label
    }

    /// 实例化富文本
    /// - Parameter attributedText: 富文本
    static func Create(_ attributedText: NSAttributedString) -> Base {
        let label: Base = .init()
        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: UILabel {
    /// label的高度适应
    var requiredHeight: CGFloat {
        return required()
    }

    /// label的宽度适应
    var requiredWidth: CGFloat {
        return required(false)
    }

    /// label的高度或者宽度适应
    func required(_ isHeight: Bool = true) -> CGFloat {
        var rect = CGRect(x: 0, y: 0, width: width, height: height)
        if isHeight {
            rect = rect.axc.set(height: CGFloat.Axc.Max)
        } else {
            rect = rect.axc.set(width: CGFloat.Axc.Max)
        }
        let label = UILabel(frame: rect)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = base.font
        label.text = base.text
        label.attributedText = base.attributedText
        label.sizeToFit()
        return isHeight ? label.axc.height : label.axc.width
    }

    /// 估算height
    var estimatedHeight: CGFloat {
        return estimatedSize(width: width).height
    }

    /// 估算width
    var estimatedWidth: CGFloat {
        return estimatedSize(height: height).width
    }

    /// 估算大小
    func estimatedSize(width: CGFloat = CGFloat.Axc.Max,
                       height: CGFloat = CGFloat.Axc.Max) -> CGSize {
        return base.sizeThatFits(CGSize(width: width, height: height))
    }

    /// 将文字复制到剪贴板
    func copyTextToPasteboard() {
        UIPasteboard.general.string = base.text
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: UILabel {
    /// 字符是否为空
    var isTextEmpty: Bool { return base.text?.isEmpty == true }
}

#endif
