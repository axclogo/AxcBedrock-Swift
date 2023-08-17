//
//  AxcDecodableEx.swift
//  Pods
//
//  Created by 赵新 on 2023/5/12.
//

import Foundation

// MARK: - 数据转换

public extension AxcSpace where Base: Decodable { }

// MARK: - 类方法

public extension AxcSpace where Base: Decodable {
    /// 创建一个对象，来自于Json对象
    /// - Parameters:
    ///   - object: json对象
    ///   - options: 解析选项
    /// - Returns: 对象
    static func Create(fromJsonObject object: [AnyHashable: Any]) -> Base? {
        /*
         It is not possible to use JSONEncoder
         because the value of the 'object map' is 'any'. However, 'any' cannot use the 'Encodable' protocol.
         Therefore, the 'jsonSerializationData' function is used here to obtain the map data
         */
        // guard let data = try? JSONEncoder().encode(object)  else { return nil }
        guard let data = object.axc.jsonSerializationData else { return nil }
        return Create(fromJsonData: data)
    }

    /// 创建一个对象，来自于JsonData数据
    /// - Parameter data: data数据，必须要json
    /// - Returns: 对象
    static func Create(fromJsonData data: Data?) -> Base? {
        guard let data else { return nil }
        return try? JSONDecoder().decode(Base.self, from: data)
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: Decodable { }

// MARK: - 决策判断

public extension AxcSpace where Base: Decodable { }
