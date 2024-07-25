//
//  AxcKeyedDecodingContainer.swift
//  Pods
//
//  Created by 赵新 on 25/7/2024.
//

import Foundation

// MARK: - [AxcKeyedDecodingContainerSpace]

public struct AxcKeyedDecodingContainerSpace<Key: CodingKey>: AxcAssertUnifiedTransformTarget {
    init(_ base: KeyedDecodingContainer<Key>) {
        self.base = base
    }

    var base: KeyedDecodingContainer<Key>
}

public extension KeyedDecodingContainer {
    /// 命名空间
    var axc: AxcKeyedDecodingContainerSpace<Key> {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcKeyedDecodingContainerSpace<Key>.Type {
        return AxcKeyedDecodingContainerSpace<Key>.self
    }
}

// MARK: - 数据转换

public extension AxcKeyedDecodingContainerSpace { }

// MARK: - 属性 & Api

public extension AxcKeyedDecodingContainerSpace {
    /// 解码String
    /// - Parameter codingKey: key
    /// - Returns: 类型可选
    func decodeIfPresent(codingKey: Key) -> String? {
        if let value = try? base.decodeIfPresent(String.self, forKey: codingKey) { return value }
        else if let value = try? base.decodeIfPresent(Int.self, forKey: codingKey) { return "\(value)" }
        else if let value = try? base.decodeIfPresent(Float.self, forKey: codingKey) { return "\(value)" }
        else if let value = try? base.decodeIfPresent(Bool.self, forKey: codingKey) { return value ? "true" : "false" }
        else if let value = try? base.decodeIfPresent(Double.self, forKey: codingKey) { return "\(value)" }
        else if let value = try? base.decodeIfPresent(Int8.self, forKey: codingKey) { return "\(value)" }
        else if let value = try? base.decodeIfPresent(Int16.self, forKey: codingKey) { return "\(value)" }
        else if let value = try? base.decodeIfPresent(Int32.self, forKey: codingKey) { return "\(value)" }
        else if let value = try? base.decodeIfPresent(Int64.self, forKey: codingKey) { return "\(value)" }
        else if let value = try? base.decodeIfPresent(UInt.self, forKey: codingKey) { return "\(value)" }
        else if let value = try? base.decodeIfPresent(UInt8.self, forKey: codingKey) { return "\(value)" }
        else if let value = try? base.decodeIfPresent(UInt16.self, forKey: codingKey) { return "\(value)" }
        else if let value = try? base.decodeIfPresent(UInt32.self, forKey: codingKey) { return "\(value)" }
        else if let value = try? base.decodeIfPresent(UInt64.self, forKey: codingKey) { return "\(value)" }
        else { return nil }
    }

    /// 解码Int
    /// - Parameter codingKey: key
    /// - Returns: 类型可选
    func decodeIfPresent(codingKey: Key) -> Int? {
        if let value = try? base.decodeIfPresent(String.self, forKey: codingKey) { return Int(value) }
        else if let value = try? base.decodeIfPresent(Int.self, forKey: codingKey) { return value }
        else if let value = try? base.decodeIfPresent(Float.self, forKey: codingKey) { return Int(value) }
        else if let value = try? base.decodeIfPresent(Bool.self, forKey: codingKey) { return value ? 0 : 1 }
        else if let value = try? base.decodeIfPresent(Double.self, forKey: codingKey) { return Int(value) }
        else if let value = try? base.decodeIfPresent(Int8.self, forKey: codingKey) { return Int(value) }
        else if let value = try? base.decodeIfPresent(Int16.self, forKey: codingKey) { return Int(value) }
        else if let value = try? base.decodeIfPresent(Int32.self, forKey: codingKey) { return Int(value) }
        else if let value = try? base.decodeIfPresent(Int64.self, forKey: codingKey) { return Int(value) }
        else if let value = try? base.decodeIfPresent(UInt.self, forKey: codingKey) { return Int(value) }
        else if let value = try? base.decodeIfPresent(UInt8.self, forKey: codingKey) { return Int(value) }
        else if let value = try? base.decodeIfPresent(UInt16.self, forKey: codingKey) { return Int(value) }
        else if let value = try? base.decodeIfPresent(UInt32.self, forKey: codingKey) { return Int(value) }
        else if let value = try? base.decodeIfPresent(UInt64.self, forKey: codingKey) { return Int(value) }
        else { return nil }
    }

