//
//  AxcCAKeyframeAnimationEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/28.
//

import UIKit

// MARK: - 链式语法
public extension CAKeyframeAnimation {
    /// 一个对象数组，它提供了动画函数的值
    /// - Parameter values: 每个关键帧
    /// - Returns: Self
    @discardableResult
    func axc_setValues(_ values: [Any]?) -> Self {
        self.values = values
        return self
    }
    
    /// 一个可选的路径对象，定义动画的行为
    /// 当非nil覆盖' values'属性时。每一个点 在路径中除了' moveto'点定义一个单独的关键帧 定时和插补
    /// 沿路径的匀速动画，' calculationMode'应该 设置为' pace '
    /// - Parameter path: 路径
    /// - Returns: Self
    @discardableResult
    func axc_setPath(_ path: CGPath?) -> Self {
        self.path = path
        return self
    }
    
    /// NSNumber对象的可选数组，定义 动画。每个time对应于' values'数组中的一个值
    /// 定义了什么时候该值应该在动画函数中使用。
    /// 数组中的每个值都是范围内的浮点数 0 - 1。
    /// - Parameter keyTimes: 时间片
    /// - Returns: Self
    @discardableResult
    func axc_setKeyTimes(_ keyTimes: [NSNumber]?) -> Self {
        self.keyTimes = keyTimes
        return self
    }
    
    /// 时间曲线
    /// 一个可选的cameatimingfunction对象数组。如果' values'数组 定义n个关键帧，应该有n-1个对象在 “timingFunctions”数组。
    /// 每个函数描述一个函数的关键帧到关键帧段。
    /// - Parameter timingFunctions: 关键帧段
    /// - Returns: Self
    @discardableResult
    func axc_setTimingFunctions(_ timingFunctions: [CAMediaTimingFunction]?) -> Self {
        self.timingFunctions = timingFunctions
        return self
    }
    
    /// 计算模式 可能的值是离散的，线性的，默认为“线性”。
    /// 当设置为 “keyTimes”和“timingFunctions” 动画的属性被忽略并隐式计算
    /// - Parameter calculationMode: 线性
    /// - Returns: Self
    @discardableResult
    func axc_setCalculationMode(_ calculationMode: CAAnimationCalculationMode) -> Self {
        self.calculationMode = calculationMode
        return self
    }
    
    /// 张力值
    /// - Parameter tensionValues: 张力值
    /// - Returns: Self
    @discardableResult
    func axc_setTensionValues(_ tensionValues: [NSNumber]?) -> Self {
        self.tensionValues = tensionValues
        return self
    }
    
    /// 连续性的
    /// - Parameter continuityValues: 连续性的值
    /// - Returns: Self
    @discardableResult
    func axc_setContinuityValues(_ continuityValues: [NSNumber]?) -> Self {
        self.continuityValues = continuityValues
        return self
    }
    
    /// 偏差值
    /// - Parameter biasValues: 偏差值
    /// - Returns: Self
    @discardableResult
    func axc_setBiasValues(_ biasValues: [NSNumber]?) -> Self {
        self.biasValues = biasValues
        return self
    }
    
    /// 旋转模式
    /// 定义沿着路径动画的或对象是否旋转以匹配路径切线。
    /// 时将此属性设置为非空值的效果未定义提供的任何路径对象。“autoReverse”旋转匹配正切+ 180度。
    /// - Parameter rotationMode: 旋转模式
    /// - Returns: Self
    @discardableResult
    func axc_setRotationMode(_ rotationMode: CAAnimationRotationMode?) -> Self {
        self.rotationMode = rotationMode
        return self
    }
}
