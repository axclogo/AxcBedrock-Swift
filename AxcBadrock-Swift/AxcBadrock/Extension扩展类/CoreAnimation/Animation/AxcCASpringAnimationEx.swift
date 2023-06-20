//
//  AxcCASpringAnimationEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/28.
//

import UIKit

// MARK: - 链式语法
public extension CASpringAnimation {
    /// 设置自动估算持续时间
    @discardableResult
    func axc_setAutoDuration() -> Self {
        self.duration = settlingDuration
        return self
    }
    /// 质量
    /// - Parameter mass: 质量
    /// - Returns: Self
    @discardableResult
    func axc_setMass(_ mass: CGFloat) -> Self {
        self.mass = mass
        return self
    }
    
    /// 刚度
    /// 弹簧刚度系数。必须大于0。 默认为100
    /// - Parameter stiffness: 刚度
    /// - Returns: Self
    @discardableResult
    func axc_setStiffness(_ stiffness: CGFloat) -> Self {
        self.stiffness = stiffness
        return self
    }
    
    /// 阻尼
    /// 弹簧阻尼系数。必须大于0。 默认为10
    /// - Parameter damping: 刚度
    /// - Returns: Self
    @discardableResult
    func axc_setDamping(_ damping: CGFloat) -> Self {
        self.damping = damping
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
    func axc_setInitialVelocity(_ initialVelocity: CGFloat) -> Self {
        self.initialVelocity = initialVelocity
        return self
    }
}
