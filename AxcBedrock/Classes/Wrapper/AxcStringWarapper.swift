//
//  AxcStringValidated.swift
//  Pods
//
//  Created by 赵新 on 2023/3/17.
//

@propertyWrapper
class AxcStringValidated {
    var wrappedValue: String {
        set { value = newValue }
        get { return value }
    }

    private var value: String

    public init(wrappedValue: String) {
        self.value = wrappedValue
    }
    
}
