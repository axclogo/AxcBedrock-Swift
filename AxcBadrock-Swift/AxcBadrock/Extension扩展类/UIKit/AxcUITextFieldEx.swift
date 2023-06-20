//
//  AxcUITextFieldEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/17.
//

import UIKit

// MARK: - 属性 & Api
public extension UITextField {
    /// 设置占位文字
    func axc_setPlaceholder(_ placeholder: String, color: AxcUnifiedColorTarget, font: UIFont? = nil) {
        let attributedPlaceholder = placeholder.axc_attributedStr.axc_setTextColor(color)
        if let _font = font { attributedPlaceholder.axc_setFont(_font) }
        self.attributedPlaceholder = attributedPlaceholder
    }
    /// 清空所有文本
    func axc_clear() {
        text = ""
        attributedText = "".axc_attributedStr
    }
    /// 左边距
    func axc_leftSpacing(_ spacing: CGFloat) {
        axc_addView(direction: .left, spacing: spacing)
    }
    /// 右边距
    func axc_rightSpacing(_ spacing: CGFloat) {
        axc_addView(direction: .right, spacing: spacing)
    }
    
    /// 添加左右图片
    /// - Parameters:
    ///   - direction: 方位
    ///   - image: 图片
    ///   - imageSize: 图片大小
    ///   - spacing: 边距
    func axc_addImage(direction: AxcDirection = .left,
                      image: UIImage?,
                      imageTintColor: AxcUnifiedColorTarget? = nil,
                      imageSize: CGSize? = nil,
                      spacing: CGFloat = 10) {
        var img = image
        var imgSize = CGSize.zero
        if let _imageSize = imageSize { // 是否需要缩放处理
            imgSize = _imageSize
            img = img?.axc_setScale(size: _imageSize)
        }
        if let _imageTintColor = imageTintColor?.axc_color { // 是否需要渲染处理
            img = img?.axc_setTintColor(_imageTintColor)
        }
        let imageView = UIImageView(image: img)
        axc_addView(direction: direction, view: imageView, viewSize: imgSize, spacing: spacing)
    }
    /// 添加左右视图
    /// - Parameters:
    ///   - direction: 方位
    ///   - view: 视图
    ///   - viewSize: 视图大小
    ///   - spacing: 边距
    func axc_addView(direction: AxcDirection = .left,
                     view: UIView? = nil,
                     viewSize: CGSize? = nil,
                     spacing: CGFloat = 0) {
        guard direction.selectType([.left, .right]) else { return } // 左右可选
        let isLeft = direction == .left
        var size = CGSize.zero
        if let _viewSize = viewSize { size = _viewSize }
        if size != CGSize.zero || spacing != 0 { // 有大小
            let tfView = AxcBaseView(frame: CGRect(x: 0, y: 0, width: size.width + spacing, height: axc_height))
            if let _view = view {
                _view.frame = CGRect(x: isLeft ? spacing : 0, y: 0, width: size.width, height: size.height)
                tfView.addSubview(_view)
            }
            if isLeft {
                leftView = tfView
                leftViewMode = .always
            }else{
                rightView = tfView
                rightViewMode = .always
            }
        }else{  // 没大小
            if isLeft {
                leftView = nil
                leftViewMode = .never
            }else{
                rightView = nil
                rightViewMode = .never
            }
        }
    }
}

// MARK: - 样式
/// 内容样式
public enum AxcTextFieldContentStyle {
    case number
    case phone
    case email
    case password
    case url
    case generic
}
private var kaxc_style  = "kaxc_style"
public extension UITextField {
    /// 添加样式状态
    var axc_style: AxcTextFieldContentStyle {
        get {
            guard let style: AxcTextFieldContentStyle = AxcRuntime.getObj(self, &kaxc_style) else {
                let _style = AxcTextFieldContentStyle.generic
                AxcRuntime.setObj(self, &kaxc_style, _style)
                return _style
            }
            return style
        }
        set {
            autocorrectionType = .no        // 关闭自动校正
            autocapitalizationType = .none // 自动大写
            clearButtonMode = .whileEditing // 删除按钮
            switch newValue {
            case .number:
                keyboardType = .numbersAndPunctuation
                isSecureTextEntry = false
                placeholder = AxcBadrockLanguage("请输入数字")
            case .phone:
                keyboardType = .phonePad
                isSecureTextEntry = false
                placeholder = AxcBadrockLanguage("请输入手机号")
            case .email:
                keyboardType = .emailAddress
                isSecureTextEntry = false
                placeholder = AxcBadrockLanguage("请输入邮箱")
            case .password:
                keyboardType = .asciiCapable
                isSecureTextEntry = true
                placeholder = AxcBadrockLanguage("请输入密码")
            case .url:
                keyboardType = .URL
                isSecureTextEntry = false
                placeholder = AxcBadrockLanguage("请输入地址")
            case .generic:
                isSecureTextEntry = false
            }
            AxcRuntime.setObj(self, &kaxc_style, newValue)
        }
    }
}

