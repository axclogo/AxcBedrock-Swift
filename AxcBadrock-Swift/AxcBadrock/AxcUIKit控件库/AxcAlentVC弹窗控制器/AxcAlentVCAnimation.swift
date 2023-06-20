//
//  AxcVCFadeAnimation.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/24.
//

import UIKit

/// 下方拉起式动画
open class AxcAlentVCAnimation: AxcBaseVCAnimationTransitioning {
    // MARK: - 动画实现
    // 出现转场
    open override func presentAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let alentVC = transitionContext.viewController(forKey: .to) as? AxcAlentVC else { return }
        guard let contentView = alentVC.axc_contentView else { return }
        // 添加进展示视图
        alentVC.view.axc_origin = CGPoint.zero
        alentVC.view.axc_size = CGSize(( Axc_screenWidth, Axc_screenHeight ))
        
        transitionContext.containerView.addSubview(alentVC.view)
        alentVC.view.axc.makeConstraints { (make) in make.edges.equalTo(0) }
        // 设置初始值
        setContentViewInTransform(alentVC,contentView)
        UIView.animate(withDuration: alentVC.axc_presentDuration, delay: 0,
                       usingSpringWithDamping: alentVC.axc_usingSpringWithDamping,
                       initialSpringVelocity: alentVC.axc_presentInitialSpringVelocity, options: .curveEaseInOut) {
            alentVC.view.alpha = 1
            contentView.transform = CGAffineTransform(translationX: 0, y: 0 )
            contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
        } completion: { (_) in
            transitionContext.completeTransition(true)
        }
    }
    // 设置入场前的状态
    func setContentViewInTransform(_ alentVC: AxcAlentVC, _ contentView: UIView) {
        alentVC.view.alpha = 0
        switch alentVC.axc_showDirection {
        case .top:      // 从上入场
            contentView.transform = CGAffineTransform(translationX: 0, y: -contentView.axc_height)
        case .left:     // 从左入场
            contentView.transform = CGAffineTransform(translationX: -contentView.axc_width, y: 0)
        case .bottom:   // 从下入场
            contentView.transform = CGAffineTransform(translationX: 0, y: alentVC.view.axc_height)
        case .right:    // 从右入场
            contentView.transform = CGAffineTransform(translationX: contentView.axc_width, y: 0)
        case .center:   // center缩放
            contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        default: break
        }
    }
    // 消失转场
    open override func dismissAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let alentVC = transitionContext.viewController(forKey: .from) as? AxcAlentVC else { return }
        guard let contentView = alentVC.axc_contentView else { return }
        // 设置初始值
        alentVC.view.alpha = 1
        UIView.animate(withDuration: alentVC.axc_dismissDuration, delay: 0,
                       usingSpringWithDamping: alentVC.axc_usingSpringWithDamping,
                       initialSpringVelocity: alentVC.axc_dismissInitialSpringVelocity,
                       options: .curveEaseInOut) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.setContentViewInTransform(alentVC,contentView)
        } completion: { (_) in
            transitionContext.completeTransition(true)
        }
    }
}
