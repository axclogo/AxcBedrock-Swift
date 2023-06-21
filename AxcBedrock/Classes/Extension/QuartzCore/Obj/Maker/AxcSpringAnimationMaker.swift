//
//  AxcSpringAnimationMaker.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/10.
//

import QuartzCore

// MARK: - [AxcMaker.SpringAnimation]

public extension AxcMaker {
    /// Layer动画Maker
    class SpringAnimation: AxcMaker.BasicAnimation<CASpringAnimation> { }
}

public extension AxcMaker.SpringAnimation {
    /// 设置自动估算持续时间
    @discardableResult
    func setAutoDuration() -> Self {
        animation.duration = animation.settlingDuration
        return self
    }

    /// 质量
    /// - Parameter mass: 质量
    /// - Returns: Self
    @discardableResult
    func set(mass: AxcUnifiedNumber) -> Self {
        animation.mass = CGFloat.Axc.Create(mass)
        return self
    }

    /// 刚度
    /// 弹簧刚度系数。必须大于0。 默认为100
    /// - Parameter stiffness: 刚度
    /// - Returns: Self
    @discardableResult
    func set(stiffness: AxcUnifiedNumber) -> Self {
        animation.stiffness = CGFloat.Axc.Create(stiffness)
        return self
    }

    /// 阻尼
    /// 弹簧阻尼系数。必须大于0。 默认为10
    /// - Parameter damping: 刚度
    /// - Returns: Self
    @discardableResult
    func set(damping: AxcUnifiedNumber) -> Self {
        animation.damping = CGFloat.Axc.Create(damping)
        return self
    }

    /// 初始速度
    /// 弹簧上物体的初始速度。
    /// 为0，表示一个不移动的对象。
    /// 负值，表示远离弹簧附着点的物体，
    /// 正值，表示物体向弹簧移动
    /// - Parameter damping: 刚度
    /// - Returns: Self
    @discardableResult
    func set(initialVelocity: AxcUnifiedNumber) -> Self {
        animation.initialVelocity = CGFloat.Axc.Create(initialVelocity)
        return self
    }
}
