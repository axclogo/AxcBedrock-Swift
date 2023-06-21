//
//  AxcClockwise.swift
//  Pods
//
//  Created by 赵新 on 2023/2/28.
//

import Foundation

/// 顺逆时针类型
public typealias AxcClockwise = AxcEnum.Clockwise

// MARK: - [AxcEnum.Clockwise]

public extension AxcEnum {
    /// 顺逆时针类型
    enum Clockwise: CaseIterable {
        /// 顺时针
        case clockwise
        /// 逆时针
        case reverse
    }
}

public extension AxcClockwise {
    /// 是否是顺时针
    var isClockwise: Bool {
        return self == .clockwise
    }
}
