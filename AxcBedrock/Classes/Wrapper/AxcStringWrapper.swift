//
//  AxcStringWrapper.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/3/17.
//

@propertyWrapper
public struct AxcStringWrapper {
    public var wrappedValue: String

    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
