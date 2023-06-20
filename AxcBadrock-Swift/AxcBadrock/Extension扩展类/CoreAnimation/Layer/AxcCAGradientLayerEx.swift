//
//  AxcCAGradientLayerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/12.
//

import UIKit

// MARK: - 数据转换
public extension CAGradientLayer {
    
}

// MARK: - 类方法/属性
public extension CAGradientLayer {
    convenience init(colors: [UIColor],
                     locations: [AxcUnifiedNumberTarget]? = nil,
                     startDirection: AxcDirection,
                     endDirection: AxcDirection,
                     type: CAGradientLayerType = .axial) {
        self.init()
        self.colors = colors.map(\.cgColor)
        self.locations = locations?.map { NSNumber(value: $0.axc_float) }
        self.startPoint = CAGradientLayer.axc_point(with: startDirection)
        self.endPoint = CAGradientLayer.axc_point(with: endDirection)
        self.type = type
    }
    /// 将 AxcDirection 转换为startPoint或者endPoint的数值
    /// 默认左上角
    static func axc_point(with direction: AxcDirection) -> CGPoint {
        var point = CGPoint.zero
        if direction.contains(.top)     { point.y = 0 }
        if direction.contains(.left)    { point.x = 0 }
        if direction.contains(.right)   { point.x = 1 }
        if direction.contains(.bottom)  { point.y = 1 }
        if direction.contains(.center)  { point = CGPoint((0.5,0.5)) }
        return point
    }
}

// MARK: - 属性 & Api
public extension CAGradientLayer {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 【对象特性扩展区】
public extension CAGradientLayer {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 决策判断
public extension CAGradientLayer {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 操作符
public extension CAGradientLayer {
}

// MARK: - 运算符
public extension CAGradientLayer {
}
