//
//  AxcAVCaptureSessionEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/24.
//

// MARK: - [AxcBedrockLib.LogWrapper]

/// 日志属性包装器
@propertyWrapper
public struct AxcLogWrapper<T> {
    public var wrappedValue: T {
        set {
            value = newValue
            print("调用set：\(newValue)")
        }
        get {
            print("调用get：\(value)")
            return value
        }
    }

    private var value: T

    public init(wrappedValue: T) {
        self.value = wrappedValue
    }
}
