//
//  AxcUITextFieldEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/18.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base: UITextField { }

// MARK: - 类方法

public extension AxcSpace where Base: UITextField { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: UITextField {
    /// 占位文字类型
    enum Placeholder {
        /// 普通文字
        case text(_ string: String)
        /// 设置文字、字体、颜色
        case textColorFont(_ text: String, color: AxcUnifiedColor, font: AxcUnifiedFont)
        /// 富文本
        case attributed(_ attributed: NSAttributedString)
    }

    /// 设置占位符
    /// - Parameter placeholder: 占位符
    func set(placeholder: Placeholder) {
        switch placeholder {
        case let .text(text):
            base.placeholder = text
        case let .textColorFont(text, color: color, font: font):
            base.attributedPlaceholder = text.axc.makeAttributed { make in
                make.set(font: font)
                make.set(foregroundColor: color)
            }
        case let .attributed(att):
            base.attributedPlaceholder = att
        }
    }

    /// 清空所有文本
    func clear() {
        base.text = ""
        base.attributedText = "".axc.makeAttributed { _ in }
    }
}

// MARK: - 代理转Block

private var ktextFieldDelegate = "ktextFieldDelegate"
public extension AxcSpace where Base: UITextField {
    /// 代理桥接者
    var textFieldDelegate: AxcDelegate.TextField {
        set { AxcRuntime.Set(object: self, key: &ktextFieldDelegate, value: newValue)
            base.delegate = newValue
        }
        get {
            guard let delegate: AxcDelegate.TextField = AxcRuntime.GetObject(self, key: &ktextFieldDelegate) else {
                let delegate = AxcDelegate.TextField()
                self.textFieldDelegate = delegate
                base.delegate = delegate
                return delegate
            }
            return delegate
        }
    }

    /// 块设置代理方法
    /// - Parameter block: block
    func makeTextFieldDelegate(_ block: AxcBlock.OneParam<AxcDelegate.TextField>) {
        block(textFieldDelegate)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: UITextField { }

#endif
