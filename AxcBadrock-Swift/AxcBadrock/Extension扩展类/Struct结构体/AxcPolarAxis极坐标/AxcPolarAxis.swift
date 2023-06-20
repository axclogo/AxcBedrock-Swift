//
//  AxcPolarAxis.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/19.
//

import UIKit

/// 极坐标结构体
public struct AxcPolarAxis {
    /// 获取一个角度为  0 ～ 180 的极轴坐标
    /// - Parameters:
    ///   - center: 中心
    ///   - distance: 距离
    ///   - angle: 角度  0 ～ 180
    ///   - direction: 起始方位，上下左右 默认顶部为起始方位
    /// - Returns: CGPoint
    public static func transform(center: CGPoint, distance: CGFloat, angle: CGFloat, direction: AxcDirection = .top) -> CGPoint{
        return CGPoint(center: center, distance: distance, angle: angle, direction: direction)
    }
    
    /// 获取一个角度为  0 ～ 2pi 的极轴坐标
    /// - Parameters:
    ///   - center: 中心
    ///   - distance: 距离
    ///   - radian: 弧度 0 ～ 2pi
    ///   - direction: 起始方位，上下左右 默认顶部为起始方位
    /// - Returns: CGPoint
    public static func transform(center: CGPoint, distance: CGFloat, radian: CGFloat, direction: AxcDirection = .top) -> CGPoint{
        return CGPoint(center: center, distance: distance, radian: radian, direction: direction)
    }
}
