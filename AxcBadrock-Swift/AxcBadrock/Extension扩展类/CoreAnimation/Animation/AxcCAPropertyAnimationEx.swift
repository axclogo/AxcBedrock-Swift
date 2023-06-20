//
//  AxcCAPropertyAnimationEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/28.
//

import UIKit

// MARK: - 类方法
public extension CAPropertyAnimation {
    /// 键值方式实例化
    /// - Parameter key: 动画键值
    convenience init(_ key: AxcAnimationMaker.Key?) {
        self.init(keyPath: key?.rawValue)
        axc_setTimingFunction(.easeInEaseOut) // 默认循序渐进曲线
    }
}

// MARK: - 链式语法
public extension CAPropertyAnimation {
    /// 设置要改变的属性值
    @discardableResult
    func axc_setKeyPath(_ key: AxcAnimationMaker.Key) -> Self {
        self.keyPath = key.rawValue
        return self
    }
    /// 设置要改变的属性值
    @discardableResult
    func axc_setKeyPath(keyPath: String?) -> Self {
        self.keyPath = keyPath
        return self
    }
    
    /// 当值为true时，动画指定的值将被“添加”到产生新属性的当前表示值
    /// 对于仿射变换，默认为false
    /// - Parameter isAdditive: isAdditive
    /// - Returns: Self
    @discardableResult
    func axc_setIsAdditive(_ isAdditive: Bool) -> Self {
        self.isAdditive = isAdditive
        return self
    }
    
    /// 累积
    /// “累积”属性影响重复动画的产生方式
    /// 如果为真，那么动画的当前值是在前一个重复循环结束时的值，加上重复周期。
    /// 如果为false，则该值只是简单的值，为当前重复周期计算
    /// - Parameter isCumulative: 累积
    /// - Returns: Self
    @discardableResult
    func axc_setIsCumulative(_ isCumulative: Bool) -> Self {
        self.isCumulative = isCumulative
        return self
    }
    
    /// 插值函数
    /// 如果为非nil，一个用于插值的函数在它们被设置为动画的新表示值之前的属性。
    /// 默认为零
    /// - Parameter valueFunction: 插值
    /// - Returns: Self
    @discardableResult
    func axc_setValueFunction(_ valueFunction: CAValueFunction?) -> Self {
        self.valueFunction = valueFunction
        return self
    }
}
