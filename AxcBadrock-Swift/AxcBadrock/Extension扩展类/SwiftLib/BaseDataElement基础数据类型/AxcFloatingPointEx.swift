//
//  AxcFloatingPointEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/4.
//

import UIKit

// MARK: - 决策判断
public extension FloatingPoint {
    /// 是否为正数
    var axc_isPositive: Bool { return self > 0 }
    /// 是否为负数
    var axc_isNegative: Bool { return self < 0 }
}


