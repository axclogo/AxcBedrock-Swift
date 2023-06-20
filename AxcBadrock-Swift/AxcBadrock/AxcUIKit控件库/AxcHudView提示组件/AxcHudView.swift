//
//  AxcHudView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/4/17.
//

import UIKit

public extension AxcHudView {
    enum ProgressStyle {
        case circle
    }
    /// 加载动画样式
    enum LoadingStyle {
        case circle
    }
    /// AxcHudView的样式
    enum Style {
        /// 无样式，默认 文字
        case `default`(_ text: String?)
        /// 成功提示
        case success(_ text: String?)
        /// 错误提示
        case failure(_ text: String?)
        /// 信息提示
        case info(_ text: String?)
        /// 上图标下文字
        case iconText(icon: UIImage, text: String?)
        /// 进度提示
        case progress(style: ProgressStyle = .circle, progress: CGFloat?)
        /// 加载中
        case loading(style: LoadingStyle = .circle)
    }
    /// Hud状态
    enum State {
        /// 未知
        case unknow
        /// 即将显示（动画中）
        case willShow
        /// 已经显示
        case didShow
        /// 即将消失（动画中）
        case willHide
        /// 已经消失
        case didHide
        /// 是否处于展示状态
        var isShow: Bool {
            return self == .willShow || self == .didShow
        }
    }
}

// MARK: - AxcHudView
/// AxcHud控件
@IBDesignable
open class AxcHudView: AxcBaseView {
    // MARK: - Api
    // MARK: UI属性
    /// 图标大小
    open var axc_iconSize: CGSize = 20.axc_cgSize { didSet { reloadLayout() } }
    /// 内容边距
    open var axc_contentInset: UIEdgeInsets = 10.axc_uiEdge { didSet { reloadLayout() } }
    /// 显示边距
    open var axc_showInset: UIEdgeInsets = 15.axc_uiEdge
    /// 显示方位
    open var axc_direction: AxcDirection = .center { didSet { reloadDirection() } }
    /// 状态
    open var axc_state: State = .unknow
    
    // MARK: 方法
    /// 类方法显示
    /// - Parameters:
    ///   - style: 样式
    ///   - view: 展现在哪个视图上 默认Window
    ///   - showTime: 显示几秒
    ///   - direction: 展现方位 支持位运算
    ///   - feedback: 是否使用震动反馈
    ///   - showStyle: 显示动画样式
    ///   - dismissStyle: 小时动画样式
    @discardableResult
    public static func axc_show(_ style: Style ,
                                in view: UIView? = AxcAppWindow(),
                                showTime: TimeInterval = 3,
                                direction: AxcDirection = .center,
                                feedback: Bool = true,
                                showStyle: AxcAnimationManager.InoutStyle? = nil,
                                dismissStyle: AxcAnimationManager.InoutStyle? = nil) -> AxcHudView {
        let hud = AxcHudView()
        hud.axc_show(style,
                     in: view,
                     showTime: showTime,
                     direction: direction,
                     feedback: feedback,
                     showStyle: showStyle,
                     dismissStyle: dismissStyle)
        return hud
    }
    /// 显示出来
    /// - Parameters:
    ///   - style: 样式
    ///   - view: 展现在哪个视图上
    ///   - showTime: 显示几秒
    ///   - direction: 展现方位 支持位运算
    ///   - feedback: 是否使用震动反馈
    ///   - showStyle: 显示动画样式
    ///   - dismissStyle: 小时动画样式
    open func axc_show(_ style: Style,
                       in view: UIView? = AxcAppWindow(),
                       showTime: TimeInterval = 3,
                       direction: AxcDirection = .center,
                       feedback: Bool = true,
                       showStyle: AxcAnimationManager.InoutStyle? = nil,
                       dismissStyle: AxcAnimationManager.InoutStyle? = nil) {
        guard let showView = view else { return }
        hudStyle = style            // 设置展示样式，进行赋值
        showView.addSubview(self)   // 添加视图
        axc_direction = direction   // 设置方位
        reloadLayout()              // 刷新布局
        // 设置动画
        var animation = AxcAnimationManager.axc_inoutFade(isIn: true, Axc_duration)
        if let style = showStyle { // 枚举生成动画
            animation = AxcAnimationManager.axc_animationInoutStyle(style: style)
        }
        // 开始出现动画
        axc_state = .willShow
        axc_addAnimation(animation)
        if feedback { AxcVibrationManager.axc_playVibration() } // 震动反馈
        animation.axc_setEndBlock { [weak self] (_, _) in guard let weakSelf = self else { return }
            weakSelf.axc_state = .didShow
            AxcGCD.delay(showTime) { [weak self] in guard let weakSelf = self else { return }
                weakSelf.axc_dismiss(dismissStyle)
            }
        }
    }
    
    /// 消失
    open func axc_dismiss(_ dismissStyle: AxcAnimationManager.InoutStyle? = nil) {
        // 设置动画
        var animation = AxcAnimationManager.axc_inoutFade(isIn: false, Axc_duration)
        if let style = dismissStyle { // 枚举生成动画
            animation = AxcAnimationManager.axc_animationInoutStyle(style: style)
        }
        // 开始消失动画
        axc_state = .willHide
        axc_addAnimation(animation)
        animation.axc_setEndBlock { [weak self] (_, _) in guard let weakSelf = self else { return }
            weakSelf.axc_state = .didHide
            weakSelf.removeFromSuperview()
        }
    }
    
