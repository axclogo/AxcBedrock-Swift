//
//  AxcTextField.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/22.
//

import UIKit

// MARK: - 样式扩展带参枚举
public extension AxcTextField{
    /// 文本输入框样式
    enum Style {
        /// 默认样式
        case `default`
        /// 左标题样式
        case leftTitle
        /// 搜索样式
        case search
        /// 可触发前缀
        case actionPrefix
        /// 验证码
        case verifyCode
        /// 密码
        case password
    }
}

// MARK: - AxcTextField
/// Axc文本输入控件
@IBDesignable
open class AxcTextField: AxcBaseView,
                           AxcLeftRightBtnProtocol {
    // MARK: - Api
    // MARK: UI属性
    /// 内容布局样式
    open var axc_style: AxcTextField.Style = .default { didSet { reloadLayout() } }
    
    /// 设置内容边距
    open var axc_contentInset: UIEdgeInsets = .zero { didSet { reloadLayout() } }
    
    /// 设置左右视图的间距 默认5
    open var axc_lrSpacing: CGFloat = 5 { didSet { reloadLayout() } }
    /// 设置左视图的宽度 默认10
    open var axc_leftWidth: CGFloat = 10 { didSet { reloadLayout() } }
    /// 设置右视图的宽度 默认10
    open var axc_rightWidth: CGFloat = 10 { didSet { reloadLayout() } }
    
    /// 左视图
    open var axc_leftView: AxcButton { return axc_leftButton }
    
    /// 右视图
    open var axc_rightView: AxcButton { return axc_rightButton }
    
    /// 设置内容文字
    open var axc_text: String? {
        set { axc_textField.text = newValue }
        get { return axc_textField.text }
    }
    /// 设置字色
    open var axc_textColor: UIColor? {
        set { axc_textField.textColor = newValue }
        get { return axc_textField.textColor }
    }
    /// 设置字体
    open var axc_font: UIFont? {
        set { axc_textField.font = newValue }
        get { return axc_textField.font }
    }
    /// 设置对齐方式
    open var axc_textAlignment: NSTextAlignment {
        set { axc_textField.textAlignment = newValue }
        get { return axc_textField.textAlignment }
    }
    /// 设置内容富文本
    open var axc_attributedText: NSAttributedString? {
        set { axc_textField.attributedText = newValue }
        get { return axc_textField.attributedText }
    }
    /// 设置边框样式
    open var axc_borderStyle: UITextField.BorderStyle {
        set { axc_textField.borderStyle = newValue }
        get { return axc_textField.borderStyle }
    }
    /// 设置占位
    open var axc_placeholder: String? {
        set { axc_textField.placeholder = newValue }
        get { return axc_textField.placeholder }
    }
    
    
    // MARK: 方法
    /// 设置占位文字
    /// - Parameters:
    ///   - placeholder: 占位文字
    ///   - color: 颜色
    ///   - font: 字号
    open func axc_setPlaceholder(_ placeholder: String, color: UIColor, font: UIFont) {
        axc_textField.axc_setPlaceholder(placeholder, color: color, font: font)
    }
    
    // MARK: - 回调
    // MARK: Block回调
    /// 文字变化时候回调
    open var axc_textChangeBlock:((_ textField: AxcTextField,
                                     _ text: String? ) -> Void)?
    
    /// 左右按钮点击事件
    open var axc_btnAncionBlock:((_ textField: AxcTextField,
                                    _ direction: AxcDirection,
                                    _ btn: AxcButton ) -> Void)
        = { (textField,direction,btn ) in
            let className = AxcClassFromString(self)
            AxcLog("[可选]未设置\(className)的点击回调\n\(className): \(textField)\nDirection:\(direction)\nBtutton:\(btn)", level: .action)
        }
    
    // MARK: - 私有
    // 监听回调
    @objc private func textFieldTextChange(_ sender: Any) {
        guard let notification = sender as? Notification else { return }
        guard let obj = notification.object as? NSObject,   // 是否为NSObject类
              obj == axc_textField // 判断是不是自己这个textField，否则不做操作
        else { return }
        // 监听回调
        axc_textChangeBlock?(self, axc_textField.text)
    }
    
    // MARK: - 父类重写
    // MARK: 视图父类
    /// 配置
    open override func config() {
        super.config()
        axc_textField.font = UIFont.systemFont(ofSize: 14)
        axc_textField.textColor = AxcBadrock.shared.textColor
        axc_textField.clearButtonMode = .whileEditing // 删除按钮
        // 添加监听
        axc_notificationCenter.addObserver(self, selector: #selector(textFieldTextChange(_:)),
                                           name: UITextField.textDidChangeNotification, object: nil)
    }
    /// 设置UI
    open override func makeUI() {
        super.makeUI()
        addSubview(axc_leftButton)
        addSubview(axc_rightButton)
        addSubview(axc_textField)
        
        reloadLayout()
    }
    /// 刷新布局
    open override func reloadLayout() {
        axc_leftButton.axc.remakeConstraints { (make) in
            make.top.equalTo(axc_contentInset.top)
            make.left.equalTo(axc_contentInset.left)
            make.bottom.equalTo(-axc_contentInset.bottom)
            make.width.equalTo(axc_leftWidth)
        }
        axc_rightButton.axc.remakeConstraints { (make) in
            make.top.equalTo(axc_contentInset.top)
            make.right.equalTo(-axc_contentInset.right)
            make.bottom.equalTo(-axc_contentInset.bottom)
            make.width.equalTo(axc_rightWidth)
        }
        axc_textField.axc.remakeConstraints { (make) in
            make.top.equalTo(axc_contentInset.top)
            make.bottom.equalTo(-axc_contentInset.bottom)
            make.left.equalTo(axc_leftButton.axc.right).offset(axc_lrSpacing)
            make.right.equalTo(axc_rightButton.axc.left).offset(-axc_lrSpacing)
        }
        
        reloadStyle()
    }
    
    // MARK: 私有
    /// 刷新样式
    private func reloadStyle() {
//        // 获取文字按钮的宽度
//        func getBtnTextWidth(_ btn: AxcButton) -> CGFloat{
//            var btnSpacing = btn.axc_titleLabel.axc_estimatedWidth() + btn.axc_contentInset.axc_horizontal;
//            btnSpacing += (btn.axc_titleLabel.axc_contentInset.axc_horizontal)
//            return btnSpacing
//        }
//        // 获取图片按钮的宽度
//        func getBtnImgWidth(_ btn: AxcButton) -> CGFloat{
//            return btn.axc_imgSize + btn.axc_contentInset.axc_horizontal;
//        }
//        // 重置按钮状态
//        func resetBtnState(_ btn: AxcButton){
//            btn.axc_contentInset = UIEdgeInsets(axc_lrSpacing)
//            btn.axc_style = .img
//            btn.axc_setBorderLineHidden()
//            btn.axc_titleLabel.axc_contentAlignment = .center
//        }
//        // 预先还原所有按钮状态
//        axc_textField.isSecureTextEntry = false
//        axc_textField.axc_leftSpacing(0)
//        axc_textField.axc_rightSpacing(0)
//        resetBtnState(axc_leftButton)
//        axc_setViewWidth(.left, width: axc_lrSpacing*2)
//        resetBtnState(axc_rightButton)
//        axc_setViewWidth(.right, width: axc_lrSpacing*2)
//
//        switch axc_style {
//        case .default:  // 默认
//            break
//
//        case .leftTitle:    // 左标题
//            axc_leftButton.axc_style = .text                                // 布局样式
//            axc_setViewWidth(.left, width: getBtnTextWidth(axc_leftButton)) // 约束宽度
//
//        case .search:       // 搜索样式
//            axc_leftButton.axc_style = .img                                 // 布局样式
//            axc_leftButton.axc_imgSize = axc_height/3                       // 图片大小
//            axc_setViewWidth(.left, width: getBtnImgWidth(axc_leftButton))  // 约束宽度
//            // UI
//            axc_leftButton.axc_imageView.image = AxcBadrockBundle.magnifyingGlassImage
//
//        case .actionPrefix:    // 触发前缀
//            axc_leftButton.axc_style = .textLeft_imgRight       // 布局样式
//            axc_leftButton.axc_imgSize = 10                     // 图片大小
//            axc_leftButton.axc_contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: axc_lrSpacing)
//            var textWidth = getBtnTextWidth(axc_leftButton)
//            textWidth += axc_leftButton.axc_imgSize
//            axc_setViewWidth(.left, width: textWidth)       // 约束宽度
//            // UI
//            axc_leftButton.axc_imageView.image = AxcBadrockBundle.arrowBottomImage
//            axc_leftButton.axc_titleLabel.axc_contentAlignment = .left
//            axc_leftButton.axc_setBorderLineDirection(.right)
//            axc_leftButton.axc_setBorderLineWidth(0.5)
//            axc_leftButton.axc_setBorderLineEdge(.right, edge: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
//
//        case .verifyCode:    // 验证码
//            axc_rightButton.axc_style = .text                                   // 布局样式
//            axc_leftButton.axc_contentInset = UIEdgeInsets.zero
//            axc_setViewWidth(.right, width: getBtnTextWidth(axc_rightButton))   // 约束宽度
//            // UI
//            axc_rightButton.axc_titleLabel.textColor = AxcBadrock.shared.themeColor
//            axc_rightButton.axc_setBorderLineDirection(.left)
//            axc_rightButton.axc_setBorderLineWidth(0.5)
//            axc_rightButton.axc_setBorderLineEdge(.left, edge: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
//            axc_rightButton.axc_addEvent { (_sender) in
//                guard let sender = _sender as? AxcButton else { return }
//                let title = sender.axc_titleLabel.text       // 记录原先的文字
//                let color = sender.axc_titleLabel.textColor  // 记录原先颜色
//                sender.axc_titleLabel.textColor = AxcBadrock.shared.unTextColor
//                sender.isUserInteractionEnabled = false // 禁止触发
//                sender.axc_startCountdown(duration: 10, format: AxcBadrockLanguage("重新获取(%d)") ) { (_sende) in
//                    guard let sende = _sende as? AxcButton else { return }
//                    sende.axc_titleLabel.text = title        // 还原原先的文字
//                    sende.axc_titleLabel.textColor = color   // 还原原先颜色
//                    sende.isUserInteractionEnabled = true // 恢复触发
//                }
//            }
//
//        case .password:    // 密码
//            axc_rightButton.axc_style = .img                                    // 布局样式
//            axc_rightButton.axc_imgSize = axc_height/3                          // 图片大小
//            axc_setViewWidth(.right, width: getBtnImgWidth(axc_rightButton))    // 约束宽度
//            // UI
//            axc_textField.isSecureTextEntry = true
//            axc_rightButton.axc_imageView.image = AxcBadrockBundle.eyesCloseImage
//            axc_rightButton.axc_addEvent { [weak self] (_) in
//                guard let weakSelf = self else { return }
//                weakSelf.axc_textField.isSecureTextEntry = !weakSelf.axc_textField.isSecureTextEntry
//                weakSelf.axc_rightButton.axc_imageView.image = weakSelf.axc_textField.isSecureTextEntry ? AxcBadrockBundle.eyesCloseImage : AxcBadrockBundle.eyesOpenImage
//            }
//        }
    }
    
    // MARK: - 懒加载
    // MARK: 基础控件
    open lazy var axc_textField: UITextField = {
        let textField = UITextField()
        addSubview(textField)
        return textField
    }()
    // MARK: 协议控件
    /// 设置按钮样式
    open func axc_settingBtn(direction: AxcDirection) -> AxcButton {
        let button = AxcButton()
        button.backgroundColor = UIColor.clear
        button.axc_titleLabel.font = UIFont.systemFont(ofSize: 12)
        button.axc_titleLabel.textColor = AxcBadrock.shared.unTextColor
        addSubview(button)
        return button
    }
    // MARK: - 销毁
    deinit { axc_notificationCenter.removeObserver(self) }
}
