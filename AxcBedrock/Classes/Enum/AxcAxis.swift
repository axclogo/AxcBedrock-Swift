//
//  AxcAxis.swift
//  AxcBedrock
//
//  Created by 赵新 on 2022/11/24.
//

import Foundation

/// 2D轴向
public typealias AxcAxis2D = AxcEnum.Axis2D

public extension AxcEnum {
    /// 轴向
    enum Axis2D: CaseIterable {
        /// x水平
        case horizontal
        /// y垂直
        case vertical

        /// 反转
        public var reversal: Axis2D {
            switch self {
            case .horizontal: return .vertical
            case .vertical: return .horizontal
            }
        }
    }
}

/// 3D轴向
public typealias AxcAxis3D = AxcEnum.Axis3D

public extension AxcEnum {
    /// 轴向
    enum Axis3D: CaseIterable {
        /// x水平
        case horizontal
        /// y垂直
        case vertical
        /// z深度
        case depth
    }
}
