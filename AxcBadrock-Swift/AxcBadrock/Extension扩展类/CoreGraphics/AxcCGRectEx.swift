//
//  AxcCGRectEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/11.
//

import UIKit

// MARK: - 数据转换
public extension CGRect {
    
    // MARK: 扩展
    /// 转换成元组 (x,y,width,height)
    var axc_tuples: (CGFloat,CGFloat,CGFloat,CGFloat) {
        return (axc_x,axc_y,axc_width,axc_height)
    }
}
 
// MARK: - 类方法/属性
extension CGRect: AxcInitializeZero {
    // MARK: 协议
    /// 直接获取0，0
    public static var axc_zero: CGRect {
        return CGRect.zero
    }
    /// 直接获取screen.bounds
    public static var axc_screen: CGRect {
        return Axc_screen.bounds
    }
    
    // MARK: 扩展
    /// 无前缀实例化 CGFloat
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    public init(_ x: AxcUnifiedNumberTarget, _ y: AxcUnifiedNumberTarget,
                _ width: AxcUnifiedNumberTarget, _ height: AxcUnifiedNumberTarget){
        self = CGRect(x: x.axc_cgFloat, y: y.axc_cgFloat,
                      width: width.axc_cgFloat, height: height.axc_cgFloat)
    }
    
    /// 统一实例化
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    public init(_ all: AxcUnifiedNumberTarget){
        self = CGRect(x: all.axc_cgFloat, y: all.axc_cgFloat,
                      width: all.axc_cgFloat, height: all.axc_cgFloat)
    }
    
    /// 通过元组实例化
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    public init(_ tuples: (AxcUnifiedNumberTarget,AxcUnifiedNumberTarget,
                           AxcUnifiedNumberTarget,AxcUnifiedNumberTarget) ){
        self = CGRect(x: tuples.0.axc_cgFloat, y: tuples.1.axc_cgFloat,
                      width: tuples.2.axc_cgFloat, height: tuples.3.axc_cgFloat)
    }
    
    
    /// 计算一个center的Rect
    /// - Parameters:
    ///   - center: center
    ///   - size: size
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    public init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0)
        self.init(origin: origin, size: size)
    }
}
 
// MARK: - 属性 & Api
public extension CGRect {
    /// 获取区域面积
    var axc_area:   CGFloat { return axc_width * axc_height }
    /// 按比例缩放
    func axc_scale(_ scale: CGFloat) -> CGRect {
        return CGRect(x: origin.x * scale, y: origin.y * scale,
                      width: size.width * scale, height: size.height * scale)
    }
    /// 将这个Rect显示出来
    /// - Parameter view: 显示于哪个视图上
    /// - Returns: CAShapeLayer
    @discardableResult
    func axc_show(_ view: UIView? = nil) -> CAShapeLayer {
        let view = view ?? AxcAppWindow()
        let bezierPath = UIBezierPath(rect: self)
        let shapeLayer = CAShapeLayer(view?.frame, path: bezierPath)
        view?.layer.addSublayer(shapeLayer)
        return shapeLayer
    }
}
// MARK: - 读写扩展
public extension CGRect {
    /// 读写x
    var axc_x: CGFloat {
        set{ return origin.x = newValue }
        get{ return origin.x }
    }
    /// 读写y
    var axc_y: CGFloat {
        set{ return origin.y = newValue }
        get{ return origin.y }
    }
    /// 读写width
    var axc_width: CGFloat {
        set{ return size.width = newValue }
        get{ return size.width }
    }
    /// 读写height
    var axc_height: CGFloat {
        set{ return size.height = newValue }
        get{ return size.height }
    }
    /// 读写left
    var axc_left: CGFloat {
        set { axc_x = newValue }
        get { return self.axc_x }
    }
    /// 读写right
    var axc_right: CGFloat {
        set { axc_x = newValue - axc_width }
        get { return axc_x + axc_width }
    }
    /// 读写top
    var axc_top: CGFloat {
        set { axc_y = newValue }
        get { return axc_y }
    }
    /// 读写bottom
    var axc_bottom: CGFloat {
        set { axc_y = newValue - axc_height }
        get { return axc_y + axc_height }
    }
    /// 读写origin
    var axc_origin: CGPoint {
        set { origin = newValue }
        get { return origin }
    }
    /// 读写size
    var axc_size: CGSize {
        set { size = newValue }
        get { return size }
    }
    /// 读写centerX
    var axc_centerX: CGFloat {
        get { return axc_x + axc_size.width / 2 }
        set { axc_x = newValue - axc_size.width / 2 }
    }
    /// 读写centerY
    var axc_centerY: CGFloat {
        get { return axc_y + axc_size.height / 2 }
        set { axc_y = newValue - axc_size.height / 2 }
    }
}
 