    /// 解码Float
    /// - Parameter codingKey: key
    /// - Returns: 类型可选
    func decodeIfPresent(codingKey: Key) -> Float? {
        if let value = try? base.decodeIfPresent(String.self, forKey: codingKey) { return Float(value) }
        else if let value = try? base.decodeIfPresent(Int.self, forKey: codingKey) { return Float(value) }
        else if let value = try? base.decodeIfPresent(Float.self, forKey: codingKey) { return Float(value) }
        else if let value = try? base.decodeIfPresent(Bool.self, forKey: codingKey) { return value ? 0 : 1 }
        else if let value = try? base.decodeIfPresent(Double.self, forKey: codingKey) { return Float(value) }
        else if let value = try? base.decodeIfPresent(Int8.self, forKey: codingKey) { return Float(value) }
        else if let value = try? base.decodeIfPresent(Int16.self, forKey: codingKey) { return Float(value) }
        else if let value = try? base.decodeIfPresent(Int32.self, forKey: codingKey) { return Float(value) }
        else if let value = try? base.decodeIfPresent(Int64.self, forKey: codingKey) { return Float(value) }
        else if let value = try? base.decodeIfPresent(UInt.self, forKey: codingKey) { return Float(value) }
        else if let value = try? base.decodeIfPresent(UInt8.self, forKey: codingKey) { return Float(value) }
        else if let value = try? base.decodeIfPresent(UInt16.self, forKey: codingKey) { return Float(value) }
        else if let value = try? base.decodeIfPresent(UInt32.self, forKey: codingKey) { return Float(value) }
        else if let value = try? base.decodeIfPresent(UInt64.self, forKey: codingKey) { return Float(value) }
        else { return nil }
    }

    /// 解码Bool
    /// - Parameter codingKey: key
    /// - Returns: 类型可选
    func decodeIfPresent(codingKey: Key) -> Bool? {
        if let value = try? base.decodeIfPresent(String.self, forKey: codingKey) { return value.isEmpty }
        else if let value = try? base.decodeIfPresent(Int.self, forKey: codingKey) { return value != 0 }
        else if let value = try? base.decodeIfPresent(Float.self, forKey: codingKey) { return value != 0 }
        else if let value = try? base.decodeIfPresent(Bool.self, forKey: codingKey) { return value }
        else if let value = try? base.decodeIfPresent(Double.self, forKey: codingKey) { return value != 0 }
        else if let value = try? base.decodeIfPresent(Int8.self, forKey: codingKey) { return value != 0 }
        else if let value = try? base.decodeIfPresent(Int16.self, forKey: codingKey) { return value != 0 }
        else if let value = try? base.decodeIfPresent(Int32.self, forKey: codingKey) { return value != 0 }
        else if let value = try? base.decodeIfPresent(Int64.self, forKey: codingKey) { return value != 0 }
        else if let value = try? base.decodeIfPresent(UInt.self, forKey: codingKey) { return value != 0 }
        else if let value = try? base.decodeIfPresent(UInt8.self, forKey: codingKey) { return value != 0 }
        else if let value = try? base.decodeIfPresent(UInt16.self, forKey: codingKey) { return value != 0 }
        else if let value = try? base.decodeIfPresent(UInt32.self, forKey: codingKey) { return value != 0 }
        else if let value = try? base.decodeIfPresent(UInt64.self, forKey: codingKey) { return value != 0 }
        else { return nil }
    }

