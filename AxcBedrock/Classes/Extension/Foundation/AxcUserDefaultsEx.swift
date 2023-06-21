//
//  AxcUserDefaultsEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/16.
//

import Foundation

// MARK: - 数据转换

public extension AxcSpace where Base: UserDefaults { }

// MARK: - 类方法

public extension AxcSpace where Base: UserDefaults { }

// MARK: - 属性 & Api

/// 存储键值
/// static let someKey: AxcUserDefaultsKey = .init(rawValue: "SomeValue")
/// 通过以上方法进行扩展Key值
public typealias AxcUserDefaultsKey = AxcSpace<UserDefaults>.Key
public extension AxcUserDefaultsKey { }

// MARK: - [AxcSpace.Key]

public extension AxcSpace where Base: UserDefaults {
    /// 存储键值
    struct Key: Hashable, Equatable, RawRepresentable {
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// 创建一个存储键值
        /// - Parameters:
        ///   - rawValue: 表名键值字符串
        public init(_ rawValue: String) {
            self.init(rawValue: rawValue)
        }

        /// 值
        public var rawValue: String
    }
}

public extension AxcSpace where Base: UserDefaults {
    /// 获取一个值
    /// - Returns: 返回的值如果类型不匹配或没有，则会返回空
    func value<T>(forKey key: AxcUserDefaultsKey) -> T? {
        guard let value = base.value(forKey: key.rawValue) as? T else { return nil }
        return value
    }

    /// 存储一个值
    /// - Parameters:
    ///   - value: 值
    ///   - key: 键值
    func set(value: Any, for key: AxcUserDefaultsKey) {
        base.set(value, forKey: key.rawValue)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: UserDefaults { }
