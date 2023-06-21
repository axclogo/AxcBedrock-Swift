//
//  AxcBinaryFloatingPointEx.swift
//  Pods
//
//  Created by 赵新 on 2023/2/24.
//

import Foundation

// MARK: - 数据转换

public extension AxcSpace where Base: BinaryFloatingPoint { }

// MARK: - 类方法

public extension AxcSpace where Base: BinaryFloatingPoint { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: BinaryFloatingPoint {
    /// 使用指定的小数位数和舍入规则返回舍入后的值。如果`numberOfDecimalPlaces`为负，将使用`0`。
    ///
    ///     let num = 3.1415927
    ///     num.axc.rounded(numPlaces: 3, rule: .up) -> 3.142
    ///     num.axc.rounded(numPlaces: 3, rule: .down) -> 3.141
    ///     num.axc.rounded(numPlaces: 2, rule: .awayFromZero) -> 3.15
    ///     num.axc.rounded(numPlaces: 4, rule: .towardZero) -> 3.1415
    ///     num.axc.rounded(numPlaces: -1, rule: .toNearestOrEven) -> 3
    ///
    /// - Parameters:
    ///   - numberOfDecimalPlaces: 预期的小数位数。
    ///   - rule: 使用的舍入规则。
    /// - Returns: 舍入后的值。
    func rounded(numPlaces: Int,
                 rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Base {
        let factor = Base(pow(10.0, Double(max(0, numPlaces))))
        return (base * factor).rounded(rule) / factor
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: BinaryFloatingPoint { }
