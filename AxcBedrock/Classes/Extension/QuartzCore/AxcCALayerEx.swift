//
//  AxcCALayerEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/28.
//

import QuartzCore

// MARK: - 数据转换

public extension AxcSpace where Base: CALayer { }

// MARK: - 类方法

public extension AxcSpace where Base: CALayer { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: CALayer {
    /// 在主线程添加图层
    /// - Parameter layer: 图层
    func addSublayer(_ layer: CALayer) {
        AxcGCD.Main { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.base.addSublayer(layer)
        }
    }

    /// 在主线程从父图层移除自己
    func removeFromSuperlayer() {
        AxcGCD.Main { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.base.removeFromSuperlayer()
        }
    }

    /// 在主线程移除所有子图层
    func removeAllSubLayers() {
        AxcGCD.Main { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.base.sublayers?.forEach {
                $0.removeFromSuperlayer()
            }
        }
    }
}

// MARK: - 链式语法动画

public extension AxcSpace where Base: CALayer {
    /// 设置动画
    /// - Parameters:
    ///   - makeBlock: 设置代码块
    ///   - complete: 单个执行完的回调
    ///   - allComplete: 全部执行完的回调
    func makeAnimation(_ makeBlock: AxcBlock.Maker<AxcMaker.LayerAnimation>,
                       complete: AxcBlock.OneParam<CAAnimation>? = nil,
                       allComplete: AxcBlock.Empty? = nil) {
        base.removeAllAnimations() // 移除所有动画
        let handle: AxcMaker.LayerAnimation = .init(layer: base)
        makeBlock(handle)
        playAnimations(handle.animations, complete: complete, allComplete: allComplete) // 开始执行
    }

    /// 播放一组动画
    func playAnimations(_ animations: [CAAnimation],
                        complete: AxcBlock.OneParam<CAAnimation>? = nil,
                        allComplete: AxcBlock.Empty? = nil) {
        func recursivePlay(_ animations: [CAAnimation]) {
            var animations = animations

            guard let animation = animations.first else { // 一滴都没了
                allComplete?() // 动画全部执行完
                animations.removeAll() // 移除全部
                return
            }
            addAnimation(animation) { anim, _ in
                complete?(anim) // 单个执行完回调
                if !animations.axc.isCrossing(0) { // 如果还有元素
                    animations = animations.axc.remove(at: 0) // 移除这个动画
                }
                recursivePlay(animations) // 递归执行下一个动画
            }
        }
        recursivePlay(animations)
    }

    /// 添加动画并回调完成
    func addAnimation(_ animation: CAAnimation,
                      key: String? = nil,
                      complete: AxcBlock.TwoParam<CAAnimation, Bool>? = nil) {
        animation.axc.animationDelegate.set(animationMakerEndBlock: complete)
        base.add(animation, forKey: key)
    }
}

// MARK: - 外观设置

public extension AxcSpace where Base: CALayer {
    /// 设置部分圆角
    /// - Parameters:
    ///   - radius: 圆角半径
    ///   - maskedCorners: 圆角方位
    @available(iOS 11.0, tvOS 11.0, *)
    func set(corners: AxcCorner,
             cornerRadius: CGFloat) {
        base.cornerRadius = cornerRadius
        base.masksToBounds = true
        base.maskedCorners = corners.toCACornerMask
    }

    /// 读写x
    var x: CGFloat {
        get { base.frame.origin.x }
        set { base.frame = base.frame.axc.set(x: newValue) }
    }

    /// 读写y
    var y: CGFloat {
        get { base.frame.origin.y }
        set { base.frame = base.frame.axc.set(y: newValue) }
    }

    /// 读写width
    var width: CGFloat {
        get { base.frame.size.width }
        set { base.frame = base.frame.axc.set(width: newValue) }
    }

    /// 读写height
    var height: CGFloat {
        get { base.frame.size.height }
        set { base.frame = base.frame.axc.set(height: newValue) }
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: CALayer { }
