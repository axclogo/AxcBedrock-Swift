//
//  AxcCAMediaTimingFunctionNameEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/18.
//

import QuartzCore

// MARK: - 数据转换

public extension AxcSpace where Base == CAMediaTimingFunction {
    
}

// MARK: - 类方法

public extension AxcSpace where Base == CAMediaTimingFunction {
    /// 弹簧时间曲线
    static let spring: Base = spring()
    /// 弹簧时间曲线
    /// - Parameter force: 力度 默认0.3
    /// - Returns: CAMediaTimingFunction
    static func spring(_ force: AxcUnifiedNumber = 0.3) -> Base {
        let _force = AssertTransformFloat(force)
        return .init(controlPoints: 0.5, 1.1 + (_force / 3), 1, 1)
    }

    /// 开始正弦曲线
    static let easeInSine: Base = .init(controlPoints: 0.47, 0, 0.745, 0.715)
    /// 结束正弦曲线
    static let easeOutSine: Base = .init(controlPoints: 0.39, 0.575, 0.565, 1)
    /// 开始结束正弦曲线
    static let easeInOutSine: Base = .init(controlPoints: 0.445, 0.05, 0.55, 0.95)

    /// 开始方曲线
    static let easeInQuad: Base = .init(controlPoints: 0.55, 0.085, 0.68, 0.53)
    /// 结束方曲线
    static let easeOutQuad: Base = .init(controlPoints: 0.25, 0.46, 0.45, 0.94)
    /// 开始结束方曲线
    static let easeInOutQuad: Base = .init(controlPoints: 0.455, 0.03, 0.515, 0.955)

    /// 开始三分之一曲线
    static let easeInCubic: Base = .init(controlPoints: 0.55, 0.055, 0.675, 0.19)
    /// 结束三分之一曲线
    static let easeOutCubic: Base = .init(controlPoints: 0.215, 0.61, 0.355, 1)
    /// 开始结束三分之一曲线
    static let easeInOutCubic: Base = .init(controlPoints: 0.645, 0.045, 0.355, 1)

    /// 开始四分之一曲线
    static let easeInQuart: Base = .init(controlPoints: 0.895, 0.03, 0.685, 0.22)
    /// 结束四分之一曲线
    static let easeOutQuart: Base = .init(controlPoints: 0.165, 0.84, 0.44, 1)
    /// 开始结束四分之一曲线
    static let easeInOutQuart: Base = .init(controlPoints: 0.77, 0, 0.175, 1)

    /// 开始五分之一曲线
    static let easeInQuint: Base = .init(controlPoints: 0.755, 0.05, 0.855, 0.06)
    /// 结束五分之一曲线
    static let easeOutQuint: Base = .init(controlPoints: 0.23, 1, 0.32, 1)
    /// 开始结束五分之一曲线
    static let easeInOutQuint: Base = .init(controlPoints: 0.86, 0, 0.07, 1)

    /// 开始曝光曲线
    static let easeInExpo: Base = .init(controlPoints: 0.95, 0.05, 0.795, 0.035)
    /// 结束曝光曲线
    static let easeOutExpo: Base = .init(controlPoints: 0.19, 1, 0.22, 1)
    /// 开始结束曝光曲线
    static let easeInOutExpo: Base = .init(controlPoints: 1, 0, 0, 1)

    /// 开始圆形曲线
    static let easeInCirc: Base = .init(controlPoints: 0.6, 0.04, 0.98, 0.335)
    /// 结束圆形曲线
    static let easeOutCirc: Base = .init(controlPoints: 0.075, 0.82, 0.165, 1)
    /// 开始结束圆形曲线
    static let easeInOutCirc: Base = .init(controlPoints: 0.785, 0.135, 0.15, 0.86)

    /// 开始递减曲线
    static let easeInBack: Base = .init(controlPoints: 0.6, -0.28, 0.735, 0.045)
    /// 结束递减曲线
    static let easeOutBack: Base = .init(controlPoints: 0.175, 0.885, 0.32, 1.275)
    /// 开始结束递减曲线
    static let easeInOutBack: Base = .init(controlPoints: 0.68, -0.55, 0.265, 1.55)
}

// MARK: - 属性 & Api

public extension AxcSpace where Base == CAMediaTimingFunction {}

// MARK: - 决策判断

public extension AxcSpace where Base == CAMediaTimingFunction {}
