//
//  AxcCodableWarapper.swift
//  Pods
//
//  Created by 赵新 on 2023/3/17.
//

@propertyWrapper
class AxcCodableWarapper<T: Codable> {
    var wrappedValue: T {
        set { value = newValue }
        get { return value }
    }

    private var value: T

    public init(wrappedValue: T) {
        self.value = wrappedValue
    }
    
}
