//
//  AxcBaseVCAnimationTransitioning.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/24.
//

import UIKit

open class AxcBaseVCAnimationTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - 初始化
    /// 初始化
    /// - Parameters:
    ///   - isPresent: 是否为preset
    ///   - duration: 动画时间
    public init(_ isPresent: Bool = true, duration: TimeInterval? = nil) {
        super.init()
        axc_isPresent = isPresent
        guard let _duration = duration else { return }
        axc_duration = _duration
    }
    
    // MARK: - 属性Api
    /// 动画时间，默认0.3
    open var axc_duration: TimeInterval = Axc_duration
    /// 是否是Present方式出现
    open var axc_isPresent: Bool = true
    
    // MARK: - 子类实现
    /// present动画
    open func presentAnimation(_ transitionContext: UIViewControllerContextTransitioning) { }
    /// dismiss动画
    open func dismissAnimation(_ transitionContext: UIViewControllerContextTransitioning) { }
    
    // MARK: - 协议实现
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return axc_duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        axc_isPresent ? presentAnimation(transitionContext) : dismissAnimation(transitionContext)
    }
    

}
