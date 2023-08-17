//
//  AxcEncodableEx.swift
//  Pods
//
//  Created by 赵新 on 2023/7/14.
//

import Foundation

// MARK: - 数据转换

public extension AxcSpace where Base: Encodable { }

// MARK: - 类方法

public extension AxcSpace where Base: Encodable { }

// MARK: - 废弃兼容

public extension AxcSpace where Base: Encodable {
    /// 转jsondata
    @available(*, deprecated, renamed: "jsonSerializationData")
    var jsonData: Data? {
        return jsonSerializationData
    }

    /// 转换成Json对象
    @available(*, deprecated, renamed: "jsonSerializationObj")
    var jsonObj: Any? {
        return jsonSerializationObj
    }

    /// 根据选择转换成数据对象
    @available(*, deprecated, renamed: "jsonSerializationObj(writingOptions:readingOptions:)")
    func jsonObj(options: JSONSerialization.ReadingOptions = .mutableContainers) -> Any? {
        return jsonSerializationObj(readingOptions: options)
    }

    /// 转json字符串
    @available(*, deprecated, renamed: "jsonSerializationString")
    var jsonStr: String? {
        return jsonSerializationString
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: Encodable {
    /// 使用JSONEncoder转jsondata
    var jsonEncodeData: Data? {
        return try? JSONEncoder().encode(base)
    }

    /// 使用JSONSerialization转换成JsonString，默认编码utf8
    var jsonEncodeString: String? {
        return jsonEncodeString(encoding: .utf8)
    }

    /// 使用JSONSerialization转换成JsonString
    func jsonEncodeString(encoding: String.Encoding) -> String? {
        guard let jsonEncodeData else { return nil }
        return String(data: jsonEncodeData, encoding: encoding)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: Encodable { }
