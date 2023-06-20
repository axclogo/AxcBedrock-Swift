//
//  AxcCATransitionEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/4/15.
//

import UIKit

// MARK: - 翻转动画Key
extension CATransition.AxcTransitionKey {
    /// 淡入淡出
    static var fade             = CATransition.AxcTransitionKey(CATransitionType.fade.rawValue)
    /// 推进效果
    static var push             = CATransition.AxcTransitionKey(CATransitionType.push.rawValue)
    /// 揭开效果
    static var reveal           = CATransition.AxcTransitionKey(CATransitionType.reveal.rawValue)
    /// 慢慢进入并覆盖效果
    static var moveIn           = CATransition.AxcTransitionKey(CATransitionType.moveIn.rawValue)
    /// 正方体翻转效果
    static var cube             = CATransition.AxcTransitionKey("cube")
    /// 翻页效果
    static var pageCurl         = CATransition.AxcTransitionKey("pageCurl")
    /// 反翻页效果
    static var pageUnCurl       = CATransition.AxcTransitionKey("pageUnCurl")
    /// 翻转
    static var oglFlip          = CATransition.AxcTransitionKey("oglFlip")
}

// MARK: - 动画样式
public extension CATransition {
    /// 动画变化键值Key
    struct AxcTransitionKey: Hashable, Equatable, RawRepresentable {
        public var rawValue: String
        public init(rawValue: String) { self.rawValue = rawValue }
        internal init(_ rawValue: String) { self.init(rawValue: rawValue) }
    }
}

// MARK: - 类方法/属性
public extension CATransition {
    // MARK: 协议
    // MARK: 扩展
}

// MARK: - 属性 & Api
public extension CATransition {
    // MARK: 协议
    // MARK: 扩展
}

// MARK: - 链式语法
public extension CATransition {
    /// 过渡的名称。目前的过渡类型包括
    /// “fade”，“moveIn”，“push”和“reveal”。默认为“消失”
    /// - Parameter type: 过渡的名称
    /// - Returns: CATransition
    @discardableResult
    func axc_setType(_ type: CATransitionType) -> Self {
        self.type = type
        return self
    }
    
    /// 转换的可选子类型。例如:用来指定
    /// 基于运动的过渡方向，在这种情况下
    /// 合法值是' fromLeft'， ' fromRight'， ' fromTop'和 “fromBottom”。
    /// - Parameter subtype: 可选子类型
    /// - Returns: CATransition
    @discardableResult
    func axc_setSubtype(_ subtype: CATransitionSubtype?) -> Self {
        self.subtype = subtype
        return self
    }
    
    /// 从开始的过渡过程的数量
    /// 和结束执行。合法值是范围为[0,1]的数字。
    /// `endProgress `必须大于或等于`startProgress `。
    /// 默认值为0
    /// - Parameter startProgress: 起始进度
    /// - Returns: CATransition
    @discardableResult
    func axc_setStartProgress(_ startProgress: Float) -> Self {
        self.startProgress = startProgress
        return self
    }
    
    /// 从开始的过渡过程的数量
    /// 和结束执行。合法值是范围为[0,1]的数字。
    /// `endProgress `必须大于或等于`startProgress `。
    /// 默认值为1
    /// - Parameter endProgress: 结束进度
    /// - Returns: CATransition
    @discardableResult
    func axc_setEndProgress(_ endProgress: Float) -> Self {
        self.endProgress = endProgress
        return self
    }
}

// MARK: - 决策判断
public extension CATransition {
    // MARK: 协议
    // MARK: 扩展
}

// MARK: - 操作符
public extension CATransition {
}

// MARK: - 运算符
public extension CATransition {
}
