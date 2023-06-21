//
//  AxcAnimationCurveEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/3/17.
//

#if canImport(UIKit)

import UIKit

// MARK: - 扩展UIView.AnimationCurve + AxcSpaceProtocol

extension UIView.AnimationCurve: AxcSpaceProtocol {}

// MARK: - 数据转换

public extension AxcSpace where Base == UIView.AnimationCurve {
    /// 转换成UIView.AnimationOptions
    var uiViewAnimationOptions: UIView.AnimationOptions {
        switch base {
        case .easeInOut: return .curveEaseInOut
        case .easeIn: return .curveEaseIn
        case .easeOut: return .curveEaseOut
        case .linear: return .curveLinear
        @unknown default: return .curveLinear
        }
    }
}

// MARK: - 类方法

public extension AxcSpace where Base == UIView.AnimationCurve {}

// MARK: - 属性 & Api

public extension AxcSpace where Base == UIView.AnimationCurve {}

// MARK: - 决策判断

public extension AxcSpace where Base == UIView.AnimationCurve {}

#endif
