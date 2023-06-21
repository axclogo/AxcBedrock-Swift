//
//  AxcUITextInputEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2022/12/5.
//

#if canImport(UIKit)

import UIKit

// MARK: - [AxcTextLimitCountInputTarget]

public protocol AxcTextLimitCountInputTarget: UITextInput {
    /// 文字
    var _text: String? { get }

    /// 文字输入模式（输入法）
    var _textInputMode: UITextInputMode? { get }
}

public extension AxcTextLimitCountInputTargetSpace {
    /// 限制输入数量
    /// - Parameters:
    ///   - maxCount: 最大数量
    ///   - countGreaterThanBlock: 超出后回调
    func limitInput(maxCount: Int, countGreaterThanBlock: AxcBlock.TwoParam<Base, Int>) {
        guard let text = base._text else { return }
        let langWhitelist = ["zh-Hans"] // 输入法白名单
        if let lang = base._textInputMode?.primaryLanguage,
           langWhitelist.contains(lang),
           let selectRange = base.markedTextRange {
            let position = base.position(from: selectRange.start, offset: 0)
            if position == nil {
                if text.count > maxCount {
                    countGreaterThanBlock(base as! Base, maxCount)
                }
            }
        } else {
            if text.count > maxCount {
                countGreaterThanBlock(base as! Base, maxCount)
            }
        }
    }
}

// MARK: - UITextField + AxcTextLimitCountInputTarget

extension UITextField: AxcTextLimitCountInputTarget {
    public var _text: String? {
        return text
    }

    public var _textInputMode: UITextInputMode? {
        return textInputMode
    }
}

// MARK: - UITextView + AxcTextLimitCountInputTarget

extension UITextView: AxcTextLimitCountInputTarget {
    public var _text: String? {
        return text
    }

    public var _textInputMode: UITextInputMode? {
        return textInputMode
    }
}

// MARK: - [AxcTextLimitCountInputTargetSpace]

public struct AxcTextLimitCountInputTargetSpace<Base> where Base: AxcTextLimitCountInputTarget {
    init(_ base: AxcTextLimitCountInputTarget) {
        self.base = base
    }

    var base: AxcTextLimitCountInputTarget
}

public extension AxcTextLimitCountInputTarget {
    /// 命名空间
    var axc: AxcTextLimitCountInputTargetSpace<Self> {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcTextLimitCountInputTargetSpace<Self>.Type {
        return AxcTextLimitCountInputTargetSpace<Self>.self
    }
}

#endif
