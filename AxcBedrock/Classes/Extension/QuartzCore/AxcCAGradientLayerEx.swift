//
//  AxcCAGradientLayerEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/28.
//

import QuartzCore

// MARK: - 数据转换

public extension AxcSpace where Base: CAGradientLayer { }

// MARK: - 类方法

public extension AxcSpace where Base: CAGradientLayer {
    /// 创建渐变色图层
    /// - Parameters:
    ///   - colors: 颜色组
    ///   - locations: 点位
    ///   - startPoint: 起始点
    ///   - endPoint: 终止点
    ///   - type: 类型
    /// - Returns: 渐变色图层
    static func Create(colors: [AxcUnifiedColor],
                       locations: [CGFloat]? = nil,
                       startPoint: CGPoint = CGPoint(x: 0.5, y: 0),
                       endPoint: CGPoint = CGPoint(x: 0.5, y: 1),
                       type: CAGradientLayerType = .axial) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map {
            AssertTransformCGColor($0)
        }
        gradientLayer.locations = locations?.map { NSNumber(value: Double($0)) }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.type = type
        return gradientLayer
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: CAGradientLayer { }

// MARK: - 决策判断

public extension AxcSpace where Base: CAGradientLayer { }