    // MARK: - 私有
    // MARK: 复用
    // hud样式刷新
    private var hudStyle: Style = .default("text") { didSet { reloadStyle() } }
    private func reloadStyle() {
        axc_iconImageView.isHidden = true
        axc_textLabel.isHidden = true
        switch hudStyle {
        case .default(text: let text):
            axc_textLabel.isHidden = false
            axc_textLabel.text = text
        case .success(text: let text):
            hudStyle = .iconText(icon: "test".axc_image, text: text)
            return
        case .failure(text: let text):
            hudStyle = .iconText(icon: "test".axc_image, text: text)
            return
        case .info(text: let text):
            hudStyle = .iconText(icon: "test".axc_image, text: text)
            return
        case .iconText(icon: let icon, text: let text):
            axc_iconImageView.isHidden = false
            axc_textLabel.isHidden = false
            axc_iconImageView.image = icon
            axc_textLabel.text = text
        case .progress(style: let style, progress: let progress):
            progressStyle = style
            axc_size = 100.axc_cgSize
        case .loading(style: let style):
            loadingStyle = style
        }
    }
    // 进度样式刷新
    private var progressStyle: ProgressStyle = .circle { didSet { reloadProgressStyle() } }
    private func reloadProgressStyle() {
        switch progressStyle {
        case .circle: break
        }
    }
    // 加载样式刷新
    private var loadingStyle: LoadingStyle = .circle { didSet { reloadLoadingStyle() } }
    private func reloadLoadingStyle() {
        switch loadingStyle {
        case .circle: break
        }
    }
    // 刷新方位
    private func reloadDirection() {
        guard let superView = superview else { return }
        axc_remakeConstraints { (make) in
            // 约束小于等于的边界
            let maxWidth = (superView.axc_width - axc_showInset.axc_horizontal) / superView.axc_width
            make.width.lessThanOrEqualToSuperview().multipliedBy(maxWidth)
            let maxHeight = (superView.axc_height - axc_showInset.axc_verticality) / superView.axc_height
            make.height.lessThanOrEqualToSuperview().multipliedBy(maxHeight)
            if axc_direction.isCenter { // 只居中
                make.center.equalToSuperview()
            }else{
                if axc_direction.contains(.top) {
                    make.top.equalTo(axc_showInset.top)
                    if !axc_direction.isContainsHorizonta { // 不包含水平元素
                        make.centerX.equalToSuperview() // 默认居中
                    }
                }
                if axc_direction.contains(.left) {
                    make.left.equalTo(axc_showInset.left)
                    if !axc_direction.isContainsVerticality { // 不包含垂直元素
                        make.centerY.equalToSuperview() // 默认居中
                    }
                }
                if axc_direction.contains(.bottom) {
                    make.bottom.equalTo(-axc_showInset.bottom)
                    if !make.isMakeCenterX && !axc_direction.isContainsHorizonta { // 未约束不包含水平元素
                        make.centerX.equalToSuperview() // 默认居中
                    }
                }
                if axc_direction.contains(.right) {
                    make.right.equalTo(-axc_showInset.right)
                    if !make.isMakeCenterY && !axc_direction.isContainsVerticality { // 未约束不包含垂直元素
                        make.centerY.equalToSuperview() // 默认居中
                    }
                }
            }
        }
    }
    // MARK: - 父类重写
    // MARK: 视图父类
    open override func config() {
        backgroundColor = UIColor.black.axc_alpha(0.5)
        axc_cornerRadius = 5
        axc_masksToBounds = true
    }
    /// 设置UI
    open override func makeUI() {
        backgroundColor = UIColor.black.axc_alpha(0.5)
    }
    /// 布局UI
    open override func reloadLayout() {
        guard let _ = superview else { return } // 无父视图不执行
        // 边距
        axc_contentView.axc_remakeConstraintsInset(axc_contentInset)
        switch hudStyle {
        // 默认
        case .default(text: _):
            axc_textLabel.axc_remakeConstraintsFill() // label全填充
        // 图标加文字
        case .iconText(icon: _, text: _):
            axc_iconImageView.isHidden = false
            axc_textLabel.isHidden = false
            axc_iconImageView.axc_remakeConstraints { (make) in
                make.top.centerX.equalToSuperview()
                make.size.equalTo(axc_iconSize)
            }
            axc_textLabel.axc_remakeConstraints { (make) in
                make.top.equalTo(axc_iconImageView.axc.bottom).offset(5)
                make.left.right.bottom.equalToSuperview()
            }
        case .progress(style: _, progress: _):
            break
        case .loading(style: _):
            break
        default: break
        }
    }
    
    
    // MARK: 超类&抽象类
    // MARK: - 懒加载
    /// 内容label
    lazy var axc_textLabel: AxcBaseLabel = {
        let label = AxcBaseLabel()
        label.font = 14.axc_font(weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.axc_contentInset = 0.axc_uiEdge
        axc_contentView.addSubview(label)
        return label
    }()
    
    /// 图标
    lazy var axc_iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        axc_contentView.addSubview(imageView)
        return imageView
    }()
    /// 内容视图
    lazy var axc_contentView: AxcBaseView = {
        let view = AxcBaseView()
        addSubview(view)
        return view
    }()
}
