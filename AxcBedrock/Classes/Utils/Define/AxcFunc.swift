//
//  AxcFunc.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/20.
//

import Foundation

public typealias AxcFunc = AxcBedrockLib.Func

// MARK: - [AxcBedrockLib.Func]

public extension AxcBedrockLib {
    /// Func集合
    struct Func { }
}

public extension AxcFunc {
    /// typeID判断
    /// - Parameters:
    ///   - value: 对象
    ///   - cfType: 类型
    /// - Returns: 值
    @discardableResult
    static func CFType<T, U: AxcCFTypeIDProtocol>(_ value: T,
                                                 as cfType: U.Type) -> U? {
        guard CFGetTypeID(value as CFTypeRef) == cfType.typeID else { return nil }
        return (value as? U)
    }
}