    /// 解码Double
    /// - Parameter codingKey: key
    /// - Returns: 类型可选
    func decodeIfPresent(codingKey: Key) -> Double? {
        if let value = try? base.decodeIfPresent(String.self, forKey: codingKey) { return Double(value) }
        else if let value = try? base.decodeIfPresent(Int.self, forKey: codingKey) { return Double(value) }
        else if let value = try? base.decodeIfPresent(Float.self, forKey: codingKey) { return Double(value) }
        else if let value = try? base.decodeIfPresent(Bool.self, forKey: codingKey) { return value ? 0 : 1 }
        else if let value = try? base.decodeIfPresent(Double.self, forKey: codingKey) { return Double(value) }
        else if let value = try? base.decodeIfPresent(Int8.self, forKey: codingKey) { return Double(value) }
        else if let value = try? base.decodeIfPresent(Int16.self, forKey: codingKey) { return Double(value) }
        else if let value = try? base.decodeIfPresent(Int32.self, forKey: codingKey) { return Double(value) }
        else if let value = try? base.decodeIfPresent(Int64.self, forKey: codingKey) { return Double(value) }
        else if let value = try? base.decodeIfPresent(UInt.self, forKey: codingKey) { return Double(value) }
        else if let value = try? base.decodeIfPresent(UInt8.self, forKey: codingKey) { return Double(value) }
        else if let value = try? base.decodeIfPresent(UInt16.self, forKey: codingKey) { return Double(value) }
        else if let value = try? base.decodeIfPresent(UInt32.self, forKey: codingKey) { return Double(value) }
        else if let value = try? base.decodeIfPresent(UInt64.self, forKey: codingKey) { return Double(value) }
        else { return nil }
    }

    /// 解码Int8
    /// - Parameter codingKey: key
    /// - Returns: 类型可选
    func decodeIfPresent(codingKey: Key) -> Int8? {
        if let value = try? base.decodeIfPresent(String.self, forKey: codingKey) { return Int8(value) }
        else if let value = try? base.decodeIfPresent(Int.self, forKey: codingKey) { return Int8(value) }
        else if let value = try? base.decodeIfPresent(Float.self, forKey: codingKey) { return Int8(value) }
        else if let value = try? base.decodeIfPresent(Bool.self, forKey: codingKey) { return value ? 0 : 1 }
        else if let value = try? base.decodeIfPresent(Double.self, forKey: codingKey) { return Int8(value) }
        else if let value = try? base.decodeIfPresent(Int8.self, forKey: codingKey) { return Int8(value) }
        else if let value = try? base.decodeIfPresent(Int16.self, forKey: codingKey) { return Int8(value) }
        else if let value = try? base.decodeIfPresent(Int32.self, forKey: codingKey) { return Int8(value) }
        else if let value = try? base.decodeIfPresent(Int64.self, forKey: codingKey) { return Int8(value) }
        else if let value = try? base.decodeIfPresent(UInt.self, forKey: codingKey) { return Int8(value) }
        else if let value = try? base.decodeIfPresent(UInt8.self, forKey: codingKey) { return Int8(value) }
        else if let value = try? base.decodeIfPresent(UInt16.self, forKey: codingKey) { return Int8(value) }
        else if let value = try? base.decodeIfPresent(UInt32.self, forKey: codingKey) { return Int8(value) }
        else if let value = try? base.decodeIfPresent(UInt64.self, forKey: codingKey) { return Int8(value) }
        else { return nil }
    }

    /// 解码Int16
    /// - Parameter codingKey: key
    /// - Returns: 类型可选
    func decodeIfPresent(codingKey: Key) -> Int16? {
        if let value = try? base.decodeIfPresent(String.self, forKey: codingKey) { return Int16(value) }
        else if let value = try? base.decodeIfPresent(Int.self, forKey: codingKey) { return Int16(value) }
        else if let value = try? base.decodeIfPresent(Float.self, forKey: codingKey) { return Int16(value) }
        else if let value = try? base.decodeIfPresent(Bool.self, forKey: codingKey) { return value ? 0 : 1 }
        else if let value = try? base.decodeIfPresent(Double.self, forKey: codingKey) { return Int16(value) }
        else if let value = try? base.decodeIfPresent(Int8.self, forKey: codingKey) { return Int16(value) }
        else if let value = try? base.decodeIfPresent(Int16.self, forKey: codingKey) { return Int16(value) }
        else if let value = try? base.decodeIfPresent(Int32.self, forKey: codingKey) { return Int16(value) }
        else if let value = try? base.decodeIfPresent(Int64.self, forKey: codingKey) { return Int16(value) }
        else if let value = try? base.decodeIfPresent(UInt.self, forKey: codingKey) { return Int16(value) }
        else if let value = try? base.decodeIfPresent(UInt8.self, forKey: codingKey) { return Int16(value) }
        else if let value = try? base.decodeIfPresent(UInt16.self, forKey: codingKey) { return Int16(value) }
        else if let value = try? base.decodeIfPresent(UInt32.self, forKey: codingKey) { return Int16(value) }
        else if let value = try? base.decodeIfPresent(UInt64.self, forKey: codingKey) { return Int16(value) }
        else { return nil }
    }

