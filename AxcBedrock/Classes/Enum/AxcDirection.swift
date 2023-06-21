//
//  AxcDirection.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/12.
//

import Foundation

/// 方向指向
public typealias AxcDirection = AxcEnum.Direction

// MARK: - [AxcEnum.Direction]

public extension AxcEnum {
    /// 方向指向
    enum Direction: CaseIterable {
        case top, left, bottom, right

        // MARK: 矢量判断

        /// 是否是垂直
        var isVertical: Bool {
            return self == .top || self == .bottom
        }

        /// 是否是水平
        var isHorizontal: Bool {
            return self == .left || self == .right
        }
    }
}

/// 方向指向（垂直）
public typealias AxcDirectionVertical = AxcEnum.DirectionVertical

// MARK: - [AxcEnum.DirectionVertical]

public extension AxcEnum {
    /// 方向指向
    enum DirectionVertical: CaseIterable {
        case top, bottom
    }
}

/// 方向指向（水平）
public typealias AxcDirectionHorizontal = AxcEnum.DirectionHorizontal

// MARK: - [AxcEnum.DirectionHorizontal]

public extension AxcEnum {
    /// 方向指向
    enum DirectionHorizontal: CaseIterable {
        case left, right
    }
}

/// 方向指向（深度）
public typealias AxcDirectionDepth = AxcEnum.DirectionDepth

// MARK: - [AxcEnum.DirectionDepth]

public extension AxcEnum {
    /// 方向指向
    enum DirectionDepth: CaseIterable {
        case inside, outside
    }
}
