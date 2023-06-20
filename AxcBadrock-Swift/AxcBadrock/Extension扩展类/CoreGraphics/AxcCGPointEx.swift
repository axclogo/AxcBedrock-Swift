//
//  AxcCGPointEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/11.
//

import UIKit

// MARK: - 数据转换
public extension CGPoint {
    // MARK: 扩展
    /// 转换成元组 (x,y)
    var axc_tuples: (CGFloat,CGFloat) {
        return (x,y)
    }
}

// MARK: - 类方法/属性
extension CGPoint: AxcInitializeZero {
    // MARK: 协议
    /// 直接获取0，0
    public static var axc_zero: CGPoint {
        return CGPoint.zero
    }
    /// 直接获取1，1
    public static var axc_one: CGPoint {
        return 1.axc_cgPoint
    }
    
    // MARK: 扩展
    /// 无前缀实例化
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    public init(_ x: AxcUnifiedNumberTarget, _ y: AxcUnifiedNumberTarget){
        var point = CGPoint.zero
        point.x = x.axc_cgFloat
        point.y = y.axc_cgFloat
        self = point
    }
    
    /// 统一实例化
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    public init(_ all: AxcUnifiedNumberTarget){
        self = CGPoint(x: all.axc_cgFloat, y: all.axc_cgFloat)
    }
    
    /// 通过元组实例化
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    public init(_ tuples:(CGFloat,CGFloat)){
        self = CGPoint(x: tuples.0, y: tuples.1)
    }
    
    /// 实例化一个角度为  0 ～ 180 的极轴坐标
    /// - Parameters:
    ///   - center: 中心
    ///   - distance: 距离
    ///   - angle: 角度  0 ～ 180
    ///   - direction: 起始方位，上下左右 默认顶部为起始方位
    /// - Returns: CGPoint
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    public init(center: CGPoint, distance: CGFloat, angle: CGFloat, direction: AxcDirection = .top) {
        self.init(center: center, distance: distance, radian: angle.axc_angleToRadian, direction: direction)
    }
    
    /// 实例化一个角度为  0 ～ 2pi 的极轴坐标
    /// - Parameters:
    ///   - center: 中心
    ///   - distance: 距离
    ///   - radian: 弧度 0 ～ 2pi
    ///   - direction: 起始方位，上下左右 默认顶部为起始方位
    /// - Returns: CGPoint
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    public init(center: CGPoint, distance: CGFloat, radian: CGFloat, direction: AxcDirection = .top) {
        var radianMode: CGFloat = 0
        switch direction {
        case .top: radianMode = ( .pi / -2 )
        case .left: radianMode = ( .pi / -1 )
        case .bottom: radianMode = ( .pi / 2 )
        default: radianMode = 0 }
        self = CGPoint(x: center.x + CGFloat(distance * cosf(Float(radian + radianMode)).axc_cgFloat),
                       y: center.y + CGFloat(distance * sinf(Float(radian + radianMode)).axc_cgFloat))
    }
    
    /// 两点距离计算
    /// - Parameters:
    ///   - point1: point1
    ///   - point2: point2
    /// - Returns: distance
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    public static func axc_distance(from point1: CGPoint, to point2: CGPoint) -> CGFloat {
        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
    }
}

// MARK: - 属性 & Api
public extension CGPoint {
    /// 与另一个点的距离
    /// - Parameter point: point
    /// - Returns: distance
    func axc_distance(from point: CGPoint) -> CGFloat {
        return CGPoint.axc_distance(from: self, to: point)
    }
    
    /// 将这个点显示出来
    /// - Parameter view: 显示于哪个视图上
    /// - Returns: CAShapeLayer
    @discardableResult
    func axc_show(_ view: UIView? = nil) -> CAShapeLayer {
        let view = view ?? AxcAppWindow()
        let bezierPath = UIBezierPath(reticle: self)
        let shapeLayer = CAShapeLayer(view?.frame, path: bezierPath)
        view?.layer.addSublayer(shapeLayer)
        return shapeLayer
    }
}

// MARK: - 决策判断
extension CGPoint: AxcDecisionIsZero {
    /// 是否都为0
    public var axc_isZero: Bool { return self == CGPoint.axc_zero }
}

// MARK: - 运算符
public extension CGPoint {
    /// 两个点相加
    /// - Parameters:
    ///   - leftValue: CGPoint
    ///   - rightValue: CGPoint
    /// - Returns: 相加后的点
    static func + (leftValue: CGPoint, rightValue: CGPoint) -> CGPoint {
        return CGPoint(x: leftValue.x + rightValue.x, y: leftValue.y + rightValue.y)
    }
    
    /// 使用元组相加
    /// - Parameters:
    ///   - lhs: CGSize to add to.
    ///   - tuple: tuple value.
    /// - Returns: 相加后的点
    static func + (leftValue: CGPoint, rightValue: (x: CGFloat, y: CGFloat)) -> CGPoint {
        return CGPoint(x: leftValue.x + rightValue.x, y: leftValue.y + rightValue.y)
    }
    
    /// 两个点相减
    /// - Parameters:
    ///   - leftValue: CGPoint
    ///   - rightValue: CGPoint
    /// - Returns: 相减后的点
    static func - (leftValue: CGPoint, rightValue: CGPoint) -> CGPoint {
        return CGPoint(x: leftValue.x - rightValue.x, y: leftValue.y - rightValue.y)
    }
    
    /// 使用元组相减
    /// - Parameters:
    ///   - lhs: CGSize to add to.
    ///   - tuple: tuple value.
    /// - Returns: 相加后的点
    static func - (leftValue: CGPoint, rightValue: (x: CGFloat, y: CGFloat)) -> CGPoint {
        return CGPoint(x: leftValue.x - rightValue.x,
                       y: leftValue.y - rightValue.y)
    }
    
    /// 点点两个左边都乘以多少
    /// - Parameters:
    ///   - leftValue: CGPoint
    ///   - rightValue: 倍数、标量
    /// - Returns: 计算后的点
    static func * (leftValue: CGPoint, rightValue: CGFloat) -> CGPoint {
        return CGPoint(x: leftValue.x * rightValue, y: leftValue.y * rightValue)
    }
    
    /// 点点两个右边都乘以多少
    /// - Parameters:
    ///   - leftValue: 倍数、标量
    ///   - rightValue: CGPoint
    /// - Returns: 计算后的点
    static func * (leftValue: CGFloat, rightValue: CGPoint) -> CGPoint {
        return CGPoint(x: rightValue.x * leftValue, y: rightValue.y * leftValue)
    }
}