    /// 解码Int32
    /// - Parameter codingKey: key
    /// - Returns: 类型可选
    func decodeIfPresent(codingKey: Key) -> Int32? {
        if let value = try? base.decodeIfPresent(String.self, forKey: codingKey) { return Int32(value) }
        else if let value = try? base.decodeIfPresent(Int.self, forKey: codingKey) { return Int32(value) }
        else if let value = try? base.decodeIfPresent(Float.self, forKey: codingKey) { return Int32(value) }
        else if let value = try? base.decodeIfPresent(Bool.self, forKey: codingKey) { return value ? 0 : 1 }
        else if let value = try? base.decodeIfPresent(Double.self, forKey: codingKey) { return Int32(value) }
        else if let value = try? base.decodeIfPresent(Int8.self, forKey: codingKey) { return Int32(value) }
        else if let value = try? base.decodeIfPresent(Int16.self, forKey: codingKey) { return Int32(value) }
        else if let value = try? base.decodeIfPresent(Int32.self, forKey: codingKey) { return Int32(value) }
        else if let value = try? base.decodeIfPresent(Int64.self, forKey: codingKey) { return Int32(value) }
        else if let value = try? base.decodeIfPresent(UInt.self, forKey: codingKey) { return Int32(value) }
        else if let value = try? base.decodeIfPresent(UInt8.self, forKey: codingKey) { return Int32(value) }
        else if let value = try? base.decodeIfPresent(UInt16.self, forKey: codingKey) { return Int32(value) }
        else if let value = try? base.decodeIfPresent(UInt32.self, forKey: codingKey) { return Int32(value) }
        else if let value = try? base.decodeIfPresent(UInt64.self, forKey: codingKey) { return Int32(value) }
        else { return nil }
    }

    /// 解码Int64
    /// - Parameter codingKey: key
    /// - Returns: 类型可选
    func decodeIfPresent(codingKey: Key) -> Int64? {
        if let value = try? base.decodeIfPresent(String.self, forKey: codingKey) { return Int64(value) }
        else if let value = try? base.decodeIfPresent(Int.self, forKey: codingKey) { return Int64(value) }
        else if let value = try? base.decodeIfPresent(Float.self, forKey: codingKey) { return Int64(value) }
        else if let value = try? base.decodeIfPresent(Bool.self, forKey: codingKey) { return value ? 0 : 1 }
        else if let value = try? base.decodeIfPresent(Double.self, forKey: codingKey) { return Int64(value) }
        else if let value = try? base.decodeIfPresent(Int8.self, forKey: codingKey) { return Int64(value) }
        else if let value = try? base.decodeIfPresent(Int16.self, forKey: codingKey) { return Int64(value) }
        else if let value = try? base.decodeIfPresent(Int32.self, forKey: codingKey) { return Int64(value) }
        else if let value = try? base.decodeIfPresent(Int64.self, forKey: codingKey) { return Int64(value) }
        else if let value = try? base.decodeIfPresent(UInt.self, forKey: codingKey) { return Int64(value) }
        else if let value = try? base.decodeIfPresent(UInt8.self, forKey: codingKey) { return Int64(value) }
        else if let value = try? base.decodeIfPresent(UInt16.self, forKey: codingKey) { return Int64(value) }
        else if let value = try? base.decodeIfPresent(UInt32.self, forKey: codingKey) { return Int64(value) }
        else if let value = try? base.decodeIfPresent(UInt64.self, forKey: codingKey) { return Int64(value) }
        else { return nil }
    }

