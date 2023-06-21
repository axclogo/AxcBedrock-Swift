//
//  AxcCollectionJsonTarget.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/21.
//

import Foundation

// MARK: - [AxcCollectionJsonTarget]

public protocol AxcCollectionJsonTarget {
    associatedtype CollectionType: Collection
    var collection: CollectionType? { get }
}

public extension AxcCollectionJsonTarget {
    /// 转换成JsonData
    var jsonData: Data? {
        return jsonData()
    }

    /// 转换成JsonData
    func jsonData(options: JSONSerialization.WritingOptions = .prettyPrinted) -> Data? {
        guard let _collection = collection,
              JSONSerialization.isValidJSONObject(_collection) else { return nil }
        return try? JSONSerialization.data(withJSONObject: _collection, options: options)
    }
    
    /// 转换成Json
    func jsonClass<T: Decodable>(options: JSONSerialization.WritingOptions = .prettyPrinted) -> T? {
        guard let jsonData = jsonData(options: options) else { return nil }
        return try? JSONDecoder().decode(T.self, from: jsonData)
    }

    /// 转换成JsonString
    var jsonStr: String? {
        guard let jsonData = jsonData else { return nil }
        return jsonData.axc.string
    }

    /// 转换成可被解析的Json字符串
    var parsingJsonStr: String? {
        return jsonStr?.axc.trimmed.axc.replacing("\n")
    }
}
