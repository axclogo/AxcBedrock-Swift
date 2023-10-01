//
//  AxcCGRectEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/12.
//

import Foundation
import CoreGraphics

// MARK: - CGRect + AxcSpaceProtocol

extension CGRect: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == CGRect { }

// MARK: - 类方法

public extension AxcSpace where Base == CGRect {
    /// 无前缀实例化 CGFloat
    static func Create(_ x: AxcUnifiedNumber,
                       _ y: AxcUnifiedNumber,
                       _ width: AxcUnifiedNumber,
                       _ height: AxcUnifiedNumber) -> CGRect {
        let x = CGFloat.Axc.Create(x)
        let y = CGFloat.Axc.Create(y)
        let width = CGFloat.Axc.Create(width)
        let height = CGFloat.Axc.Create(height)
        return CGRect(x: x, y: y, width: width, height: height)
    }

    /// 统一实例化
    @available(*, deprecated, renamed: "Create(all:)")
    static func Create(_ all: AxcUnifiedNumber) -> CGRect {
        let all = CGFloat.Axc.Create(all)
        return CGRect(x: all, y: all, width: all, height: all)
    }

    /// 统一实例化
    static func Create(all: AxcUnifiedNumber) -> CGRect {
        let all = CGFloat.Axc.Create(all)
        return CGRect(x: all, y: all, width: all, height: all)
    }

    /// 通过Center和Size来实例化Rect
    /// - Parameters:
    ///   - center: center
    ///   - size: size
    static func Create(center: CGPoint, size: CGSize) -> CGRect {
        let x = center.x - size.width / 2.0
        let y = center.y - size.height / 2.0
        let origin = CGPoint(x: x, y: y)
        return CGRect(origin: origin, size: size)
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base == CGRect {
    /// 设置x
    /// - Parameter x: x
    /// - Returns: 设置后的frame
    func set(x: AxcUnifiedNumber) -> CGRect {
        let value = assertTransformCGFloat(x)
        return CGRect(x: value, y: base.origin.y, width: base.size.width, height: base.size.height)
    }

    /// 设置y
    /// - Parameter y: y
    /// - Returns: 设置后的frame
    func set(y: AxcUnifiedNumber) -> CGRect {
        let value = assertTransformCGFloat(y)
        return CGRect(x: base.origin.x, y: value, width: base.size.width, height: base.size.height)
    }

    /// 设置width
    /// - Parameter width: width
    /// - Returns: 设置后的frame
    func set(width: AxcUnifiedNumber) -> CGRect {
        let value = assertTransformCGFloat(width)
        return CGRect(x: base.origin.x, y: base.origin.y, width: value, height: base.size.height)
    }

    /// 设置height
    /// - Parameter height: height
    /// - Returns: 设置后的frame
    func set(height: AxcUnifiedNumber) -> CGRect {
        let value = assertTransformCGFloat(height)
        return CGRect(x: base.origin.x, y: base.origin.y, width: base.size.width, height: value)
    }

    /// 设置origin
    /// - Parameter origin: origin
    /// - Returns: 设置后的frame
    func set(origin: CGPoint) -> CGRect {
        return CGRect(origin: origin, size: base.size)
    }

    /// 设置size
    /// - Parameter size: size
    /// - Returns: 设置后的frame
    func set(size: CGSize) -> CGRect {
        return CGRect(origin: base.origin, size: size)
    }

    /// 中心
    var center: CGPoint {
        return CGPoint(x: base.midX, y: base.midY)
    }

    /// 整体缩放
    func scale(_ _scale: CGFloat) -> CGRect {
        return scale(wScale: _scale, hScale: _scale)
    }

    /// 纵横轴分别缩放
    func scale(wScale: CGFloat, hScale: CGFloat) -> CGRect {
        return CGRect(x: base.origin.x,
                      y: base.origin.y,
                      width: base.size.width * wScale,
                      height: base.size.height * hScale)
    }

    /// 等比填充
    /// - Parameter boundingSize: 框大小
    /// - Returns: 结果
    func aspectFit(_ boundingRect: CGRect) -> CGRect {
        let size = base.size.axc.aspectFit(boundingRect.size)
        var origin = boundingRect.origin
        origin.x += (boundingRect.size.width - size.width) / 2.0
        origin.y += (boundingRect.size.height - size.height) / 2.0
        return CGRect(origin: origin, size: size)
    }

    /// 拉伸填充
    /// - Parameter minimumRect: 最小框
    /// - Returns: 结果
    func aspectFill(_ minimumRect: CGRect) -> CGRect {
        let size = base.size.axc.aspectFill(minimumRect.size)
        return CGRect(
            x: (minimumRect.size.width - size.width) / 2.0,
            y: (minimumRect.size.height - size.height) / 2.0,
            width: size.width,
            height: size.height
        )
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base == CGRect { }