    /// 解码UInt
    /// - Parameter codingKey: key
    /// - Returns: 类型可选
    func decodeIfPresent(codingKey: Key) -> UInt? {
        if let value = try? base.decodeIfPresent(String.self, forKey: codingKey) { return UInt(value) }
        else if let value = try? base.decodeIfPresent(Int.self, forKey: codingKey) { return UInt(value) }
        else if let value = try? base.decodeIfPresent(Float.self, forKey: codingKey) { return UInt(value) }
        else if let value = try? base.decodeIfPresent(Bool.self, forKey: codingKey) { return value ? 0 : 1 }
        else if let value = try? base.decodeIfPresent(Double.self, forKey: codingKey) { return UInt(value) }
        else if let value = try? base.decodeIfPresent(Int8.self, forKey: codingKey) { return UInt(value) }
        else if let value = try? base.decodeIfPresent(Int16.self, forKey: codingKey) { return UInt(value) }
        else if let value = try? base.decodeIfPresent(Int32.self, forKey: codingKey) { return UInt(value) }
        else if let value = try? base.decodeIfPresent(Int64.self, forKey: codingKey) { return UInt(value) }
        else if let value = try? base.decodeIfPresent(UInt.self, forKey: codingKey) { return UInt(value) }
        else if let value = try? base.decodeIfPresent(UInt8.self, forKey: codingKey) { return UInt(value) }
        else if let value = try? base.decodeIfPresent(UInt16.self, forKey: codingKey) { return UInt(value) }
        else if let value = try? base.decodeIfPresent(UInt32.self, forKey: codingKey) { return UInt(value) }
        else if let value = try? base.decodeIfPresent(UInt64.self, forKey: codingKey) { return UInt(value) }
        else { return nil }
    }

    /// 解码UInt8
    /// - Parameter codingKey: key
    /// - Returns: 类型可选
    func decodeIfPresent(codingKey: Key) -> UInt8? {
        if let value = try? base.decodeIfPresent(String.self, forKey: codingKey) { return UInt8(value) }
        else if let value = try? base.decodeIfPresent(Int.self, forKey: codingKey) { return UInt8(value) }
        else if let value = try? base.decodeIfPresent(Float.self, forKey: codingKey) { return UInt8(value) }
        else if let value = try? base.decodeIfPresent(Bool.self, forKey: codingKey) { return value ? 0 : 1 }
        else if let value = try? base.decodeIfPresent(Double.self, forKey: codingKey) { return UInt8(value) }
        else if let value = try? base.decodeIfPresent(Int8.self, forKey: codingKey) { return UInt8(value) }
        else if let value = try? base.decodeIfPresent(Int16.self, forKey: codingKey) { return UInt8(value) }
        else if let value = try? base.decodeIfPresent(Int32.self, forKey: codingKey) { return UInt8(value) }
        else if let value = try? base.decodeIfPresent(Int64.self, forKey: codingKey) { return UInt8(value) }
        else if let value = try? base.decodeIfPresent(UInt.self, forKey: codingKey) { return UInt8(value) }
        else if let value = try? base.decodeIfPresent(UInt8.self, forKey: codingKey) { return UInt8(value) }
        else if let value = try? base.decodeIfPresent(UInt16.self, forKey: codingKey) { return UInt8(value) }
        else if let value = try? base.decodeIfPresent(UInt32.self, forKey: codingKey) { return UInt8(value) }
        else if let value = try? base.decodeIfPresent(UInt64.self, forKey: codingKey) { return UInt8(value) }
        else { return nil }
    }

    /// 解码UInt16
    /// - Parameter codingKey: key
    /// - Returns: 类型可选
    func decodeIfPresent(codingKey: Key) -> UInt16? {
        if let value = try? base.decodeIfPresent(String.self, forKey: codingKey) { return UInt16(value) }
        else if let value = try? base.decodeIfPresent(Int.self, forKey: codingKey) { return UInt16(value) }
        else if let value = try? base.decodeIfPresent(Float.self, forKey: codingKey) { return UInt16(value) }
        else if let value = try? base.decodeIfPresent(Bool.self, forKey: codingKey) { return value ? 0 : 1 }
        else if let value = try? base.decodeIfPresent(Double.self, forKey: codingKey) { return UInt16(value) }
        else if let value = try? base.decodeIfPresent(Int8.self, forKey: codingKey) { return UInt16(value) }
        else if let value = try? base.decodeIfPresent(Int16.self, forKey: codingKey) { return UInt16(value) }
        else if let value = try? base.decodeIfPresent(Int32.self, forKey: codingKey) { return UInt16(value) }
        else if let value = try? base.decodeIfPresent(Int64.self, forKey: codingKey) { return UInt16(value) }
        else if let value = try? base.decodeIfPresent(UInt.self, forKey: codingKey) { return UInt16(value) }
        else if let value = try? base.decodeIfPresent(UInt8.self, forKey: codingKey) { return UInt16(value) }
        else if let value = try? base.decodeIfPresent(UInt16.self, forKey: codingKey) { return UInt16(value) }
        else if let value = try? base.decodeIfPresent(UInt32.self, forKey: codingKey) { return UInt16(value) }
        else if let value = try? base.decodeIfPresent(UInt64.self, forKey: codingKey) { return UInt16(value) }

        else { return nil }
    }

