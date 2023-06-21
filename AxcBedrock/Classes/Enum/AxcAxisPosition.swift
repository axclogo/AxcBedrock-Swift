//
//  AxcPosition.swift
//  AxcBedrock
//
//  Created by 赵新 on 2022/11/24.
//

import Foundation

/// 水平轴向三等分点
public typealias AxcPositionHorizontal = AxcEnum.PositionHorizontal

public extension AxcEnum {
    /// 水平轴向三等分点
    enum PositionHorizontal: CaseIterable {
        /// 左
        case left
        /// 中
        case center
        /// 右
        case right
    }
}

/// 垂直轴向三等分点
public typealias AxcPositionVertical = AxcEnum.PositionVertical

public extension AxcEnum {
    /// 垂直轴向三等分点
    enum PositionVertical: CaseIterable {
        /// 上
        case top
        /// 中
        case center
        /// 下
        case bottom
    }
}

/// 纵深轴向三等分点
public typealias AxcPositionDepth = AxcEnum.PositionDepth

public extension AxcEnum {
    /// 纵深轴向三等分点
    enum PositionDepth: CaseIterable {
        /// 前
        case front
        /// 中
        case center
        /// 后
        case back
    }
}
