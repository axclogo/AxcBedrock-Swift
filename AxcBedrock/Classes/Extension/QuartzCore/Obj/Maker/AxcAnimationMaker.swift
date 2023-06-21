//
//  AxcCAAnimationMaker.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/28.
//

import QuartzCore

// MARK: - [AxcMaker.AnimationKeyPath]

public extension AxcMaker {
    /// 别名 完整名:AxcMaker.Animation.KeyPath
    typealias AnimationKeyPath = AxcMaker.Animation<CAAnimation>.KeyPath
}

// MARK: - [AxcMaker.Animation.KeyPath]

public extension AxcMaker.Animation {
    /// 动画键值
    enum KeyPath: String {
        // MARK: Transform 转换

        /// 比例转换
        case transform_scale = "transform.scale"
        /// 比例转换 X
        case transform_scale_x = "transform.scale.x"
        /// 比例转换 Y
        case transform_scale_y = "transform.scale.y"
        /// 比例转换 Z
        case transform_scale_z = "transform.scale.z"
        /// 旋转
        case transform_rotation = "transform.rotation"
        /// 旋转x
        case transform_rotation_x = "transform.rotation.x"
        /// 旋转y
        case transform_rotation_y = "transform.rotation.y"
        /// 旋转z
        case transform_rotation_z = "transform.rotation.z"
        /// 位移x
        case transform_translation_x = "transform.translation.x"
        /// 位移y
        case transform_translation_y = "transform.translation.y"

        // MARK: ContentsRect 框

        /// 内容
        case contents
        /// 内容Rect
        case contentsRect
        /// 内容width
        case contentsRect_size_width = "contentsRect.size.width"
        /// 内容height
        case contentsRect_size_Height = "contentsRect.size.height"

        // MARK: Stroke 线

        /// 绘制进度0-1
        case strokeEnd
        /// 绘制进度1-0
        case strokeStart

        // MARK: Layer 图层

        /// 透明度
        case opacity
        /// 背景色
        case backgroundColor
        /// 圆角
        case cornerRadius
        /// 边框宽度
        case borderWidth
        /// 边框颜色
        case borderColor
        /// 内容隐藏
        case hidden
        /// 布局
        case margin
        /// 大小
        case bounds
        /// 大小位置
        case frame
        /// 高度
        case zPosition
        /// 遮罩
        case mask
        /// 切割
        case masksToBounds
        /// 位置
        case position

        // MARK: Shadow 阴影

        /// 阴影颜色
        case shadowColor
        /// 阴影偏移
        case shadowOffset
        /// 阴影透明
        case shadowOpacity
        /// 阴影圆角
        case shadowRadius
    }
}

// MARK: - [AxcMaker.Animation]

public extension AxcMaker {
    /// Layer动画Maker
    class Animation<AnimationType: CAAnimation>: AxcAssertUnifiedTransformTarget {
        init(animation: AnimationType) {
            self.animation = animation
        }

        var animation: AnimationType
    }
}

public extension AxcMaker.Animation {
    /// 设置开始时间
    @discardableResult
    func set(beginTime: AxcUnifiedNumber) -> Self {
        animation.beginTime = CACurrentMediaTime() + assertTransformDouble(beginTime)
        return self
    }

    /// 设置持续时间
    @discardableResult
    func set(duration: AxcUnifiedNumber) -> Self {
        animation.duration = assertTransformDouble(duration)
        return self
    }

    /// 设置速度
    @discardableResult
    func set(speed: AxcUnifiedNumber) -> Self {
        animation.speed = assertTransformFloat(speed)
        return self
    }

    /// 设置时间偏移量
    @discardableResult
    func set(timeOffset: AxcUnifiedNumber) -> Self {
        animation.timeOffset = assertTransformDouble(timeOffset)
        return self
    }

    /// 设置重复次数
    @discardableResult
    func set(repeatCount: AxcUnifiedNumber) -> Self {
        animation.repeatCount = assertTransformFloat(repeatCount)
        return self
    }

    /// 设置永远重复
    @discardableResult
    func setRepeat() -> Self {
        return set(repeatCount: Float.infinity)
    }

    /// 设置重复时间
    @discardableResult
    func set(repeatDuration: AxcUnifiedNumber) -> Self {
        animation.repeatDuration = assertTransformDouble(repeatDuration)
        return self
    }

    /// 设置自动反向播放
    @discardableResult
    func set(autoreverses: Bool) -> Self {
        animation.autoreverses = autoreverses
        return self
    }

    /// 设置填充模式
    @discardableResult
    func set(fillMode: CAMediaTimingFillMode) -> Self {
        animation.fillMode = fillMode
        return self
    }

    /// 设置代理
    @discardableResult
    func set(delegate: CAAnimationDelegate) -> Self {
        animation.delegate = delegate
        return self
    }

    /// 设置完成后删除动画、动画完成后自动变回原样
    @discardableResult
    func set(removedOnCompletion: Bool) -> Self {
        animation.isRemovedOnCompletion = removedOnCompletion
        return self
    }

    /// 设置时间曲线
    @discardableResult
    func set(timingFunction: CAMediaTimingFunction) -> Self {
        animation.timingFunction = timingFunction
        return self
    }

    /// 设置预设时间曲线
    @discardableResult
    func set(name: CAMediaTimingFunctionName) -> Self {
        animation.timingFunction = CAMediaTimingFunction(name: name)
        return self
    }
}
