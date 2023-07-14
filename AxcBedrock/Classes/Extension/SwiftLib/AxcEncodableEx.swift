//
//  AxcEncodableEx.swift
//  Pods
//
//  Created by 赵新 on 2023/7/14.
//

import Foundation

// MARK: - [AxcEncodableSpace]

public struct AxcEncodableSpace<Base> where Base: Encodable {
    init(_ base: Base) {
        self.base = base
    }

    var base: Base
}

public extension Encodable {
    /// 命名空间
    var axc: AxcEncodableSpace<Self> {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcEncodableSpace<Self>.Type {
        return AxcEncodableSpace.self
    }
}

// MARK: - 数据转换

public extension AxcEncodableSpace { }

// MARK: - 类方法

public extension AxcEncodableSpace { }

// MARK: - 属性 & Api

public extension AxcEncodableSpace {
    /// 转jsondata
    var jsonData: Data? {
        return try? JSONEncoder().encode(base)
    }

    /// 转换成Json对象
    var jsonObj: Any? {
        return jsonObj()
    }

    /// 根据选择转换成数据对象
    func jsonObj(options: JSONSerialization.ReadingOptions = .mutableContainers) -> Any? {
        guard let jsonData else { return nil }
        return try? JSONSerialization.jsonObject(with: jsonData, options: options)
    }

    /// 转json字符串
    var jsonString: String? {
        guard let jsonData else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    
    /// 转化成对应的字典
    var dictionary: [String: Any] {
        return dictionary_optional ?? [:]
    }
    
    /// 转化成对应的字典-可选
    var dictionary_optional: [String: Any]? {
        guard let dict = jsonObj as? [String: Any] else { return nil }
        return dict
    }
    
    /// 转化成对应的字典
    var array: [Any] {
        return array_optional ?? []
    }
    
    /// 转化成对应的字典-可选
    var array_optional: [Any]? {
        guard let dict = jsonObj as? [Any] else { return nil }
        return dict
    }
}

// MARK: - 决策判断

public extension AxcEncodableSpace { }
