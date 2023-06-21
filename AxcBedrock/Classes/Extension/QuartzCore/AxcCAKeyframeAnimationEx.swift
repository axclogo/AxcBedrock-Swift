//
//  AxcCAKeyframeAnimationEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/28.
//

import QuartzCore

// MARK: - 数据转换

public extension AxcSpace where Base: CAKeyframeAnimation {}

// MARK: - 类方法

public extension AxcSpace where Base: CAKeyframeAnimation {}

// MARK: - 属性 & Api

public extension AxcSpace where Base: CAKeyframeAnimation {}

// MARK: - 链式语法设置

public extension AxcSpace where Base: CAKeyframeAnimation {
    /// 设置动画代码块
    static func CreateAnimation(_ makeBlock: AxcBlock.Maker<AxcMaker.KeyframeAnimation>)
        -> Base
    {
        return .init().axc.makeAnimation(makeBlock)
    }

    /// 设置动画
    @discardableResult
    func makeAnimation(_ makeBlock: AxcBlock.Maker<AxcMaker.KeyframeAnimation>)
        -> Base
    {
        let handle: AxcMaker.KeyframeAnimation = .init(animation: base)
        makeBlock(handle)
        return handle.animation as! Base
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: CAKeyframeAnimation {}
