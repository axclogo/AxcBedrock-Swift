//
//  AxcEncodableEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/7/14.
//

import Foundation

// MARK: - 数据转换

public extension AxcSpace where Base: Encodable { }

// MARK: - 类方法

public extension AxcSpace where Base: Encodable { }

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
