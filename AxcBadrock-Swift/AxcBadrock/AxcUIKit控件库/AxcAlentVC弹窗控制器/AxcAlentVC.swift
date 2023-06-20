//
//  AxcSheetVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/24.
//

import UIKit

// MARK: - 样式扩展带参枚举
public extension AxcAlentVC {
    /// 样式
    enum Style {
        /// 默认
        case `default`
        /// sheet
        case sheet
        /// alent
        case alent
    }
}

// MARK: - AxcAlentVC
/// AxcAlentVC弹窗视图
@IBDesignable
open class AxcAlentVC: AxcBaseVC {
    // MARK: - 初始化
    /// 实例化一个AxcSheetVC
    /// - Parameters:
    ///   - view: 需要弹出的视图
    ///   - size: 视图大小
    ///   - style: 弹出样式
    ///   - showDirection: 显示位置
    ///   - inDirection: 入场方向
    ///   - outDirection: 出场方向
    public convenience init(view: UIView, size: CGSize? = nil,
                showDirection: AxcDirection = .bottom) {
        self.init()
        axc_contentView = view
        var contentSize = view.axc_size
        if let _size = size { contentSize = _size }
        axc_showDirection = showDirection
        axc_contentSize = contentSize
        config()
    }
    required public convenience init?(coder: NSCoder) { self.init() }
        
    // MARK: - Api
    // MARK: UI属性
    /// 样式
    open var axc_style: AxcAlentVC.Style = .default
    
    /// 内容视图
    open var axc_contentView: UIView?
    
    /// 内容视图的边距
    open var axc_contentSize: CGSize = CGSize( Axc_screenWidth , Axc_screenHeight/3 ) { didSet { reloadLayout() } }
    
    /// 显示方向
    open var axc_showDirection: AxcDirection = .bottom
    
    /// 是否添加点击背景dismiss 默认要
    open var axc_tapBackgroundDismissEnable = true
    
    /// present动画时间 默认 0.6
    open var axc_presentDuration = Axc_duration * 2
    
    /// dismiss动画时间 默认 0.6
    open var axc_dismissDuration = Axc_duration * 2
    
    /// 动画弹性系数 默认0.9
    open var axc_usingSpringWithDamping: CGFloat = 0.9
    
    /// present刚度，默认15
    open var axc_presentInitialSpringVelocity: CGFloat = 15
    
    /// dismiss刚度，默认1
    open var axc_dismissInitialSpringVelocity: CGFloat = 1
    
    // MARK: 方法
    /// 显示出来
    open func axc_show() {
        AxcAppWindow()?.rootViewController?.present(self, animated: true, completion: nil)
    }
    
    // MARK: - 回调
    // MARK: Block回调
    /// 点击背景回调
    open var axc_backgroundActionBlock: ((_ vc: AxcAlentVC ) -> Void)
        = { (vc) in
            let className = AxcClassFromString(self)
            AxcLog("[可选]未设置\(className)的点击回调\n\(className): \(vc)", level: .action)
        }
    // MARK: func回调
    /// 点击背景回调
    open func axc_backgroundAction(vc: AxcAlentVC) { }
    
    // MARK: - 父类重写
    // MARK: 视图父类
    /// 配置
    open override func config() {
        transitioningDelegate = self    // 配置代理
    }
    /// 设置UI
    open override func makeUI() {
        super.makeUI()
        view.backgroundColor = AxcBadrock.shared.maskBackgroundColor
        
        reloadLayout()
    }
    /// 刷新布局
    open func reloadLayout() {
        backControl.axc.remakeConstraints { (make) in
            make.edges.equalTo(0)
        }
        // 设置显示的大小
        if let contentView = axc_contentView {
            view.addSubview(contentView) // 进行约束
            contentView.axc.remakeConstraints { (make) in
                make.size.equalTo(axc_contentSize).lowPriority()           // 低优先，默认大小
                make.center.equalToSuperview().lowPriority()    // 低优先，默认居中
                // 使用高优先覆盖约束
                if axc_showDirection.contains(.top)     { make.top.equalToSuperview().heightPriority() }
                if axc_showDirection.contains(.left)    { make.left.equalToSuperview().heightPriority() }
                if axc_showDirection.contains(.bottom)  { make.bottom.equalToSuperview().heightPriority() }
                if axc_showDirection.contains(.right)   { make.right.equalToSuperview().heightPriority() }
            }
        }
        reloadStyle()
    }
    
    // MARK: 私有
    /// 刷新标题样式
    private func reloadStyle() {
        switch axc_style {
        case .default: break
        case .sheet: break
        case .alent: break
        }
    }
    
    // MARK: 超类&抽象类
    /// present样式
    public override var modalPresentationStyle: UIModalPresentationStyle {
        set { super.modalPresentationStyle = newValue }
        get { return .overFullScreen }
    }
    
    // MARK: - 懒加载
    // MARK: 私有控件
    private lazy var alentAnimation: AxcAlentVCAnimation = {
        let animation = AxcAlentVCAnimation()
        return animation
    }()
    private lazy var backControl: AxcBaseControl = {
        let control = AxcBaseControl()
        control.backgroundColor = UIColor.clear
        control.axc_addEvent { [weak self] (_) in
            guard let weakSelf = self else { return }
            weakSelf.axc_backgroundActionBlock(weakSelf)
            weakSelf.axc_backgroundAction(vc: weakSelf)
            if weakSelf.axc_tapBackgroundDismissEnable {    // 需要点击背景返回
                weakSelf.axc_dismissViewController()
            }
        }
        view.addSubview(control)
        return control
    }()
}

// MARK: - 协议代理
extension AxcAlentVC: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        alentAnimation.axc_isPresent = true
        return alentAnimation
    }
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        alentAnimation.axc_isPresent = false
        return alentAnimation
    }
    
}
