//
//  AxcKeyframeAnimationMaker.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/28.
//

import QuartzCore

// MARK: - [AxcMaker.KeyframeAnimation]

public extension AxcMaker {
    /// Layer动画Maker
    class KeyframeAnimation: AxcMaker.PropertyAnimation<CAKeyframeAnimation> { }
}

public extension AxcMaker.KeyframeAnimation {
    /// 一个对象数组，它提供了动画函数的值
    @discardableResult
    func set(values: [Any]) -> Self {
        animation.values = values
        return self
    }

    /// 一个可选的路径对象，定义动画的行为
    /// 当非nil覆盖' values'属性时。每一个点 在路径中除了' moveto'点定义一个单独的关键帧 定时和插补
    /// 沿路径的匀速动画，' calculationMode'应该 设置为' pace '
    @discardableResult
    func set(path: CGPath) -> Self {
        animation.path = path
        return self
    }

    /// NSNumber对象的可选数组，定义 动画。每个time对应于' values'数组中的一个值
    /// 定义了什么时候该值应该在动画函数中使用。
    /// 数组中的每个值都是范围内的浮点数 0 - 1。
    @discardableResult
    func set(keyTimes: [AxcUnifiedNumber]) -> Self {
        animation.keyTimes = keyTimes.map { assertTransformNumber($0) }
        return self
    }

    /// 时间曲线
    /// 一个可选的cameatimingfunction对象数组。如果' values'数组 定义n个关键帧，应该有n-1个对象在 “timingFunctions”数组。
    /// 每个函数描述一个函数的关键帧到关键帧段。
    @discardableResult
    func set(timingFunctions: [CAMediaTimingFunction]) -> Self {
        animation.timingFunctions = timingFunctions
        return self
    }

    /// 计算模式 可能的值是离散的，线性的，默认为“线性”。
    /// 当设置为 “keyTimes”和“timingFunctions” 动画的属性被忽略并隐式计算
    @discardableResult
    func set(calculationMode: CAAnimationCalculationMode) -> Self {
        animation.calculationMode = calculationMode
        return self
    }

    /// 张力值
    @discardableResult
    func set(tensionValues: [AxcUnifiedNumber]) -> Self {
        animation.tensionValues = tensionValues.map { assertTransformNumber($0) }
        return self
    }

    /// 连续性的
    @discardableResult
    func set(continuityValues: [AxcUnifiedNumber]) -> Self {
        animation.continuityValues = continuityValues.map { assertTransformNumber($0) }
        return self
    }

    /// 偏差值
    @discardableResult
    func set(biasValues: [AxcUnifiedNumber]) -> Self {
        animation.biasValues = biasValues.map { assertTransformNumber($0) }
        return self
    }

    /// 旋转模式
    /// 定义沿着路径动画的或对象是否旋转以匹配路径切线。
    /// 时将此属性设置为非空值的效果未定义提供的任何路径对象。“autoReverse”旋转匹配正切+ 180度。
    @discardableResult
    func set(rotationMode: CAAnimationRotationMode) -> Self {
        animation.rotationMode = rotationMode
        return self
    }
}
