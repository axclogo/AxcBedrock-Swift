//
//  AxcCGAffineTransformEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/17.
//

import CoreGraphics

// MARK: - CGAffineTransform + AxcSpaceProtocol

extension CGAffineTransform: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == CGAffineTransform { }

// MARK: - 类方法

public extension AxcSpace where Base == CGAffineTransform {
    /// 缩放
    static func CreateScale(_ all: AxcUnifiedNumber) -> CGAffineTransform {
        return CreateScale(x: all, y: all)
    }

    /// 缩放
    static func CreateScale(x: AxcUnifiedNumber,
                            y: AxcUnifiedNumber) -> CGAffineTransform {
        let _x: CGFloat = AssertTransformCGFloat(x)
        let _y: CGFloat = AssertTransformCGFloat(y)
        let newValue: CGAffineTransform = .init(scaleX: _x, y: _y)
        return newValue
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base == CGAffineTransform {
    /// 获取X轴缩放
    var scaleX: CGFloat {
        sqrt(base.a * base.a + base.c * base.c)
    }

    /// 获取Y轴缩放
    var scaleY: CGFloat {
        sqrt(base.b * base.b + base.d * base.d)
    }

    /// 获取旋转弧度
    /// 0 ~ pi
    var radian: CGFloat {
        return atan2(base.b, base.a)
    }

    /// 获取旋转角度
    /// 0 ~ 360
    var angle: CGFloat {
        return radian.axc.radianToAngle
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base == CGAffineTransform { }
