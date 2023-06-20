//
//  AxcCALayerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

// MARK: - 类方法/属性
public extension CALayer {
}

// MARK: - 属性 & Api
public extension CALayer {
    /// 移除所有子图层
    func axc_removeAllSubLayers() {
        sublayers?.forEach{ $0.removeFromSuperlayer() }
    }
}

// MARK: - 动画的链式语法扩展
// MARK: Runtime绑定
private var kanimations = "kanimations"
extension CALayer {
    /// 通过链式语法maker添加的动画组
    private var animations: [CAAnimation] {
        set { AxcRuntime.setObj(self, &kanimations, newValue) }
        get { // runtime懒加载
            guard let animations: [CAAnimation] = AxcRuntime.getObj(self, &kanimations) else {
                let _animations: [CAAnimation] = []
                self.animations = _animations   // set
                return _animations
            }
            return animations
        }
    }
}

// MARK: 设置动画相关
public extension CALayer {
    /// 链式语法中继器
    func axc_makeCAAnimation(_ makeBlock: AxcAnimationMakerBlock, complete: AxcEmptyBlock? = nil) {
        removeAllAnimations() // 移除所有动画
        let make = AxcAnimationMaker(self)
        makeBlock( make )
        animations = make.animations    // 获取所有动画集合
        showAnimations(complete)    // 开始执行
    }
    // 开始动画
    private func showAnimations(_ complete: AxcEmptyBlock? = nil) {
        guard let animation = animations.first else {   // 一滴都没了
            complete?() // 动画全部执行完
            animations.removeAll() // 移除全部
            return
        }
        axc_addAnimation(animation) { [weak self] (animation, _) in
            guard let weakSelf = self else { return }
            weakSelf.showAnimations(complete)   // 递归执行下一个动画
        }
        if animations.axc_safeIdx(0) {  // 如果还有元素
            animations.axc_remove(0)    // 移除这个动画
        }
    }
    /// 添加动画并回调完成
    func axc_addAnimation(_ animation: CAAnimation,
                          key: String? = nil,
                          completeBlock: CAAnimation.AxcBoolBlock<Void>? = nil) {
        if let block = completeBlock { animation.didEndBlock(block) }
        add(animation, forKey: key)
    }
}

// MARK: - 监听相关
public extension CALayer {
    /// 添加Frame监听回调
    /// - Parameters:
    ///   - block: 回调
    ///   - cycle: 生命周期管理器 默认当前控制器的生命周期
    func axc_setObserverFrame(firstTrigger: Bool = false,
                              block: @escaping AxcLayerBlock) -> AxcObserver {
        return axc_observer.axc_setKeyPath(.frame, firstTrigger: firstTrigger)
        { [weak self] (_, _, _, _) in
            guard let weakSelf = self else { return }
            block(weakSelf)
        }
    }
    /// 主动移除Frame监听回调
    func axc_removeObserverFrame() {
        axc_observer.axc_removeKeyPath(.frame)
    }
    
    /// 添加Sublayers监听回调
    /// - Parameters:
    ///   - block: 回调
    ///   - cycle: 生命周期管理器 默认当前控制器的生命周期
    func axc_setObserverSublayers(firstTrigger: Bool = false,
                                 block: @escaping AxcLayerBlock) -> AxcObserver {
        return axc_observer.axc_setKeyPath(.sublayers, firstTrigger: firstTrigger)
        { [weak self] (_, _, _, _) in
            guard let weakSelf = self else { return }
            block(weakSelf)
        }
    }
    /// 主动移除Subviews监听回调
    func axc_removeObserverSubviews() {
        axc_observer.axc_removeKeyPath(.sublayers)
    }
}