// MARK: - Xib属性扩展
public extension UITextField {
    /// 左视图的渲染颜色
    @IBInspectable var axc_leftImageTintColor: UIColor? {
        get { guard let iconView = leftView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = leftView as? UIImageView, let tintColor = newValue else { return }
            iconView.axc_tintColor(tintColor)
        }
    }
    /// 右视图的渲染颜色
    @IBInspectable var axc_rightImageTintColor: UIColor? {
        get { guard let iconView = rightView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set { guard let iconView = rightView as? UIImageView , let tintColor = newValue else { return }
            iconView.axc_tintColor(tintColor)
        }
    }
}

// MARK: - 响应回调
extension UITextField {
    /// 添加响应者
    /// - Parameters:
    ///   - target: 响应者
    ///   - event: 响应类型
    ///   - actionBlock: actionBlock
    /// - Returns: UITextField
    @discardableResult
    public func axc_addTarget(target: Any? = nil,
                              event: UIControl.Event = .editingChanged,
                              actionBlock: @escaping AxcActionBlock ) -> UITextField {
        axc_setActionBlock(actionBlock)
        addTarget(target, action: #selector(eventAction), for: event)
        return self
    }
    // 转block方法
    @objc private func eventAction(_ sender: Any?) {
        guard let block = axc_getActionBlock() else { return }
        block(sender)
    }
}

// MARK: - 通知监听
public extension UITextField {
    typealias AxcUITextFieldBlock = (UITextField) -> Void
    /// 开始编辑的回调
    func axc_setTextDidBeginEditingBlock(_ block: @escaping AxcUITextFieldBlock) {
        axc_notificationCenter.axc_addNotification(UITextField.textDidBeginEditingNotification)
        { [weak self] _ in guard let weakSelf = self else { return }
            block(weakSelf)
        }.axc_setCycle(axc_notificationCycle)
    }
    /// 文本发生变化的回调
    func axc_setTextChangeBlock(_ block: @escaping AxcUITextFieldBlock) {
        axc_notificationCenter.axc_addNotification(UITextField.textDidChangeNotification)
        { [weak self] _ in guard let weakSelf = self else { return }
            block(weakSelf)
        }.axc_setCycle(axc_notificationCycle)
    }
    /// 结束编辑的回调
    func axc_setTextDidEndEditingBlock(_ block: @escaping AxcUITextFieldBlock) {
        axc_notificationCenter.axc_addNotification(UITextField.textDidEndEditingNotification)
        { [weak self] _ in guard let weakSelf = self else { return }
            block(weakSelf)
        }.axc_setCycle(axc_notificationCycle)
    }
}

// MARK: - 决策判断
public extension UITextField {
    /// 字符是否为空
    var axc_isEmpty: Bool { return text?.isEmpty == true }
}

// MARK: - 代理转Block
private var kaxc_textFieldDelegate = "kaxc_textFieldDelegate"
public extension UITextField {
    /// 返回UITextField的Block声明
    typealias AxcBlock<T> = (UITextField) -> T
    /// 返回UITextField,UITextField.DidEndEditingReason的Block声明
    typealias AxcDidEndEditingReasonBlock<T> = (UITextField,UITextField.DidEndEditingReason) -> T
    /// 返回UITextField,NSRange,String的Block声明
    typealias AxcRangeStringBlock<T> = (UITextField,NSRange,String) -> T
    
