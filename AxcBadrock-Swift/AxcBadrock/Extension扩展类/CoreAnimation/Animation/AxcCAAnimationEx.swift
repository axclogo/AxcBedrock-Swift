//
//  AxcCAAnimationEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/28.
//

import UIKit

// MARK: - 动画链式语法
// MARK: Runtime绑定回调
public extension CAAnimation {
    /// 设置动画开始执行的回调
    @discardableResult
    func axc_setStartBlock(_ block: AxcBlock<Void>?) -> Self {
        axc_animationDelegate.axc_setAnimationDidStartBlock(block)
        return self
    }
    /// 设置动画执行完成的回调
    @discardableResult
    func axc_setEndBlock(_ block: AxcBoolBlock<Void>?) -> Self {
        axc_animationDelegate.axc_setAnimationStopFinishedBlock(block)
        return self
    }
    /// 设置动画已经执行完成的回调
    /// 警告：私有，不建议使用该方法 随时可能废弃
    @discardableResult
    func didEndBlock(_ block: AxcBoolBlock<Void>?) -> Self {
        axc_animationDelegate.axc_setAnimationDidStopFinishedBlock(block)
        return self
    }
}

// MARK: 属性附加
public extension CAAnimation {
    /// 设置开始时间
    @discardableResult
    func axc_setBeginTime(_ beginTime: CGFloat) -> Self {
        self.beginTime = CACurrentMediaTime() + beginTime.axc_double
        return self
    }
    /// 设置持续时间
    @discardableResult
    func axc_setDuration(_ duration: AxcUnifiedNumberTarget? ) -> Self {
        let _duration = duration ?? Axc_duration.axc_double
        self.duration = _duration.axc_double
        return self
    }
    /// 设置速度
    @discardableResult
    func axc_setSpeed(_ speed: AxcUnifiedNumberTarget) -> Self {
        self.speed = speed.axc_float
        return self
    }
    /// 设置时间偏移量
    @discardableResult
    func axc_setTimeOffset(_ timeOffset: AxcUnifiedNumberTarget) -> Self {
        self.timeOffset = timeOffset.axc_double
        return self
    }
    /// 设置重复次数
    @discardableResult
    func axc_setRepeatCount(_ repeatCount: Int) -> Self {
        self.repeatCount = repeatCount.axc_float
        return self
    }
    /// 设置重复次数
    @discardableResult
    func axc_setRepeatCount(_ repeatCount: CGFloat) -> Self {
        self.repeatCount = repeatCount.axc_float
        return self
    }
    /// 设置永远重复
    @discardableResult
    func axc_setRepeat() -> Self {
        return axc_setRepeatCount( Axc_floatInfinity )
    }
    /// 设置重复时间
    @discardableResult
    func axc_setRepeatDuration(_ repeatDuration: AxcUnifiedNumberTarget) -> Self {
        self.repeatDuration = repeatDuration.axc_double
        return self
    }
    /// 设置自动反向播放
    @discardableResult
    func axc_setAutoreverses(_ autoreverses: Bool) -> Self {
        self.autoreverses = autoreverses
        return self
    }
    /// 设置填充模式
    @discardableResult
    func axc_setFillMode(_ fillMode: CAMediaTimingFillMode) -> Self {
        self.fillMode = fillMode
        return self
    }
    /// 设置代理
    @discardableResult
    func axc_setDelegate(_ delegate: CAAnimationDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    /// 设置完成后删除动画、动画完成后自动变回原样
    @discardableResult
    func axc_setRemovedOnCompletion(_ removedOnCompletion: Bool) -> Self {
        self.isRemovedOnCompletion = removedOnCompletion
        return self
    }
    /// 设置时间曲线
    @discardableResult
    func axc_setTimingFunction(timingFunction: CAMediaTimingFunction) -> Self {
        self.timingFunction = timingFunction
        return self
    }
    /// 设置预设时间曲线
    @discardableResult
    func axc_setTimingFunction(_ name: CAMediaTimingFunctionName) -> Self {
        self.timingFunction = CAMediaTimingFunction(name: name)
        return self
    }
}

// MARK: - 代理转Block
private var kaxc_animationDelegate = "kaxc_animationDelegate"
public extension CAAnimation {
    /// 返回CAAnimation的Block声明
    typealias AxcBlock<T> = (CAAnimation) -> T
    /// 返回CAAnimation,Bool的Block声明
    typealias AxcBoolBlock<T> = (CAAnimation,Bool) -> T
    
    /// 代理桥接者
    var axc_animationDelegate: AxcCAAnimationDelegate {
        set { AxcRuntime.setObj(self, &kaxc_animationDelegate, newValue)
            self.delegate = newValue
        }
        get {
            guard let delegate: AxcCAAnimationDelegate  = AxcRuntime.getObj(self, &kaxc_animationDelegate)
            else {
                let delegate = AxcCAAnimationDelegate()
                self.axc_animationDelegate = delegate
                self.delegate = delegate
                return delegate
            }
            return delegate
        }
    }
    /// 块设置代理方法
    /// - Parameter block: block
    func axc_makeAnimationDelegate(_ block: (AxcCAAnimationDelegate) -> Void) {
        block(axc_animationDelegate)
    }
}

// MARK: 桥接者
/// 代理转Block桥接者
open class AxcCAAnimationDelegate: NSObject, CAAnimationDelegate {
    ///  动画开始
    @discardableResult
    open func axc_setAnimationDidStartBlock(_ block: CAAnimation.AxcBlock<Void>?) -> Self {
        axc_animationDidStartBlock = block
        return self
    }
    open var axc_animationDidStartBlock: CAAnimation.AxcBlock<Void>?
    public func animationDidStart(_ anim: CAAnimation) -> Void {
        axc_animationDidStartBlock?(anim)
    }
    
    
    ///  动画结束
    @discardableResult
    open func axc_setAnimationStopFinishedBlock(_ block: CAAnimation.AxcBoolBlock<Void>?) -> Self {
        axc_animationStopFinishedBlock = block
        return self
    }
    open var axc_animationStopFinishedBlock: CAAnimation.AxcBoolBlock<Void>?
    
    ///  动画已经结束
    @discardableResult
    open func axc_setAnimationDidStopFinishedBlock(_ block: CAAnimation.AxcBoolBlock<Void>?) -> Self {
        axc_animationDidStopFinishedBlock = block
        return self
    }
    open var axc_animationDidStopFinishedBlock: CAAnimation.AxcBoolBlock<Void>?
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) -> Void {
        axc_animationStopFinishedBlock?(anim,flag)
        axc_animationDidStopFinishedBlock?(anim,flag)
    }
}
