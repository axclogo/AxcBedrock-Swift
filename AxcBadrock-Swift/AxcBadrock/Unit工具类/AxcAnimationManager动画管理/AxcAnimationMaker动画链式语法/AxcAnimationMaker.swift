//
//  AxcAnimationMaker.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/28.
//

import UIKit

// MARK: - 动画部分Key
public extension AxcAnimationMaker.Key {
    // MARK: Transform 转换
    /// 比例转换
    static var transform_scale          = AxcAnimationMaker.Key("transform.scale")
    /// 比例转换 X
    static var transform_scale_x        = AxcAnimationMaker.Key("transform.scale.x")
    /// 比例转换 Y
    static var transform_scale_y        = AxcAnimationMaker.Key("transform.scale.y")
    /// 比例转换 Z
    static var transform_scale_z        = AxcAnimationMaker.Key("transform.scale.z")
    /// 旋转
    static var transform_rotation       = AxcAnimationMaker.Key("transform.rotation")
    /// 旋转x
    static var transform_rotation_x     = AxcAnimationMaker.Key("transform.rotation.x")
    /// 旋转y
    static var transform_rotation_y     = AxcAnimationMaker.Key("transform.rotation.y")
    /// 旋转z
    static var transform_rotation_z     = AxcAnimationMaker.Key("transform.rotation.z")
    /// 位移x
    static var transform_translation_x  = AxcAnimationMaker.Key("transform.translation.x")
    /// 位移y
    static var transform_translation_y  = AxcAnimationMaker.Key("transform.translation.y")
    
    // MARK: ContentsRect 框
    /// 内容
    static var contents                 = AxcAnimationMaker.Key("contents")
    /// 内容Rect
    static var contentsRect             = AxcAnimationMaker.Key("contentsRect")
    /// 内容width
    static var contentsRect_size_width  = AxcAnimationMaker.Key("contentsRect.size.width")
    /// 内容height
    static var contentsRect_size_Height = AxcAnimationMaker.Key("contentsRect.size.height")
    
    // MARK: Stroke 线
    /// 绘制进度0-1
    static var strokeEnd    = AxcAnimationMaker.Key("strokeEnd")
    /// 绘制进度1-0
    static var strokeStart  = AxcAnimationMaker.Key("strokeStart")
    
    // MARK: Layer 图层
    /// 透明度
    static var opacity          = AxcAnimationMaker.Key("opacity")
    /// 背景色
    static var backgroundColor  = AxcAnimationMaker.Key("backgroundColor")
    /// 圆角
    static var cornerRadius     = AxcAnimationMaker.Key("cornerRadius")
    /// 边框宽度
    static var borderWidth      = AxcAnimationMaker.Key("borderWidth")
    /// 边框颜色
    static var borderColor      = AxcAnimationMaker.Key("borderColor")
    /// 内容隐藏
    static var hidden           = AxcAnimationMaker.Key("hidden")
    /// 布局
    static var margin           = AxcAnimationMaker.Key("margin")
    /// 大小
    static var bounds           = AxcAnimationMaker.Key("bounds")
    /// 大小位置
    static var frame            = AxcAnimationMaker.Key("frame")
    /// 高度
    static var zPosition        = AxcAnimationMaker.Key("zPosition")
    /// 遮罩
    static var mask             = AxcAnimationMaker.Key("mask")
    /// 切割
    static var masksToBounds    = AxcAnimationMaker.Key("masksToBounds")
    /// 位置
    static var position         = AxcAnimationMaker.Key("position")
    
    // MARK: Shadow 阴影
    /// 阴影颜色
    static var shadowColor      = AxcAnimationMaker.Key("shadowColor")
    /// 阴影偏移
    static var shadowOffset     = AxcAnimationMaker.Key("shadowOffset")
    /// 阴影透明
    static var shadowOpacity    = AxcAnimationMaker.Key("shadowOpacity")
    /// 阴影圆角
    static var shadowRadius     = AxcAnimationMaker.Key("shadowRadius")
}


public typealias AxcAnimationMakerBlock = (_ make: AxcAnimationMaker) -> Void

open class AxcAnimationMaker {
    // MARK: - 动画键值Key
    /// 动画变化键值Key
    public struct Key: Hashable, Equatable, RawRepresentable {
        public var rawValue: String
        public init(rawValue: String) { self.rawValue = rawValue }
        internal init(_ rawValue: String) { self.init(rawValue: rawValue) }
    }
    
    // MARK: - 初始化
    public convenience init(_ layer: CALayer) {
        self.init()
        self.layer = layer
    }
    
    // MARK: - Api
    /// 执行动画的layer
    open var layer: CALayer? = nil
    /// 所有动画
    open var animations: [CAAnimation] = []
    /// 所有组动画
    open var animationGroups: [CAAnimation] = []
    
    // MARK: CABasicAnimation 基础动画
    /// 基础动画
    open var basicAnimation: CABasicAnimation {
        return basicAnimation()
    }
    /// 基础动画
    open func basicAnimation(_ key: AxcAnimationMaker.Key? = nil) -> CABasicAnimation {
        let basicAnimation = CABasicAnimation(key)
        addAnimation(basicAnimation)
        return basicAnimation
    }
    // MARK: CAKeyframeAnimation 关键帧动画
    /// 关键帧动画
    open var keyframeAnimation: CAKeyframeAnimation {
        return keyframeAnimation()
    }
    /// 关键帧动画
    open func keyframeAnimation(_ key: AxcAnimationMaker.Key? = nil) -> CAKeyframeAnimation {
        let keyframeAnimation = CAKeyframeAnimation(key)
        addAnimation(keyframeAnimation)
        return keyframeAnimation
    }
    // MARK: CASpringAnimation 弹性动画
    /// 弹性动画
    open var springAnimation: CASpringAnimation {
        return springAnimation()
    }
    /// 弹性动画
    open func springAnimation(_ key: AxcAnimationMaker.Key? = nil) -> CASpringAnimation {
        let springAnimation = CASpringAnimation(key)
        addAnimation(springAnimation)
        return springAnimation
    }
    // MARK: 转场动画
    /// 转场动画
    open var transition: CATransition {
        let transition = CATransition()
        addAnimation(transition)
        return transition
    }
    
    // MARK: CAAnimationGroup 组动画
    /// 组动画
    open var groupAnimation: CAAnimationGroup {
        let basicAnimation = CAAnimationGroup()
        addAnimation(basicAnimation)
        return basicAnimation
    }
    
    /// 添加一个动画
    /// - Parameter animation: 动画
    /// - Returns: 添加的动画
    @discardableResult
    open func addAnimation(_ animation: CAAnimation) -> CAAnimation {
        animations.append(animation)
        return animation
    }
}
