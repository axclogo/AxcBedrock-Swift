//
//  AxcBasicAnimationMaker.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/28.
//

import QuartzCore

// MARK: - [AxcMaker.BasicAnimation]

public extension AxcMaker {
    /// Layer动画Maker
    class BasicAnimation<BasicType: CABasicAnimation>: AxcMaker.PropertyAnimation<BasicType> { }
}

public extension AxcMaker.BasicAnimation {
    /// 从。。。值
    @discardableResult
    func set(fromValue: Any?) -> Self {
        animation.fromValue = fromValue
        return self
    }

    /// 到。。。值
    @discardableResult
    func set(toValue: Any?) -> Self {
        animation.toValue = toValue
        return self
    }

    /// 经过。。。值
    @discardableResult
    func set(byValue: Any?) -> Self {
        animation.byValue = byValue
        return self
    }
}
