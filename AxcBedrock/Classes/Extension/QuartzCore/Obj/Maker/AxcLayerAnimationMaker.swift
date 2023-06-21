//
//  AxcLayerAnimationMaker.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/28.
//

import QuartzCore

// MARK: - [AxcMaker.LayerAnimation]

public extension AxcMaker {
    /// Layer动画Maker
    class LayerAnimation {
        init(layer: CALayer) {
            self.layer = layer
        }

        var layer: CALayer
        /// 所有动画
        var animations: [CAAnimation] = []
    }
}

// MARK: - AxcMaker.LayerAnimation + AxcAssertUnifiedTransformTarget

extension AxcMaker.LayerAnimation: AxcAssertUnifiedTransformTarget { }

public extension AxcMaker.LayerAnimation {
    // MARK: Api

    /// 添加一个动画
    func addAnimation(_ animation: CAAnimation) {
        animations.append(animation)
    }

    // MARK: CAAnimation 普通动画

    /// 创建一个普通动画
    @discardableResult
    func animation(makeBlock: AxcBlock.Maker<AxcMaker.Animation<CAAnimation>>)
        -> CAAnimation {
        let animation = CAAnimation()
        animation.axc.makeAnimation(makeBlock)
        addAnimation(animation)
        return animation
    }

    // MARK: CAPropertyAnimation 抽象类动画

    /// 创建一个抽象动画
    @discardableResult
    func propertyAnimation(_ keyPath: AxcMaker.AnimationKeyPath,
                           makeBlock: AxcBlock.Maker<AxcMaker.PropertyAnimation<CAPropertyAnimation>>)
        -> CAPropertyAnimation {
        let animation = CAPropertyAnimation(keyPath: keyPath.rawValue)
        animation.axc.makeAnimation(makeBlock)
        addAnimation(animation)
        return animation
    }

    // MARK: CAKeyframeAnimation 关键帧动画

    /// 创建一个关键帧动画
    @discardableResult
    func keyframeAnimation(_ keyPath: AxcMaker.AnimationKeyPath,
                           makeBlock: AxcBlock.Maker<AxcMaker.KeyframeAnimation>)
        -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: keyPath.rawValue)
        animation.axc.makeAnimation(makeBlock)
        addAnimation(animation)
        return animation
    }

    // MARK: CABasicAnimation 基础动画

    /// 创建一个基础动画
    @discardableResult
    func basicAnimation(_ keyPath: AxcMaker.AnimationKeyPath,
                        makeBlock: AxcBlock.Maker<AxcMaker.BasicAnimation<CABasicAnimation>>)
        -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: keyPath.rawValue)
        animation.axc.makeAnimation(makeBlock)
        addAnimation(animation)
        return animation
    }

    // MARK: SpringAnimation 弹性动画

    /// 创建一个弹性动画
    @discardableResult
    func springAnimation(_ keyPath: AxcMaker.AnimationKeyPath,
                         makeBlock: AxcBlock.Maker<AxcMaker.SpringAnimation>)
        -> CASpringAnimation {
        let animation = CASpringAnimation(keyPath: keyPath.rawValue)
        animation.axc.makeAnimation(makeBlock)
        addAnimation(animation)
        return animation
    }

    // MARK: CATransition 转场动画

    /// 创建一个转场动画
    @discardableResult
    func transition(makeBlock: AxcBlock.Maker<AxcMaker.Transition>)
        -> CATransition {
        let animation = CATransition()
        animation.axc.makeAnimation(makeBlock)
        addAnimation(animation)
        return animation
    }

    // MARK: CAAnimationGroup 组动画

    /// 创建一个组动画
    @discardableResult
    func animationGroup(makeBlock: AxcBlock.Maker<AxcMaker.AnimationGroup>)
        -> CAAnimationGroup {
        let animation = CAAnimationGroup()
        animation.axc.makeAnimation(makeBlock)
        addAnimation(animation)
        return animation
    }
}
