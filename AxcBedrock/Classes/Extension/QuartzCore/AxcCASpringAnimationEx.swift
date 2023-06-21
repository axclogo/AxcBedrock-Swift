//
//  AxcCASpringAnimationEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/10.
//

import QuartzCore

// MARK: - 数据转换

public extension AxcSpace where Base: CASpringAnimation {}

// MARK: - 类方法

public extension AxcSpace where Base: CASpringAnimation {}

// MARK: - 属性 & Api

public extension AxcSpace where Base: CASpringAnimation {}

// MARK: - 链式语法设置

public extension AxcSpace where Base: CASpringAnimation {
    /// 设置动画代码块
    static func CreateAnimation(_ makeBlock: AxcBlock.Maker<AxcMaker.SpringAnimation>)
        -> Base
    {
        return .init().axc.makeAnimation(makeBlock)
    }

    /// 设置动画
    @discardableResult
    func makeAnimation(_ makeBlock: AxcBlock.Maker<AxcMaker.SpringAnimation>)
        -> Base
    {
        let handle: AxcMaker.SpringAnimation = .init(animation: base)
        makeBlock(handle)
        return handle.animation as! Base
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: CASpringAnimation {}
