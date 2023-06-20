//
//  AxcChooseView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/2.
//

import UIKit

// MARK: - 样式扩展带参枚举
public extension AxcChooseView {
    /// 选择视图的样式
    enum Style {
        /// 默认样式
        case `default`
    }
}

// MARK: - AxcChooseView
/// AxcChooseView选择器视图
@IBDesignable
open class AxcChooseView: AxcBaseView,
                            AxcLeftRightBtnProtocol{
    // MARK: - 初始化
    public convenience init(_ title: String? = nil) {
        self.init()
        axc_title = title
    }
    // MARK: - Api
    // MARK: UI属性
    /// 设置样式
    open var axc_style: AxcChooseView.Style = .default { didSet { reloadLayout() } }
    
    /// 设置标题
    open var axc_title: String? {
        set { axc_titleLabel.text = newValue }
        get { return axc_titleLabel.text }
    }
    
    /// 设置更新titleView的高度 默认30
    open var axc_titleViewHeight: CGFloat = 30 { didSet { reloadLayout() } }
    
    /// 设置更新左右按钮的宽度 默认40
    open var axc_actionButtonWidth: CGFloat = 40 { didSet { reloadLayout() } }
    
    // MARK: - 回调
    // MARK: Block回调
    /// 左右按钮点击事件
    open var axc_btnAncionBlock: ((_ view: AxcChooseView,
                                     _ direction: AxcDirection,
                                     _ btn: AxcButton ) -> Void)
        = { (view,direction,btn ) in
            let className = AxcClassFromString(self)
            AxcLog("[可选]未设置\(className)的点击回调\n\(className): \(view)\nDirection:\(direction)\nBtutton:\(btn)", level: .action)
        }
    
    // MARK: func回调
    /// 左右按钮响应事件
    open func btnAction(_ direction: AxcDirection, sender: AxcButton) { }
    
    // MARK: - 父类重写
    /// 配置
    open override func config() {
        axc_width = Axc_screenWidth
        axc_height = Axc_screenHeight / 3 //默认屏高的1/3
    }
    /// 设置UI
    open override func makeUI() {
        backgroundColor = AxcBadrock.shared.backgroundColor
        
        reloadLayout()
    }
    /// 刷新布局
    open override func reloadLayout() {
        axc_titleView.axc.remakeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(axc_titleViewHeight)
        }
        axc_leftButton.axc.remakeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(axc_actionButtonWidth)
        }
        axc_rightButton.axc.remakeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(axc_actionButtonWidth)
        }
        axc_titleLabel.axc.remakeConstraints { (make) in
            make.left.equalTo(axc_leftButton.axc.right)
            make.right.equalTo(axc_rightButton.axc.left)
            make.top.bottom.equalToSuperview()
        }
        reloadStyle()
    }
    
    // MARK: 私有
    /// 刷新标题样式
    private func reloadStyle() {
        switch axc_style {
        case .default: break
        }
    }
    
    // MARK: - 懒加载
    open lazy var axc_titleLabel: AxcBaseLabel = {
        let label = AxcBaseLabel()
        label.textColor = AxcBadrock.shared.themeFillContentColor
        label.axc_contentInset = UIEdgeInsets.zero
        axc_titleView.addSubview(label)
        return label
    }()
    open lazy var axc_titleView: AxcBaseView = {
        let view = AxcBaseView()
        view.axc_setGradient()
        addSubview(view)
        return view
    }()
    
    // MARK: 协议控件
    /// 设置按钮样式
    open func axc_settingBtn(direction: AxcDirection) -> AxcButton {
        let button = AxcButton()
        button.backgroundColor = UIColor.clear
        button.axc_titleLabel.font = UIFont.systemFont(ofSize: 12)
        button.axc_titleLabel.textColor = AxcBadrock.shared.themeFillContentColor
        button.axc_titleLabel.text = AxcBadrockLanguage("确定")
        button.axc_style = .text
        button.axc_contentInset = UIEdgeInsets.zero
        button.axc_addEvent { [weak self] (sender) in
            guard let weakSelf = self else { return }
            guard let _sender = sender as? AxcButton else { return }
            weakSelf.axc_btnAncionBlock(weakSelf,direction,_sender)  // block回调
            weakSelf.btnAction(direction, sender: _sender)  // 方法回调
        }
        axc_titleView.addSubview(button)
        return button
    }
}
