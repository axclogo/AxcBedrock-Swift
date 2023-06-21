//
//  AxcAngleType.swift
//  Pods
//
//  Created by 赵新 on 2023/2/28.
//

import Foundation

/// 角度类型
public typealias AxcAngleType = AxcEnum.AngleType

// MARK: - [AxcEnum.AngleType]

public extension AxcEnum {
    /// 角度类型
    enum AngleType {
        /// 角度 0-360
        case angle(_ angle: CGFloat)

        /// 弧度 0-2pi
        case radian(_ radian: CGFloat)

        /// 方位 上下左右
        case direction(_ direction: AxcDirection)

        /// 零度，起始角
        case zero
    }
}

public extension AxcAngleType {
    /// 角度值
    var angleValue: CGFloat {
        let value = Float(radianValue).axc.radianToAngle
        return CGFloat(value)
    }

    /// 弧度值
    var radianValue: CGFloat {
        switch self {
        case let .angle(angle):
            let value = Float(angle).axc.angleToRadian
            return CGFloat(value)
        case let .radian(radian):
            return radian
        case let .direction(direction):
            switch direction {
            case .top: return (.pi / -2)
            case .left: return (.pi / -1)
            case .bottom: return (.pi / 2)
            case .right: return 0
            }
        case .zero:
            return 0
        }
    }
}
