//
//  AxcSudoku.swift
//  AxcUIKit
//
//  Created by 赵新 on 2022/11/23.
//

import Foundation

/// 方向指向
public typealias AxcSudoku = AxcEnum.Sudoku

public extension AxcEnum {
    /// 九宫格指向
    enum Sudoku: CaseIterable {
        /// 顶部水平线
        case topLeft, topCenter, topRight
        /// 中部水平线
        case centerLeft, center, centerRight
        /// 底部水平线
        case bottomLeft, bottomCenter, bottomRight
    }
}

public extension AxcSudoku {
    /// 是否是顶部水平线
    var isHorizontalTopLine: Bool {
        switch self {
        case .topLeft,
             .topCenter,
             .topRight: return true
        default: return false
        }
    }

    /// 是否是中部水平线
    var isHorizontalTCenterLine: Bool {
        switch self {
        case .centerLeft,
             .center,
             .centerRight: return true
        default: return false
        }
    }

    /// 是否是底部水平线
    var isHorizontalBottomLine: Bool {
        switch self {
        case .bottomLeft,
             .bottomCenter,
             .bottomRight: return true
        default: return false
        }
    }

    /// 是否是左侧垂直线
    var isVerticalLeftLine: Bool {
        switch self {
        case .topLeft,
             .centerLeft,
             .bottomLeft: return true
        default: return false
        }
    }

    /// 是否是中间垂直线
    var isVerticalCenterLine: Bool {
        switch self {
        case .topCenter,
             .center,
             .bottomCenter: return true
        default: return false
        }
    }

    /// 是否是右侧垂直线
    var isVerticalRightLine: Bool {
        switch self {
        case .topRight,
             .centerRight,
             .bottomRight: return true
        default: return false
        }
    }
}
