//
//  AxcUITextViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import UIKit

// MARK: - 属性 & Api
public extension UITextView {
    /// 清除内容
    func axc_clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
    /// 移除边界
    func axc_removeInset() {
        contentInset = .zero
        scrollIndicatorInsets = .zero
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
    }
    /// 将大小与内容适配
    func axc_wrapContent() {
        axc_removeInset()
        contentOffset = .zero
        sizeToFit()
    }
}

// MARK: - 通知监听
public extension UITextView {
    typealias AxcUITextViewBlock = (UITextView) -> Void
    /// 开始编辑的回调
    func axc_setTextDidBeginEditingBlock(_ block: @escaping AxcUITextViewBlock) {
        axc_notificationCenter.axc_addNotification(UITextView.textDidBeginEditingNotification)
        { [weak self] _ in guard let weakSelf = self else { return }
            block(weakSelf)
        }.axc_setCycle(axc_notificationCycle)
    }
    /// 文本发生变化的回调
    func axc_setTextChangeBlock(_ block: @escaping AxcUITextViewBlock) {
        axc_notificationCenter.axc_addNotification(UITextView.textDidChangeNotification)
        { [weak self] _ in guard let weakSelf = self else { return }
            block(weakSelf)
        }.axc_setCycle(axc_notificationCycle)
    }
    /// 结束编辑的回调
    func axc_setTextDidEndEditingBlock(_ block: @escaping AxcUITextViewBlock) {
        axc_notificationCenter.axc_addNotification(UITextView.textDidEndEditingNotification)
        { [weak self] _ in guard let weakSelf = self else { return }
            block(weakSelf)
        }.axc_setCycle(axc_notificationCycle)
    }
}

// MARK: - 决策判断
public extension UITextView {
}

// MARK: - 代理转Block
private var kaxc_textViewDelegate = "kaxc_textViewDelegate"
public extension UITextView {
    /// 返回UITextView,URL,NSRange,UITextItemInteraction的Block声明
    typealias AxcURLRangeTextItemInteractionBlock<T> = (UITextView,URL,NSRange,UITextItemInteraction) -> T
    /// 返回UITextView,NSTextAttachment,NSRange,UITextItemInteraction的Block声明
    typealias AxcTextAttachmentRangeTextItemInteractionBlock<T> = (UITextView,NSTextAttachment,NSRange,UITextItemInteraction) -> T
    /// 返回UITextView,NSTextAttachment,NSRange的Block声明
    typealias AxcTextAttachmentRangeBlock<T> = (UITextView,NSTextAttachment,NSRange) -> T
    /// 返回UITextView,NSRange,String的Block声明
    typealias AxcRangeStringBlock<T> = (UITextView,NSRange,String) -> T
    /// 返回UITextView的Block声明
    typealias AxcBlock<T> = (UITextView) -> T
    /// 返回UITextView,URL,NSRange的Block声明
    typealias AxcURLRangeBlock<T> = (UITextView,URL,NSRange) -> T
    
    /// 代理桥接者
    var axc_textViewDelegate: AxcTextViewDelegate {
        set { AxcRuntime.setObj(self, &kaxc_textViewDelegate, newValue)
            self.delegate = newValue
        }
        get {
            guard let delegate: AxcTextViewDelegate  = AxcRuntime.getObj(self, &kaxc_textViewDelegate)
            else {
                let delegate = AxcTextViewDelegate()
                self.axc_textViewDelegate = delegate
                self.delegate = delegate
                return delegate
            }
            return delegate
        }
    }
    /// 块设置代理方法
    /// - Parameter block: block
    func axc_makeTextViewDelegate(_ block: (AxcTextViewDelegate) -> Void) {
        block(axc_textViewDelegate)
    }
}

