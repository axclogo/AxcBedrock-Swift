//
//  AxcCGFloatEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit

// MARK: - 类方法/属性
extension CGFloat {
    /// 最大值
    public static var axc_max: CGFloat { return CGFloat.greatestFiniteMagnitude }

    /// 最小正值
    public static var axc_min: CGFloat { return CGFloat.leastNonzeroMagnitude }

    /// 无限
    public static var axc_infinity: CGFloat { return CGFloat(Float.infinity) }
    
    /// 取随机值
    static func axc_random(_ value: UInt32) -> CGFloat {
        return CGFloat(arc4random() % value)
    }
}

// MARK: - 决策判断
public extension CGFloat {
    /// 是否为正
    var axc_isPositive: Bool { return self > 0 }

    /// 是否为负
    var axc_isNegative: Bool { return self < 0 }
}
