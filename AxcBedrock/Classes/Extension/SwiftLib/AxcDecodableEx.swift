//
//  AxcDecodableEx.swift
//  Pods
//
//  Created by 赵新 on 2023/5/12.
//

import Foundation

// MARK: - [AxcDecodableSpace]

public struct AxcDecodableSpace<Base> where Base: Decodable {
    init(_ base: Base) {
        self.base = base
    }

    var base: Base
}

public extension Decodable {
    /// 命名空间
    var axc: AxcDecodableSpace<Self> {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcDecodableSpace<Self>.Type {
        return AxcDecodableSpace.self
    }
}

// MARK: - 数据转换

public extension AxcDecodableSpace { }

// MARK: - 类方法

public extension AxcDecodableSpace {
    /// 创建一个对象，来自于Json对象
    /// - Parameters:
    ///   - object: json对象
    ///   - options: 解析选项
    /// - Returns: 对象
    static func Create(fromJsonObject object: [AnyHashable: Any],
                       options: JSONSerialization.WritingOptions = .prettyPrinted) -> Base? {
        guard let data = object.axc.jsonData(options: options) else { return nil }
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

public extension AxcDecodableSpace { }

// MARK: - 决策判断

public extension AxcDecodableSpace { }
