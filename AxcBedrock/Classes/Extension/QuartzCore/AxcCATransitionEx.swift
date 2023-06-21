//
//  AxcCATransitionEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/28.
//

import QuartzCore

// MARK: - 数据转换

public extension AxcSpace where Base: CATransition {}

// MARK: - 类方法

public extension AxcSpace where Base: CATransition {}

// MARK: - 属性 & Api

public extension AxcSpace where Base: CATransition {}

// MARK: - 链式语法设置

public extension AxcSpace where Base: CATransition {
    /// 设置动画代码块
    static func CreateAnimation(_ makeBlock: AxcBlock.Maker<AxcMaker.Transition>)
        -> Base
    {
        return .init().axc.makeAnimation(makeBlock)
    }

    /// 设置动画
    @discardableResult
    func makeAnimation(_ makeBlock: AxcBlock.Maker<AxcMaker.Transition>)
        -> Base
    {
        let handle: AxcMaker.Transition = .init(animation: base)
        makeBlock(handle)
        return handle.animation as! Base
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: CATransition {}
