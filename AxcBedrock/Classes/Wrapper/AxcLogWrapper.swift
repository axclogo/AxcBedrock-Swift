//
//  AxcLogWrapper.swift
//  AxcBedrock
//
//  Created by 赵新 on 2022/2/24.
//

// MARK: - [AxcBedrockLib.LogWrapper]

/// 日志属性包装器
/// 仅在 DEBUG 模式下打印 set/get 日志
@propertyWrapper
public struct AxcLogWrapper<T> {
    public var wrappedValue: T {
        set {
            value = newValue
            #if DEBUG
            print("调用set：\(newValue)")
            #endif
        }
        get {
            #if DEBUG
            print("调用get：\(value)")
            #endif
            return value
        }
    }

    private var value: T

    public init(wrappedValue: T) {
        self.value = wrappedValue
    }
}
