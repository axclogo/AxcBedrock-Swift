//
//  AxcAnimateStyle.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/6.
//

import Foundation

/// 动画类型
public typealias AxcAnimateType = AxcEnum.AnimateType

// MARK: - [AxcBedrockLib.AnimateType]

public extension AxcEnum {
    /// 动画类型
    enum AnimateType<T> {
        /// 无动画
        case none
        /// 有动画
        case animated(_ value: T)

        /// 信息对象
        public struct Info {
            /// 是否使用动画
            public var isAnimated: Bool
        }

        /// 信息
        public var info: Info {
            switch self {
            case .none: return .init(isAnimated: false)
            case .animated: return .init(isAnimated: true)
            }
        }
    }
}
