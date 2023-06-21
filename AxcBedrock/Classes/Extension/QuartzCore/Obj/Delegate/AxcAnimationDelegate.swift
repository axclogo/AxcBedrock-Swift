//
//  AxcAnimationDelegate.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/28.
//

import QuartzCore

// MARK: - [AxcDelegate.Animation]

public extension AxcDelegate {
    /// 动画代理
    class Animation: NSObject {
        fileprivate var animationDidStartBlock: AxcBlock.OneParam<CAAnimation>?
        fileprivate var animationStopFinishedBlock: AxcBlock.TwoParam<CAAnimation, Bool>?
        var animationMakerEndBlock: AxcBlock.TwoParam<CAAnimation, Bool>?
    }
}

public extension AxcDelegate.Animation {
    ///  动画开始
    @discardableResult
    func set(animationDidStartBlock block: AxcBlock.OneParam<CAAnimation>?) -> Self {
        animationDidStartBlock = block
        return self
    }

    ///  动画结束
    @discardableResult
    func set(animationStopFinishedBlock block: AxcBlock.TwoParam<CAAnimation, Bool>?) -> Self {
        animationStopFinishedBlock = block
        return self
    }
}

/// 框架内部使用
extension AxcDelegate.Animation {
    ///  动画终止 框架内部使用
    @discardableResult
    func set(animationMakerEndBlock block: AxcBlock.TwoParam<CAAnimation, Bool>?) -> Self {
        animationMakerEndBlock = block
        return self
    }
}

// MARK: - AxcDelegate.Animation + CAAnimationDelegate

extension AxcDelegate.Animation: CAAnimationDelegate {
    public func animationDidStart(_ anim: CAAnimation) {
        animationDidStartBlock?(anim)
    }

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animationStopFinishedBlock?(anim, flag)
        animationMakerEndBlock?(anim, flag)
    }
}
