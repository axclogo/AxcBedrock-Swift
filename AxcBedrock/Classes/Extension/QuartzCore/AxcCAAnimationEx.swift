//
//  AxcCAAnimationEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/28.
//

import QuartzCore

// MARK: - 数据转换

public extension AxcSpace where Base: CAAnimation { }

// MARK: - 类方法

public extension AxcSpace where Base: CAAnimation { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: CAAnimation { }

// MARK: - 链式语法设置

/// 因为不想让此Api对子类开放，所以需要使用==来锁定
public extension AxcSpace where Base == CAAnimation {
    /// 设置动画代码块
    static func CreateAnimation(_ makeBlock: AxcBlock.Maker<AxcMaker.Animation<Base>>)
        -> Base {
        return .init().axc.makeAnimation(makeBlock)
    }

    /// 设置动画
    @discardableResult
    func makeAnimation(_ makeBlock: AxcBlock.Maker<AxcMaker.Animation<Base>>)
        -> Base {
        let handle: AxcMaker.Animation<Base> = .init(animation: base)
        makeBlock(handle)
        return handle.animation
    }
}

// MARK: - 代理转Block

private var kanimationDelegate = "kanimationDelegate"
public extension AxcSpace where Base: CAAnimation {
    /// 代理对象
    var animationDelegate: AxcDelegate.Animation {
        set { AxcRuntime.Set(object: self, key: &kanimationDelegate, value: newValue)
            base.delegate = newValue
        }
        get {
            guard let delegate: AxcDelegate.Animation = AxcRuntime.GetObject(self, key: &kanimationDelegate) else {
                let delegate = AxcDelegate.Animation()
                self.animationDelegate = delegate
                base.delegate = delegate
                return delegate
            }
            return delegate
        }
    }

    /// 块设置代理方法
    /// - Parameter block: block
    func makeAnimationDelegate(_ block: AxcBlock.OneParam<AxcDelegate.Animation>) {
        block(animationDelegate)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: CAAnimation { }
