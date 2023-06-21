//
//  AxcTextFieldDelegate.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/19.
//

#if canImport(UIKit)

import UIKit

// MARK: - [AxcDelegate.TextField]

public extension AxcDelegate {
    /// UITextField Delegate转Block桥接者
    class TextField: NSObject {
        public typealias TF = UITextField
        /// 返回UITextField的Block声明
        public typealias Block<T> = AxcBlock.OneParamReturn<TF, T>
        /// 返回UITextField,UITextField.DidEndEditingReason的Block声明
        public typealias DidEndEditingReasonBlock<T> = AxcBlock.TwoParamReturn<TF, TF.DidEndEditingReason, T>
        /// 返回UITextField,NSRange,String的Block声明
        public typealias RangeStringBlock<T> = AxcBlock.ThreeParamReturn<TF, NSRange, String, T>

        // Open

        ///  return NO to disallow editing.
        @discardableResult
        open func set(shouldBeginEditingBlock block: @escaping Block<Bool>) -> Self {
            textFieldShouldBeginEditingBlock = block
            return self
        }

        ///  became first responder
        @discardableResult
        open func set(didBeginEditingBlock block: @escaping Block<Void>) -> Self {
            textFieldDidBeginEditingBlock = block
            return self
        }

        ///  return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        @discardableResult
        open func set(shouldEndEditingBlock block: @escaping Block<Bool>) -> Self {
            textFieldShouldEndEditingBlock = block
            return self
        }

        ///  may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        @discardableResult
        open func set(didEndEditingBlock block: @escaping Block<Void>) -> Self {
            textFieldDidEndEditingBlock = block
            return self
        }

        ///  if implemented, called in place of textFieldDidEndEditing:
        @available(iOS 10.0, *)
        @discardableResult
        open func set(didEndEditingReasonBlock block: @escaping DidEndEditingReasonBlock<Void>) -> Self {
            textFieldDidEndEditingReasonBlock = block
            return self
        }

        ///  return NO to not change text
        @discardableResult
        open func set(shouldChangeCharactersInReplacementStringBlock block: @escaping RangeStringBlock<Bool>) -> Self {
            textFieldShouldChangeCharactersInReplacementStringBlock = block
            return self
        }

        /// optional func textFieldDidChangeSelection(_ textField: UITextField)
        @available(iOS 13.0, *)
        @discardableResult
        open func set(didChangeSelectionBlock block: @escaping Block<Void>) -> Self {
            textFieldDidChangeSelectionBlock = block
            return self
        }

        ///  called when clear button pressed. return NO to ignore (no notifications)
        @discardableResult
        open func set(shouldClearBlock block: @escaping Block<Bool>) -> Self {
            textFieldShouldClearBlock = block
            return self
        }

        ///  called when 'return' key pressed. return NO to ignore.
        @discardableResult
        open func set(shouldReturnBlock block: @escaping Block<Bool>) -> Self {
            textFieldShouldReturnBlock = block
            return self
        }

        // Fileprivate

        fileprivate lazy var textFieldShouldBeginEditingBlock: Block<Bool>
            = { _ in return true }
        fileprivate lazy var textFieldDidBeginEditingBlock: Block<Void>
            = { _ in }
        fileprivate lazy var textFieldShouldEndEditingBlock: Block<Bool>
            = { _ in return true }
        fileprivate lazy var textFieldDidEndEditingBlock: Block<Void>
            = { _ in }
        fileprivate lazy var textFieldDidEndEditingReasonBlock: DidEndEditingReasonBlock<Void>
            = { _, _ in }
        fileprivate lazy var textFieldShouldChangeCharactersInReplacementStringBlock: RangeStringBlock<Bool>
            = { _, _, _ in return true }
        fileprivate lazy var textFieldDidChangeSelectionBlock: Block<Void>
            = { _ in }
        fileprivate lazy var textFieldShouldClearBlock: Block<Bool>
            = { _ in return true }
        fileprivate lazy var textFieldShouldReturnBlock: Block<Bool>
            = { _ in return true }
    }
}

// MARK: - AxcDelegate.TextField + UITextFieldDelegate

extension AxcDelegate.TextField: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return textFieldShouldBeginEditingBlock(textField)
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldDidBeginEditingBlock(textField)
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return textFieldShouldEndEditingBlock(textField)
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldDidEndEditingBlock(textField)
    }

    @available(iOS 10.0, *)
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textFieldDidEndEditingReasonBlock(textField, reason)
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textFieldShouldChangeCharactersInReplacementStringBlock(textField, range, string)
    }

    @available(iOS 13.0, *)
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        textFieldDidChangeSelectionBlock(textField)
    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return textFieldShouldClearBlock(textField)
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textFieldShouldReturnBlock(textField)
    }
}

#endif
