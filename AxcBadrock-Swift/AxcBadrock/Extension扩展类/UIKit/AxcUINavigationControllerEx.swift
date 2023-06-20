//
//  AxcUINavigationControllerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

// MARK: - 属性 & Api
public extension UINavigationController {
    /// 设置背景色
    func axc_setBackgroundColor(_ color: UIColor) {
        navigationBar.setBackgroundImage(color.axc_image(), for: .default)
    }
    /// 设置标题颜色
    func axc_setTitleColor(_ color: UIColor) {
        axc_setTitleAttributes( [.foregroundColor : color] )
    }
    /// 设置标题字体
    func axc_setTitleFont(_ font: UIFont) {
        axc_setTitleAttributes( [.font : font] )
    }
    /// 设置标题属性
    func axc_setTitleAttributes(_ att: [NSAttributedString.Key : Any] ) {
        var attributes: [NSAttributedString.Key : Any] = [:]
        if let att = navigationBar.titleTextAttributes { attributes = att }
        attributes += att
        navigationBar.titleTextAttributes = attributes
    }
    /// 带执行完毕回调的push
    /// - Parameters:
    ///   - viewController: viewController
    ///   - completion: completion
    func axc_pushViewController(_ vc: UIViewController,
                                animation: Bool = true,
                                completion: AxcEmptyBlock? = nil ) {
        if let block = completion {
            CATransaction.begin()
            CATransaction.setCompletionBlock(block)
            pushViewController(vc, animated: animation)
            CATransaction.commit()
        }else{
            pushViewController(vc, animated: animation)
        }
    }
    /// 带执行完毕回调的pop
    /// - Parameters:
    ///   - animated: animated
    ///   - completion: completion
    func axc_popViewController(animated: Bool = true,
                               completion: AxcEmptyBlock? = nil ) {
        if let block = completion {
            CATransaction.begin()
            CATransaction.setCompletionBlock(block)
            popViewController(animated: animated)
            CATransaction.commit()
        }else{
            popViewController(animated: animated)
        }
    }
    
    /// 设置透明渲染色
    /// - Parameter tint: 颜色
    func axc_makeTransparent(_ tintColor: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tintColor
        navigationBar.titleTextAttributes = [.foregroundColor: tintColor]
    }
}

// MARK: - 代理转Block
private var kaxc_navigationControllerDelegate = "kaxc_navigationControllerDelegate"
public extension UINavigationController {
    /// 返回UINavigationController,UIViewControllerAnimatedTransitioning的Block声明
    typealias AxcViewControllerAnimatedTransitioningBlock<T> = (UINavigationController,UIViewControllerAnimatedTransitioning) -> T
    /// 返回UINavigationController,UIViewController,Bool的Block声明
    typealias AxcViewControllerBoolBlock<T> = (UINavigationController,UIViewController,Bool) -> T
    /// 返回UINavigationController,UINavigationController.Operation,UIViewController,UIViewController的Block声明
    typealias AxcOperationViewControllerViewControllerBlock<T> = (UINavigationController,UINavigationController.Operation,UIViewController,UIViewController) -> T
    /// 返回UINavigationController的Block声明
    typealias AxcBlock<T> = (UINavigationController) -> T
    
    /// 代理桥接者
    var axc_navigationControllerDelegate: AxcNavigationControllerDelegate {
        set { AxcRuntime.setObj(self, &kaxc_navigationControllerDelegate, newValue)
            self.delegate = newValue
        }
        get {
            guard let delegate: AxcNavigationControllerDelegate  = AxcRuntime.getObj(self, &kaxc_navigationControllerDelegate)
            else {
                let delegate = AxcNavigationControllerDelegate()
                self.axc_navigationControllerDelegate = delegate
                self.delegate = delegate
                return delegate
            }
            return delegate
        }
    }
    /// 块设置代理方法
    /// - Parameter block: block
    func axc_makeNavigationControllerDelegate(_ block: (AxcNavigationControllerDelegate) -> Void) {
        block(axc_navigationControllerDelegate)
    }
}

