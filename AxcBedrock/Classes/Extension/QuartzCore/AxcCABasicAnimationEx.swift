//
//  AxcCABasicAnimationEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/28.
//

import QuartzCore

// MARK: - 数据转换

public extension AxcSpace where Base == CABasicAnimation {}

// MARK: - 类方法

public extension AxcSpace where Base == CABasicAnimation {}

// MARK: - 属性 & Api

public extension AxcSpace where Base == CABasicAnimation {}

// MARK: - 链式语法设置

public extension AxcSpace where Base == CABasicAnimation {
    /// 设置动画代码块
    static func CreateAnimation(_ makeBlock: AxcBlock.Maker<AxcMaker.BasicAnimation<Base>>)
        -> Base
    {
        return .init().axc.makeAnimation(makeBlock)
    }

    /// 设置动画
    @discardableResult
    func makeAnimation(_ makeBlock: AxcBlock.Maker<AxcMaker.BasicAnimation<Base>>)
        -> Base
    {
        let handle: AxcMaker.BasicAnimation<Base> = .init(animation: base)
        makeBlock(handle)
        return handle.animation
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base == CABasicAnimation {}
