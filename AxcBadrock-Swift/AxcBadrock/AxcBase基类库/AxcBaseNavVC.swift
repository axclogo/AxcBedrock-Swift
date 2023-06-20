//
//  AxcBaseNavVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

// MARK: - AxcBaseNavVC
/// 基类NavController
@IBDesignable
open class AxcBaseNavVC: UINavigationController {
    // MARK: - Api
    
    // MARK: - 回调
    // MARK: Block回调
    /// 当view设置BackgroundColor前会调用
    open var axc_navWillPushBlock: ((_ vc: UIViewController, _ nav: AxcBaseNavVC, _ animation: Bool) -> Void)?
    /// 当view设置BackgroundColor后会调用
    open var axc_navWillPopBlock: ((_ nav: AxcBaseNavVC, _ animation: Bool) -> Void)?
    
    // MARK: func回调
    /// 即将push一个VC
    /// - Parameters:
    ///   - vc: 即将push的vc
    ///   - nav: 导航控制器
    ///   - animation: 是否动画
    open func axc_naviWillPush(vc: UIViewController, nav: AxcBaseNavVC, animation: Bool){ }
    /// 即将pop本VC
    /// - Parameters:
    ///   - nav: 导航控制器
    ///   - animation: 是否动画
    open func axc_navWillPop(nav: AxcBaseNavVC, animation: Bool){ }
    
    // MARK: - 子类实现
    /// 设置UI布局
    open func makeUI() { }
    
    // MARK: - 父类重写
    /// 视图加载完成
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AxcBadrock.shared.backgroundColor
        navigationBar.isTranslucent = false // 默认不透明 视图的 y 0从 navBar 下开始算
        makeUI()
    }
    /// 当push发生时，会通知类为AxcBaseViewController的vc控制器
    open override func pushViewController(_ vc: UIViewController, animated: Bool) {
        // 先设置
        if let tabbar = tabBarController {  // 如果视图由tabbar托管
            vc.hidesBottomBarWhenPushed = !tabbar.children.contains(vc) // 默认 非tabbar中的vc隐藏tabbar push
            if let baseVC = vc as? AxcBaseVC {  // 如果是继承框架的视图基类
                let itemSize = Axc_navigationItemSize.axc_smaller.axc_cgSize
                baseVC.axc_setBackNavBarItem(size: itemSize)  // 添加返回按钮
            }
        }
        // 再回调，保证子类或其他对象可以覆盖默认设置
        axc_navWillPushBlock?(vc, self, animated)   // block回调
        axc_naviWillPush(vc: vc, nav: self, animation: animated) // 方法回调
        super.pushViewController(vc, animated: animated)
    }
    /// 当pop发生时，会通知类为AxcBaseViewController的vc控制器
    open override func popViewController(animated: Bool) -> UIViewController? {
        axc_navWillPopBlock?(self, animated)   // block回调
        axc_navWillPop(nav: self, animation: animated) // 方法回调
        return super.popViewController(animated: animated)
    }
    /// 状态栏样式
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if let topVC = topViewController {
            return topVC.preferredStatusBarStyle
        }else{
            return super.preferredStatusBarStyle
        }
    }
    /// vc的屏幕转向
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard let topVC = topViewController as? AxcBaseVC
        else { return super.supportedInterfaceOrientations }
        return topVC.axc_screenOrientation
    }
}