// MARK: 桥接者
/// 代理转Block桥接者
open class AxcTextViewDelegate: NSObject, UITextViewDelegate {
    /// optional func textViewShouldBeginEditing(_ textView: UITextView) -> Bool
    @discardableResult
    open func axc_setTextViewShouldBeginEditingBlock(_ block: @escaping UITextView.AxcBlock<Bool>) -> Self {
        axc_textViewShouldBeginEditingBlock = block
        return self
    }
    open lazy var axc_textViewShouldBeginEditingBlock: UITextView.AxcBlock<Bool>
        = { _ in return true }
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return axc_textViewShouldBeginEditingBlock(textView)
    }
    
    
    /// optional func textViewShouldEndEditing(_ textView: UITextView) -> Bool
    @discardableResult
    open func axc_setTextViewShouldEndEditingBlock(_ block: @escaping UITextView.AxcBlock<Bool>) -> Self {
        axc_textViewShouldEndEditingBlock = block
        return self
    }
    open lazy var axc_textViewShouldEndEditingBlock: UITextView.AxcBlock<Bool>
        = { _ in return true }
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return axc_textViewShouldEndEditingBlock(textView)
    }
    
    
    /// optional func textViewDidBeginEditing(_ textView: UITextView)
    @discardableResult
    open func axc_setTextViewDidBeginEditingBlock(_ block: @escaping UITextView.AxcBlock<Void>) -> Self {
        axc_textViewDidBeginEditingBlock = block
        return self
    }
    open lazy var axc_textViewDidBeginEditingBlock: UITextView.AxcBlock<Void>
        = { _ in  }
    public func textViewDidBeginEditing(_ textView: UITextView) -> Void {
         axc_textViewDidBeginEditingBlock(textView)
    }
    
    
    /// optional func textViewDidEndEditing(_ textView: UITextView)
    @discardableResult
    open func axc_setTextViewDidEndEditingBlock(_ block: @escaping UITextView.AxcBlock<Void>) -> Self {
        axc_textViewDidEndEditingBlock = block
        return self
    }
    open lazy var axc_textViewDidEndEditingBlock: UITextView.AxcBlock<Void>
        = { _ in  }
    public func textViewDidEndEditing(_ textView: UITextView) -> Void {
         axc_textViewDidEndEditingBlock(textView)
    }
    
    
    /// optional func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    @discardableResult
    open func axc_setTextViewShouldChangeTextInReplacementTextBlock(_ block: @escaping UITextView.AxcRangeStringBlock<Bool>) -> Self {
        axc_textViewShouldChangeTextInReplacementTextBlock = block
        return self
    }
    open lazy var axc_textViewShouldChangeTextInReplacementTextBlock: UITextView.AxcRangeStringBlock<Bool>
        = { _,_,_ in return true }
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return axc_textViewShouldChangeTextInReplacementTextBlock(textView,range,text)
    }
    
    
    /// optional func textViewDidChange(_ textView: UITextView)
    @discardableResult
    open func axc_setTextViewDidChangeBlock(_ block: @escaping UITextView.AxcBlock<Void>) -> Self {
        axc_textViewDidChangeBlock = block
        return self
    }
    open lazy var axc_textViewDidChangeBlock: UITextView.AxcBlock<Void>
        = { _ in  }
    public func textViewDidChange(_ textView: UITextView) -> Void {
         axc_textViewDidChangeBlock(textView)
    }
    
    
    /// optional func textViewDidChangeSelection(_ textView: UITextView)
    @discardableResult
    open func axc_setTextViewDidChangeSelectionBlock(_ block: @escaping UITextView.AxcBlock<Void>) -> Self {
        axc_textViewDidChangeSelectionBlock = block
        return self
    }
    open lazy var axc_textViewDidChangeSelectionBlock: UITextView.AxcBlock<Void>
        = { _ in  }
    public func textViewDidChangeSelection(_ textView: UITextView) -> Void {
         axc_textViewDidChangeSelectionBlock(textView)
    }
    
    
    /// optional func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
    @available(iOS 10.0, *)
    @discardableResult
    open func axc_setTextViewShouldInteractWithInInteractionBlock(_ block: @escaping UITextView.AxcURLRangeTextItemInteractionBlock<Bool>) -> Self {
        axc_textViewShouldInteractWithURLInInteractionBlock = block
        return self
    }
    open lazy var axc_textViewShouldInteractWithURLInInteractionBlock: UITextView.AxcURLRangeTextItemInteractionBlock<Bool>
        = { _,_,_,_ in return true }
    @available(iOS 10.0, *)
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return axc_textViewShouldInteractWithURLInInteractionBlock(textView,URL,characterRange,interaction)
    }
    
    
    /// optional func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
    @available(iOS 10.0, *)
    @discardableResult
    open func axc_setTextViewShouldInteractWithInInteractionBlock(_ block: @escaping UITextView.AxcTextAttachmentRangeTextItemInteractionBlock<Bool>) -> Self {
        axc_textViewShouldInteractWithInInteractionBlock = block
        return self
    }
    open lazy var axc_textViewShouldInteractWithInInteractionBlock: UITextView.AxcTextAttachmentRangeTextItemInteractionBlock<Bool>
        = { _,_,_,_ in return true }
    @available(iOS 10.0, *)
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return axc_textViewShouldInteractWithInInteractionBlock(textView,textAttachment,characterRange,interaction)
    }
    
    
    /// optional func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool
    @available(iOS, introduced: 7.0, deprecated: 10.0)
    @discardableResult
    open func axc_setTextViewShouldInteractWithInBlock(_ block: @escaping UITextView.AxcURLRangeBlock<Bool>) -> Self {
        axc_textViewShouldInteractWithURLInBlock = block
        return self
    }
    open lazy var axc_textViewShouldInteractWithURLInBlock: UITextView.AxcURLRangeBlock<Bool>
        = { _,_,_ in return true }
    @available(iOS, introduced: 7.0, deprecated: 10.0)
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return axc_textViewShouldInteractWithURLInBlock(textView,URL,characterRange)
    }
    
    
    /// optional func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool
    @available(iOS, introduced: 7.0, deprecated: 10.0)
    @discardableResult
    open func axc_setTextViewShouldInteractWithInBlock(_ block: @escaping UITextView.AxcTextAttachmentRangeBlock<Bool>) -> Self {
        axc_textViewShouldInteractWithInBlock = block
        return self
    }
    open lazy var axc_textViewShouldInteractWithInBlock: UITextView.AxcTextAttachmentRangeBlock<Bool>
        = { _,_,_ in return true }
    @available(iOS, introduced: 7.0, deprecated: 10.0)
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        return axc_textViewShouldInteractWithInBlock(textView,textAttachment,characterRange)
    }
    
}
