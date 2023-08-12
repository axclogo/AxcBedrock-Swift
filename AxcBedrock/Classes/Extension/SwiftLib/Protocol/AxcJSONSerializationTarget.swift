//
//  AxcJSONSerializationTarget.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/21.
//

import Foundation

public typealias AxcSerializationJsonMode = AxcEnum.SerializationJsonMode

// MARK: - [AxcEnum.SerializationJsonMode]

public extension AxcEnum {
    /// 序列化模式
    enum SerializationJsonMode {
        /// 自动序列化对象
        case autoSerializationObject(_ object: Any?)
        /// 自定义序列化的Data
        case customSerializationData(_ data: Data?)
    }
}

// MARK: - [AxcJSONSerializationTarget]

public protocol AxcJSONSerializationTarget {
    /// 设置序列化模式
    var serializationJsonMode: AxcSerializationJsonMode { get }
}

public extension AxcJSONSerializationTarget {
    /// 使用JSONSerialization转换成JsonData
    var jsonSerializationData: Data? {
        return jsonSerializationData()
    }

    /// 使用JSONSerialization转换成JsonData
    /// - Parameters:
    ///   - writingOptions: 写入选项
    /// - Returns: Data
    func jsonSerializationData(writingOptions: JSONSerialization.WritingOptions = .prettyPrinted) -> Data? {
        switch serializationJsonMode {
        // 自动序列化对象
        case let .autoSerializationObject(serializationObj):
            guard let serializationObj,
                  JSONSerialization.isValidJSONObject(serializationObj),
                  let jsonData = try? JSONSerialization.data(withJSONObject: serializationObj, options: writingOptions)
            else { return nil }
            return jsonData
        // 自定义序列化
        case let .customSerializationData(data):
            return data
        }
    }

    /// 使用JSONSerialization转换成Json对象
    /// Array或者Dictonary
    var jsonSerializationObj: Any? {
        return jsonSerializationObj()
    }

    /// 使用JSONSerialization转换成Json对象
    /// - Parameters:
    ///   - writingOptions: 写入选项
    ///   - readingOptions: 读取选项
    /// - Returns: Array或者Dictonary
    func jsonSerializationObj(writingOptions: JSONSerialization.WritingOptions = .prettyPrinted,
                              readingOptions: JSONSerialization.ReadingOptions = .mutableContainers) -> Any? {
        guard let jsonData = jsonSerializationData(writingOptions: writingOptions),
              let jsonObj = try? JSONSerialization.jsonObject(with: jsonData, options: readingOptions) else { return nil }
        return jsonObj
    }
}

public extension AxcJSONSerializationTarget {
    /// 使用JSONSerialization转换成JsonString，默认编码utf8
    var jsonSerializationString: String? {
        return jsonSerializationString(encoding: .utf8)
    }

    /// 使用JSONSerialization转换成JsonString
    func jsonSerializationString(encoding: String.Encoding) -> String? {
        guard let jsonData = jsonSerializationData else { return nil }
        return jsonData.axc.string(encoding: encoding)
    }
}

// MARK: - AxcArraySpace + AxcJSONSerializationTarget

/// 遵循协议
extension AxcArraySpace: AxcJSONSerializationTarget {
    /// 协议的需要转换的类型
    public var serializationJsonMode: AxcSerializationJsonMode {
        return .autoSerializationObject(base)
    }
}

// MARK: - AxcDictionarySpace + AxcJSONSerializationTarget

/// 遵循协议
extension AxcDictionarySpace: AxcJSONSerializationTarget {
    /// 协议的需要转换的类型
    public var serializationJsonMode: AxcSerializationJsonMode {
        return .autoSerializationObject(base)
    }
}

// MARK: - AxcSpace + AxcJSONSerializationTarget

/// 遵循协议
extension AxcSpace: AxcJSONSerializationTarget {
    /// 协议的需要转换的类型
    public var serializationJsonMode: AxcSerializationJsonMode {
        if let string = base as? String { // 字符串
            if let encodingType = string.axc.encodingType, // 找到编码类型
               string.axc.isJSONString(encoding: encodingType) { // 如果是JSON字符串
                let data = string.axc.data(encoding: encodingType)
                return .customSerializationData(data)
            }
        } else if let data = base as? Data { // data
            return .customSerializationData(data)
        } else if var signedInteger = base as? (any SignedInteger) { // 整数
            let data = withUnsafeBytes(of: &signedInteger) { Data($0) }
            return .customSerializationData(data)
        } else if var binaryFloatingPoint = base as? (any BinaryFloatingPoint) { // 浮点数
            let data = withUnsafeBytes(of: &binaryFloatingPoint) { Data($0) }
            return .customSerializationData(data)
        }
        return .autoSerializationObject(base)
    }
}
