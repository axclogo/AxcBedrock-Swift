//
//  AxcCGPointEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/12.
//

import Foundation
import CoreGraphics

// MARK: - CGPoint + AxcSpaceProtocol

extension CGPoint: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == CGPoint { }

// MARK: - 类方法

public extension AxcSpace where Base == CGPoint {
    /// 无前缀实例化
    static func Create(_ x: AxcUnifiedNumber,
                       _ y: AxcUnifiedNumber) -> CGPoint {
        var point = CGPoint.zero
        point.x = CGFloat.Axc.Create(x)
        point.y = CGFloat.Axc.Create(y)
        return point
    }

    /// 统一实例化
    static func Create(_ all: AxcUnifiedNumber) -> CGPoint {
        let all = CGFloat.Axc.Create(all)
        return .init(x: all, y: all)
    }

    /// 实例化一个角度为  0 ～ 180 的极轴坐标
    /// - Parameters:
    ///   - center: 中心
    ///   - distance: 距离
    ///   - angle: 角度  0 ～ 180
    ///   - startAngle: 起始方位，上下左右 默认顶部为起始方位
    /// - Returns: CGPoint
    static func CreatePolarAxis(center: CGPoint,
                                distance: AxcUnifiedNumber,
                                angle: AxcUnifiedNumber,
                                startAngle: AxcAngleType = .zero) -> CGPoint {
        let angle = CGFloat.Axc.Create(angle)
        return CreatePolarAxis(center: center,
                               distance: distance,
                               radian: angle.axc.angleToRadian,
                               startAngle: startAngle)
    }

    /// 实例化一个角度为  0 ～ 2pi 的极轴坐标
    /// - Parameters:
    ///   - center: 中心
    ///   - distance: 距离
    ///   - radian: 弧度 0 ～ 2pi
    ///   - startAngle: 起始方位，上下左右 默认顶部为起始方位
    /// - Returns: CGPoint
    static func CreatePolarAxis(center: CGPoint,
                                distance: AxcUnifiedNumber,
                                radian: AxcUnifiedNumber,
                                startAngle: AxcAngleType = .zero) -> CGPoint {
        let radianMode: CGFloat = startAngle.radianValue
        let _distance = AssertTransformCGFloat(distance)
        let _radian = AssertTransformCGFloat(radian)
        let startRadian = Float(_radian + radianMode)
        let cosf = cosf(startRadian).axc.cgFloat
        let sinf = sinf(startRadian).axc.cgFloat
        let x = center.x + CGFloat(_distance * cosf)
        let y = center.y + CGFloat(_distance * sinf)
        return CGPoint(x: x, y: y)
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base == CGPoint {
    /// 两点距离计算
    /// - Parameter point2: point2
    /// - Returns: 距离值
    func distance(to point2: CGPoint) -> CGFloat {
        let pow_x = pow(point2.x - base.x, 2)
        let pow_y = pow(point2.y - base.y, 2)
        let sqrt_ = pow_x + pow_y
        return sqrt(sqrt_)
    }

    /// 获取X、Y中最大的一个
    var bigger: CGFloat {
        return Swift.max(base.x, base.y)
    }

    /// 获取X、Y中最小的一个
    var smaller: CGFloat {
        return Swift.min(base.x, base.y)
    }

    /// 向上取整
    var ceilUp: CGPoint {
        return CGPoint(x: Darwin.ceil(base.x),
                       y: Darwin.ceil(base.y))
    }

    /// 向下取整
    var floorDown: CGPoint {
        return CGPoint(x: Darwin.floor(base.x),
                       y: Darwin.floor(base.y))
    }

    /// 设置x值
    /// - Parameter x: x
    /// - Returns: 新的CGPoint
    func set(x: AxcUnifiedNumber) -> CGPoint {
        var newPoint = base
        newPoint.x = assertTransformCGFloat(x)
        return newPoint
    }

    /// 设置y值
    /// - Parameter y: y
    /// - Returns: 新的CGPoint
    func set(y: AxcUnifiedNumber) -> CGPoint {
        var newPoint = base
        newPoint.y = assertTransformCGFloat(y)
        return newPoint
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base == CGPoint { }