// MARK: 桥接者
/// 代理转Block桥接者
open class AxcNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    /// optional func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
    @discardableResult
    open func axc_setNavigationControllerWillShowAnimatedBlock(_ block: @escaping UINavigationController.AxcViewControllerBoolBlock<Void>) -> Self {
        axc_navigationControllerWillShowAnimatedBlock = block
        return self
    }
    open lazy var axc_navigationControllerWillShowAnimatedBlock: UINavigationController.AxcViewControllerBoolBlock<Void>
        = { _,_,_ in  }
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) -> Void {
         axc_navigationControllerWillShowAnimatedBlock(navigationController,viewController,animated)
    }
    
    
    /// optional func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool)
    @discardableResult
    open func axc_setNavigationControllerDidShowAnimatedBlock(_ block: @escaping UINavigationController.AxcViewControllerBoolBlock<Void>) -> Self {
        axc_navigationControllerDidShowAnimatedBlock = block
        return self
    }
    open lazy var axc_navigationControllerDidShowAnimatedBlock: UINavigationController.AxcViewControllerBoolBlock<Void>
        = { _,_,_ in  }
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) -> Void {
         axc_navigationControllerDidShowAnimatedBlock(navigationController,viewController,animated)
    }
    
    
    /// optional func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask
    @discardableResult
    open func axc_setNavigationControllerSupportedInterfaceOrientationsBlock(_ block: @escaping UINavigationController.AxcBlock<UIInterfaceOrientationMask>) -> Self {
        axc_navigationControllerSupportedInterfaceOrientationsBlock = block
        return self
    }
    open lazy var axc_navigationControllerSupportedInterfaceOrientationsBlock: UINavigationController.AxcBlock<UIInterfaceOrientationMask>
        = { _ in return UIInterfaceOrientationMask() }
    public func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return axc_navigationControllerSupportedInterfaceOrientationsBlock(navigationController)
    }
    
    
    /// optional func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation
    @discardableResult
    open func axc_setNavigationControllerPreferredInterfaceOrientationForPresentationBlock(_ block: @escaping UINavigationController.AxcBlock<UIInterfaceOrientation>) -> Self {
        axc_navigationControllerPreferredInterfaceOrientationForPresentationBlock = block
        return self
    }
    open lazy var axc_navigationControllerPreferredInterfaceOrientationForPresentationBlock: UINavigationController.AxcBlock<UIInterfaceOrientation>
        = { _ in return .portrait }
    public func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation {
        return axc_navigationControllerPreferredInterfaceOrientationForPresentationBlock(navigationController)
    }
    
    
    /// optional func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
    @discardableResult
    open func axc_setNavigationControllerInteractionControllerForBlock(_ block: @escaping UINavigationController.AxcViewControllerAnimatedTransitioningBlock<UIViewControllerInteractiveTransitioning?>) -> Self {
        axc_navigationControllerInteractionControllerForBlock = block
        return self
    }
    open lazy var axc_navigationControllerInteractionControllerForBlock: UINavigationController.AxcViewControllerAnimatedTransitioningBlock<UIViewControllerInteractiveTransitioning?>
        = { _,_ in return nil }
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return axc_navigationControllerInteractionControllerForBlock(navigationController,animationController)
    }
    
    
    /// optional func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    @discardableResult
    open func axc_setNavigationControllerAnimationControllerForFromToBlock(_ block: @escaping UINavigationController.AxcOperationViewControllerViewControllerBlock<UIViewControllerAnimatedTransitioning?>) -> Self {
        axc_navigationControllerAnimationControllerForFromToBlock = block
        return self
    }
    open lazy var axc_navigationControllerAnimationControllerForFromToBlock: UINavigationController.AxcOperationViewControllerViewControllerBlock<UIViewControllerAnimatedTransitioning?>
        = { _,_,_,_ in return nil }
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return axc_navigationControllerAnimationControllerForFromToBlock(navigationController,operation,fromVC,toVC)
    }
}
