//
//  AxcPropertyAnimationMaker.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/28.
//

import QuartzCore

// MARK: - [AxcMaker.PropertyAnimation]

public extension AxcMaker {
    /// Layer动画Maker
    class PropertyAnimation<AnimationType: CAPropertyAnimation>: AxcMaker.Animation<AnimationType> { }
}

public extension AxcMaker.PropertyAnimation {
    /// 设置要改变的属性值
    @discardableResult
    func set(key: AxcMaker.Animation<CAAnimation>.KeyPath) -> Self {
        animation.keyPath = key.rawValue
        return self
    }

    /// 设置要改变的属性值
    @discardableResult
    func set(keyPath: String?) -> Self {
        animation.keyPath = keyPath
        return self
    }

    /// 当值为true时，动画指定的值将被“添加”到产生新属性的当前表示值
    /// 对于仿射变换，默认为false
    @discardableResult
    func set(isAdditive: Bool) -> Self {
        animation.isAdditive = isAdditive
        return self
    }

    /// 累积
    /// “累积”属性影响重复动画的产生方式
    /// 如果为真，那么动画的当前值是在前一个重复循环结束时的值，加上重复周期。
    /// 如果为false，则该值只是简单的值，为当前重复周期计算
    @discardableResult
    func set(isCumulative: Bool) -> Self {
        animation.isCumulative = isCumulative
        return self
    }

    /// 插值函数
    /// 如果为非nil，一个用于插值的函数在它们被设置为动画的新表示值之前的属性。
    /// 默认为零
    @discardableResult
    func set(valueFunction: CAValueFunction?) -> Self {
        animation.valueFunction = valueFunction
        return self
    }
}
