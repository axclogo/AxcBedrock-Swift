//
//  AxcUITransitionMaker.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/28.
//

import QuartzCore

// MARK: - [AxcMaker.Transition]

public extension AxcMaker {
    /// Layer动画Maker
    class Transition: AxcMaker.Animation<CATransition> { }
}

public extension AxcMaker.Transition {
    /// 过渡的名称。目前的过渡类型包括
    /// “fade”，“moveIn”，“push”和“reveal”。默认为“消失”
    @discardableResult
    func set(type: CATransitionType) -> Self {
        animation.type = type
        return self
    }

    /// 转换的可选子类型。例如:用来指定
    /// 基于运动的过渡方向，在这种情况下
    /// 合法值是' fromLeft'， ' fromRight'， ' fromTop'和 “fromBottom”。
    @discardableResult
    func set(subtype: CATransitionSubtype) -> Self {
        animation.subtype = subtype
        return self
    }

    /// 从开始的过渡过程的数量
    /// 和结束执行。合法值是范围为[0,1]的数字。
    /// `endProgress `必须大于或等于`startProgress `。
    /// 默认值为0
    @discardableResult
    func set(startProgress: AxcUnifiedNumber) -> Self {
        animation.startProgress = assertTransformFloat(startProgress)
        return self
    }

    /// 从开始的过渡过程的数量
    /// 和结束执行。合法值是范围为[0,1]的数字。
    /// `endProgress `必须大于或等于`startProgress `。
    /// 默认值为1
    @discardableResult
    func set(endProgress: AxcUnifiedNumber) -> Self {
        animation.endProgress = assertTransformFloat(endProgress)
        return self
    }
}
