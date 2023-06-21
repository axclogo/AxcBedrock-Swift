//
//  AxcURLEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/3.
//

import Foundation

// MARK: - 扩展URL + AxcSpaceProtocol

extension URL: AxcSpaceProtocol {}

// MARK: - 数据转换

public extension AxcSpace where Base == URL {}

// MARK: - 类方法

public extension AxcSpace where Base == URL {
    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedUrl?) -> URL? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let string = unifiedValue as? String { return .init(string: string) }
        if let url = unifiedValue as? URL { return url }
        return nil
    }

    /// 配合协议用创建方法
    static func Create(_ unifiedValue: AxcUnifiedUrl?) -> URL {
        return CreateOptional(unifiedValue) ?? .init(fileURLWithPath: "")
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base == URL {
    /// 获取Url中后带的参数
    var parameters: [String: String]? {
        guard let components = URLComponents(url: base, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else { return nil }
        var items: [String: String] = [:]
        for queryItem in queryItems {
            items[queryItem.name] = queryItem.value
        }
        return items
    }

    /// 向Url后拼接参数
    ///
    ///        let url = URL(string: "https://google.com")!
    ///        let param = ["q": "Swifter Swift"]
    ///        url.axc.appendParameters(params) -> "https://google.com?q=Swifter%20Swift"
    ///
    /// - Parameter parameters: 参数字典
    /// - Returns: 新的Url
    func append(parameters: [String: String]) -> URL? {
        guard var urlComponents = URLComponents(url: base, resolvingAgainstBaseURL: true) else { return nil }
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + parameters
            .map { URLQueryItem(name: $0, value: $1) }
        return urlComponents.url
    }

    /// 获取Url后的某个键值下的值
    ///
    ///     var url = URL(string: "https://google.com?code=12345")!
    ///     url.axc.parametersValue(for: "code") -> "12345"
    ///
    /// - Parameter key: Url参数后的键值
    func parametersValue(for key: String) -> String? {
        return URLComponents(string: base.absoluteString)?
            .queryItems?
            .first(where: { $0.name == key })?
            .value
    }

    /// 移除域名之后的所有路径
    ///
    ///     let url = URL(string: "https://domain.com/path/other")!
    ///     print(url.axc.deletingAllPath()) // prints "https://domain.com/"
    ///
    /// - Returns: 保留域名后的Url
    func removeAllPath() -> URL {
        var url: URL = base
        for _ in 0 ..< base.pathComponents.count - 1 {
            url.deleteLastPathComponent()
        }
        return url
    }

    /// 移除前缀后，只保留域名字段
    ///
    ///        let url = URL(string: "https://domain.com")!
    ///        print(url.droppedScheme()) // prints "domain.com"
    func removeScheme() -> URL? {
        if let scheme = base.scheme {
            let droppedScheme = String(base.absoluteString.dropFirst(scheme.count + 3))
            return URL(string: droppedScheme)
        }
        guard base.host != nil else { return base }
        let droppedScheme = String(base.absoluteString.dropFirst(2))
        return URL(string: droppedScheme)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base == URL {}
