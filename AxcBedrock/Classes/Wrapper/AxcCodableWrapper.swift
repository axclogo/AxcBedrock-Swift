//
//  AxcCodableWrapper.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/3/17.
//

@propertyWrapper
public struct AxcCodableWrapper<T: Codable> {
    public var wrappedValue: T

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}