    /// 代理桥接者
    var axc_textFieldDelegate: AxcTextFieldDelegate {
        set { AxcRuntime.setObj(self, &kaxc_textFieldDelegate, newValue)
            self.delegate = newValue
        }
        get {
            guard let delegate: AxcTextFieldDelegate  = AxcRuntime.getObj(self, &kaxc_textFieldDelegate)
            else {
                let delegate = AxcTextFieldDelegate()
                self.axc_textFieldDelegate = delegate
                self.delegate = delegate
                return delegate
            }
            return delegate
        }
    }
    /// 块设置代理方法
    /// - Parameter block: block
    func axc_makeTextFieldDelegate(_ block: (AxcTextFieldDelegate) -> Void) {
        block(axc_textFieldDelegate)
    }
}


// MARK: 桥接者
/// 代理转Block桥接者
open class AxcTextFieldDelegate: NSObject, UITextFieldDelegate {
    ///  return NO to disallow editing.
    @discardableResult
    open func axc_setTextFieldShouldBeginEditingBlock(_ block: @escaping UITextField.AxcBlock<Bool>) -> Self {
        axc_textFieldShouldBeginEditingBlock = block
        return self
    }
    open lazy var axc_textFieldShouldBeginEditingBlock: UITextField.AxcBlock<Bool>
        = { _ in return true }
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return axc_textFieldShouldBeginEditingBlock(textField)
    }
    
    
    ///  became first responder
    @discardableResult
    open func axc_setTextFieldDidBeginEditingBlock(_ block: @escaping UITextField.AxcBlock<Void>) -> Self {
        axc_textFieldDidBeginEditingBlock = block
        return self
    }
    open lazy var axc_textFieldDidBeginEditingBlock: UITextField.AxcBlock<Void>
        = { _ in  }
    public func textFieldDidBeginEditing(_ textField: UITextField) -> Void {
         axc_textFieldDidBeginEditingBlock(textField)
    }
    
    
    ///  return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    @discardableResult
    open func axc_setTextFieldShouldEndEditingBlock(_ block: @escaping UITextField.AxcBlock<Bool>) -> Self {
        axc_textFieldShouldEndEditingBlock = block
        return self
    }
    open lazy var axc_textFieldShouldEndEditingBlock: UITextField.AxcBlock<Bool>
        = { _ in return true }
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return axc_textFieldShouldEndEditingBlock(textField)
    }
    
    
    ///  may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    @discardableResult
    open func axc_setTextFieldDidEndEditingBlock(_ block: @escaping UITextField.AxcBlock<Void>) -> Self {
        axc_textFieldDidEndEditingBlock = block
        return self
    }
    open lazy var axc_textFieldDidEndEditingBlock: UITextField.AxcBlock<Void>
        = { _ in  }
    public func textFieldDidEndEditing(_ textField: UITextField) -> Void {
         axc_textFieldDidEndEditingBlock(textField)
    }
    
    
    ///  if implemented, called in place of textFieldDidEndEditing:
    @available(iOS 10.0, *)
    @discardableResult
    open func axc_setTextFieldDidEndEditingReasonBlock(_ block: @escaping UITextField.AxcDidEndEditingReasonBlock<Void>) -> Self {
        axc_textFieldDidEndEditingReasonBlock = block
        return self
    }
    open lazy var axc_textFieldDidEndEditingReasonBlock: UITextField.AxcDidEndEditingReasonBlock<Void>
        = { _,_ in  }
    @available(iOS 10.0, *)
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) -> Void {
         axc_textFieldDidEndEditingReasonBlock(textField,reason)
    }
    
    
    ///  return NO to not change text
    @discardableResult
    open func axc_setTextFieldShouldChangeCharactersInReplacementStringBlock(_ block: @escaping UITextField.AxcRangeStringBlock<Bool>) -> Self {
        axc_textFieldShouldChangeCharactersInReplacementStringBlock = block
        return self
    }
    open lazy var axc_textFieldShouldChangeCharactersInReplacementStringBlock: UITextField.AxcRangeStringBlock<Bool>
        = { _,_,_ in return true }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return axc_textFieldShouldChangeCharactersInReplacementStringBlock(textField,range,string)
    }
    
    
    /// optional func textFieldDidChangeSelection(_ textField: UITextField)
    @available(iOS 13.0, *)
    @discardableResult
    open func axc_setTextFieldDidChangeSelectionBlock(_ block: @escaping UITextField.AxcBlock<Void>) -> Self {
        axc_textFieldDidChangeSelectionBlock = block
        return self
    }
    open lazy var axc_textFieldDidChangeSelectionBlock: UITextField.AxcBlock<Void>
        = { _ in  }
    @available(iOS 13.0, *)
    public func textFieldDidChangeSelection(_ textField: UITextField) -> Void {
         axc_textFieldDidChangeSelectionBlock(textField)
    }
    
    
    ///  called when clear button pressed. return NO to ignore (no notifications)
    @discardableResult
    open func axc_setTextFieldShouldClearBlock(_ block: @escaping UITextField.AxcBlock<Bool>) -> Self {
        axc_textFieldShouldClearBlock = block
        return self
    }
    open lazy var axc_textFieldShouldClearBlock: UITextField.AxcBlock<Bool>
        = { _ in return true }
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return axc_textFieldShouldClearBlock(textField)
    }
    
    
    ///  called when 'return' key pressed. return NO to ignore.
    @discardableResult
    open func axc_setTextFieldShouldReturnBlock(_ block: @escaping UITextField.AxcBlock<Bool>) -> Self {
        axc_textFieldShouldReturnBlock = block
        return self
    }
    open lazy var axc_textFieldShouldReturnBlock: UITextField.AxcBlock<Bool>
        = { _ in return true }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return axc_textFieldShouldReturnBlock(textField)
    }
}