// MARK: - 决策判断
extension CGRect: AxcDecisionIsZero {
    /// 是否等于0
    public var axc_isZero: Bool { return self == .zero }
}
 
// MARK: - 运算符
public extension CGRect {
    /// 两个CGRect相加
    /// - Parameters:
    ///   - leftValue: CGRect
    ///   - rightValue: CGRect
    /// - Returns: 相加后的CGRect
    static func + (leftValue: CGRect, rightValue: CGRect) -> CGRect {
        return CGRect(x: leftValue.axc_x + rightValue.axc_x,
                      y: leftValue.axc_y + rightValue.axc_y,
                      width: leftValue.axc_width + rightValue.axc_width,
                      height: leftValue.axc_height + rightValue.axc_height)
    }
    
    /// 使用元组相加
    /// - Parameters:
    ///   - leftValue: CGRect
    ///   - rightValue: tuple value.
    /// - Returns: 相加后的CGRect
    static func + (leftValue: CGRect, rightValue: (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)) -> CGRect {
        return CGRect(x: leftValue.axc_x + rightValue.x,
                      y: leftValue.axc_y + rightValue.y,
                      width: leftValue.axc_width + rightValue.width,
                      height: leftValue.axc_height + rightValue.height)
    }
    
    /// 两个CGRect相减
    /// - Parameters:
    ///   - leftValue: CGRect
    ///   - rightValue: CGRect
    /// - Returns: 相减后的CGRect
    static func - (leftValue: CGRect, rightValue: CGRect) -> CGRect {
        return CGRect(x: leftValue.axc_x - rightValue.axc_x,
                      y: leftValue.axc_y - rightValue.axc_y,
                      width: leftValue.axc_width - rightValue.axc_width,
                      height: leftValue.axc_height - rightValue.axc_height)
    }
    
    /// 使用元组相减
    /// - Parameters:
    ///   - leftValue: CGRect
    ///   - rightValue: tuple value.
    /// - Returns: 相加后的CGRect
    static func - (leftValue: CGRect, rightValue: (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)) -> CGRect {
        return CGRect(x: leftValue.axc_x - rightValue.x,
                      y: leftValue.axc_y - rightValue.y,
                      width: leftValue.axc_width - rightValue.width,
                      height: leftValue.axc_height - rightValue.height)
    }
    
    /// 两个左边都乘以多少
    /// - Parameters:
    ///   - leftValue: CGRect
    ///   - rightValue: 倍数、标量
    /// - Returns: 计算后的CGRect
    static func * (leftValue: CGRect, rightValue: CGFloat) -> CGRect {
        return CGRect(x: leftValue.axc_x * rightValue,
                      y: leftValue.axc_y * rightValue,
                      width: leftValue.axc_width * rightValue,
                      height: leftValue.axc_height * rightValue)
    }
    
    /// 两个右边都乘以多少
    /// - Parameters:
    ///   - leftValue: 倍数、标量
    ///   - rightValue: CGRect
    /// - Returns: 计算后的CGRect
    static func * (leftValue: CGFloat, rightValue: CGRect) -> CGRect {
        return CGRect(x: rightValue.axc_x * leftValue,
                      y: rightValue.axc_y * leftValue,
                      width: rightValue.axc_width * leftValue,
                      height: rightValue.axc_height * leftValue)
    }
}

 