// MARK: - 边框圆角
public extension CALayer {
    /// 边框颜色
    var axc_borderColor: UIColor? {
        get { guard let color = borderColor else { return nil }
            return UIColor(cgColor: color) }
        set { guard let color = newValue else { borderColor = nil; return }
            borderColor = color.cgColor }
    }
    /// 边框宽度
    var axc_borderWidth: CGFloat {
        get { return borderWidth }
        set { borderWidth = newValue }
    }
    /// 圆角
    var axc_cornerRadius: CGFloat {
        get { return cornerRadius }
        set { cornerRadius = newValue.axc_abs }
    }
    /// 阴影颜色
    var axc_shadowColor: UIColor? {
        get { guard let color = shadowColor else { return nil }
            return UIColor(cgColor: color) }
        set { guard let color = newValue else { shadowColor = nil; return }
            shadowColor = color.cgColor }
    }
    /// 阴影透明度
    var axc_shadowOpacity: CGFloat {
        get { return shadowOpacity.axc_cgFloat }
        set { shadowOpacity = newValue.axc_float }
    }
    /// 阴影偏移
    var axc_shadowOffset: CGSize {
        get { return shadowOffset }
        set { shadowOffset = newValue }
    }
    /// 阴影圆角
    var axc_shadowRadius: CGFloat {
        get { return shadowRadius }
        set { shadowRadius = newValue }
    }
    /// 遮罩边缘
    var axc_masksToBounds: Bool {
        get { return masksToBounds }
        set { masksToBounds = newValue }
    }
}

// MARK: - frame扩展属性
public extension CALayer {
    /// 读写x
    var axc_x: CGFloat {
        set { frame = CGRect(x: newValue, y: frame.axc_y, width: frame.axc_width, height: frame.axc_height) }
        get { return frame.axc_x }
    }
    /// 读写y
    var axc_y: CGFloat {
        set { frame = CGRect(x: frame.axc_x , y: newValue, width: frame.axc_width, height: frame.axc_height) }
        get { return frame.axc_y }
    }
    /// 读写width
    var axc_width: CGFloat {
        set { frame = CGRect(x: frame.axc_x , y: frame.axc_y, width: newValue, height: frame.axc_height) }
        get { return frame.axc_width }
    }
    /// 读写height
    var axc_height: CGFloat {
        set { frame = CGRect(x: frame.axc_x , y: frame.axc_y, width: frame.axc_width, height: newValue) }
        get { return frame.axc_height }
    }
    /// 读写left
    var axc_left: CGFloat {
        set { axc_x = newValue }
        get { return frame.axc_left }
    }
    /// 读写right
    var axc_right: CGFloat {
        set { axc_x = newValue - axc_width }
        get { return frame.axc_right }
    }
    /// 读写top
    var axc_top: CGFloat {
        set { axc_y = newValue }
        get { return frame.axc_top }
    }
    /// 读写bottom
    var axc_bottom: CGFloat {
        set { axc_y = newValue - axc_height }
        get { return frame.axc_bottom }
    }
    /// 读写origin
    var axc_origin: CGPoint {
        set { frame = CGRect(origin: newValue, size: axc_size ) }
        get { return frame.axc_origin }
    }
    /// 读写size
    var axc_size: CGSize {
        set { frame = CGRect(origin: frame.axc_origin, size: newValue) }
        get { return frame.axc_size }
    }
    /// 读写center
    var axc_center: CGPoint {
        set {
            axc_x = newValue.x - axc_size.width / 2
            axc_y = newValue.y - axc_size.height / 2
        }
        get { CGPoint(x: frame.axc_x + axc_size.width / 2, y: frame.axc_y + axc_size.height / 2) }
    }
    /// 读写centerX
    var axc_centerX: CGFloat {
        get { return axc_center.x }
        set { axc_center.x = newValue }
    }
    /// 读写centerY
    var axc_centerY: CGFloat {
        get { return axc_center.y }
        set { axc_center.y = newValue }
    }
}


// MARK: - 决策判断
public extension CALayer {
}

// MARK: - 操作符
public extension CALayer {
}

// MARK: - 运算符
public extension CALayer {
}
