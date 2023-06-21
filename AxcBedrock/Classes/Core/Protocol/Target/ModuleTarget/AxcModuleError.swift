//
//  AxcModuleError.swift
//  Pods
//
//  Created by 赵新 on 2023/2/24.
//

import Foundation

/// AxcBedrock组件错误对象
public typealias AxcBedrockError = AxcBedrockLib.ErrorObj

// MARK: - [AxcBedrockLib.ErrorObj]

public extension AxcBedrockLib {
    /// 组件错误对象
    struct ErrorObj: Hashable, Equatable, RawRepresentable, Error {
        public typealias RawValue = String
        /// 错误说明
        public var rawValue: String
        /// 实例化
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}
