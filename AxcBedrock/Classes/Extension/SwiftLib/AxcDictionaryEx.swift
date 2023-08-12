//
//  AxcDictionaryEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/21.
//

import Foundation

// MARK: - [AxcDictionarySpace]

public struct AxcDictionarySpace<Key, Value> where Key: Hashable {
    init(_ base: [Key: Value]) {
        self.base = base
    }

    var base: [Key: Value]
}

public extension Dictionary {
    /// 命名空间
    var axc: AxcDictionarySpace<Key, Value> {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcDictionarySpace<Key, Value>.Type {
        return AxcDictionarySpace<Key, Value>.self
    }
}

// MARK: - 数据转换

public extension AxcDictionarySpace {
    /// 转换成NSDictionary
    var nsDictionary: NSDictionary {
        return base as NSDictionary
    }

    /// 转换成CFDictionary
    var cfDictionary: CFDictionary {
        return base as CFDictionary
    }
}

public extension AxcDictionarySpace where Key == NSAttributedString.Key {
    /// 转换为StringKey的字典
    var asStringKey: [String: Any] {
        var newDic: [String: Any] = [:]
        base.forEach { (key, value) in
            newDic[key.rawValue] = value
        }
        return newDic
    }
}

public extension AxcDictionarySpace where Key == String {
    /// 转换为StringKey的字典
    var asNSAttributedStringKey: [NSAttributedString.Key: Any] {
        var newDic: [NSAttributedString.Key: Any] = [:]
        base.forEach { (key, value) in
            let newKey: NSAttributedString.Key = .init(key)
            newDic[newKey] = value
        }
        return newDic
    }
}


// MARK: - 类方法

public extension AxcDictionarySpace {
    /// 读取文件，并解析成Json格式
    ///
    /// - Parameters:
    ///   - path: Json文件路径
    ///   - readingOptions: Json文件读取选项
    /// - Throws: 文件读取、操作错误
    /// - Returns: 可选的Json数据
    static func Create(fromJsonFilePath path: String,
                       readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> [String: Any]?
    {
        let data = try Data(contentsOf: path.axc.fileUrl, options: .mappedIfSafe)
        let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)
        return json as? [String: Any]
    }
}

// MARK: - 属性 & Api

public extension AxcDictionarySpace {
    /// 随机返回一个值
    var random: Value? { return Array(base.values).axc.random }

    /// 随机移除一个键值对
    func removeRandomKey() -> [Key: Value] {
        var newDic = base
        guard let randomKey = newDic.keys.randomElement() else { return newDic }
        newDic.removeValue(forKey: randomKey)
        return newDic
    }

    /// 过滤筛选一个字典
    func filter(_ compare: (Key, Value) -> Bool) -> [Key: Value] {
        var result: [Key: Value] = [:]
        for (key, value) in base {
            if compare(key, value) {
                result[key] = value
            }
        }
        return result
    }

    /// 添加一个字典
    /// - Parameter dict: 添加的字典
    func append(_ dict: [Key: Value]) -> [Key: Value] {
        var result = base
        dict.forEach { result[$0] = $1 }
        return result
    }
}

// MARK: - String类型的Key扩展

public extension AxcDictionarySpace where Key: StringProtocol {
    /// 将所有的key键转换为小写
    func lowercaseAllKeys() -> [Key: Value] {
        var newDic = base
        for key in newDic.keys {
            if let lowercaseKey = String(describing: key).lowercased() as? Key {
                newDic[lowercaseKey] = newDic.removeValue(forKey: key)
            }
        }
        return newDic
    }
}

// MARK: - 决策判断

public extension AxcDictionarySpace {
    /// 判断这个Key是否存在
    func hasKey(_ key: Key) -> Bool { return base.index(forKey: key) != nil }
}