    /// 解码UInt32
    /// - Parameter codingKey: key
    /// - Returns: 类型可选
    func decodeIfPresent(codingKey: Key) -> UInt32? {
        if let value = try? base.decodeIfPresent(String.self, forKey: codingKey) { return UInt32(value) }
        else if let value = try? base.decodeIfPresent(Int.self, forKey: codingKey) { return UInt32(value) }
        else if let value = try? base.decodeIfPresent(Float.self, forKey: codingKey) { return UInt32(value) }
        else if let value = try? base.decodeIfPresent(Bool.self, forKey: codingKey) { return value ? 0 : 1 }
        else if let value = try? base.decodeIfPresent(Double.self, forKey: codingKey) { return UInt32(value) }
        else if let value = try? base.decodeIfPresent(Int8.self, forKey: codingKey) { return UInt32(value) }
        else if let value = try? base.decodeIfPresent(Int16.self, forKey: codingKey) { return UInt32(value) }
        else if let value = try? base.decodeIfPresent(Int32.self, forKey: codingKey) { return UInt32(value) }
        else if let value = try? base.decodeIfPresent(Int64.self, forKey: codingKey) { return UInt32(value) }
        else if let value = try? base.decodeIfPresent(UInt.self, forKey: codingKey) { return UInt32(value) }
        else if let value = try? base.decodeIfPresent(UInt8.self, forKey: codingKey) { return UInt32(value) }
        else if let value = try? base.decodeIfPresent(UInt16.self, forKey: codingKey) { return UInt32(value) }
        else if let value = try? base.decodeIfPresent(UInt32.self, forKey: codingKey) { return UInt32(value) }
        else if let value = try? base.decodeIfPresent(UInt64.self, forKey: codingKey) { return UInt32(value) }
        else { return nil }
    }

    /// 解码UInt64
    /// - Parameter codingKey: key
    /// - Returns: 类型可选
    func decodeIfPresent(codingKey: Key) -> UInt64? {
        if let value = try? base.decodeIfPresent(String.self, forKey: codingKey) { return UInt64(value) }
        else if let value = try? base.decodeIfPresent(Int.self, forKey: codingKey) { return UInt64(value) }
        else if let value = try? base.decodeIfPresent(Float.self, forKey: codingKey) { return UInt64(value) }
        else if let value = try? base.decodeIfPresent(Bool.self, forKey: codingKey) { return value ? 0 : 1 }
        else if let value = try? base.decodeIfPresent(Double.self, forKey: codingKey) { return UInt64(value) }
        else if let value = try? base.decodeIfPresent(Int8.self, forKey: codingKey) { return UInt64(value) }
        else if let value = try? base.decodeIfPresent(Int16.self, forKey: codingKey) { return UInt64(value) }
        else if let value = try? base.decodeIfPresent(Int32.self, forKey: codingKey) { return UInt64(value) }
        else if let value = try? base.decodeIfPresent(Int64.self, forKey: codingKey) { return UInt64(value) }
        else if let value = try? base.decodeIfPresent(UInt.self, forKey: codingKey) { return UInt64(value) }
        else if let value = try? base.decodeIfPresent(UInt8.self, forKey: codingKey) { return UInt64(value) }
        else if let value = try? base.decodeIfPresent(UInt16.self, forKey: codingKey) { return UInt64(value) }
        else if let value = try? base.decodeIfPresent(UInt32.self, forKey: codingKey) { return UInt64(value) }
        else if let value = try? base.decodeIfPresent(UInt64.self, forKey: codingKey) { return UInt64(value) }
        else { return nil }
    }
}

// MARK: - 决策判断

public extension AxcKeyedDecodingContainerSpace { }
