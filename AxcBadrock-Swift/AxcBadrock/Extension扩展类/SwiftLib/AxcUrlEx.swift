//
//  AxcUrlEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/8.
//

import Foundation

// MARK: - 数据转换
public extension URL {
    /// 转换成URLRequest
    var axc_request: URLRequest {
        return URLRequest(url: self)
    }
    
    /// 转换成URLComponents
    var axc_urlComponents: URLComponents? {
        return URLComponents(url: self, resolvingAgainstBaseURL: true)
    }
}

// MARK: - 属性 & Api
public extension URL {
    
    /// 向url尾部添加&修改参数，如果已有key，则为修改
    ///
    ///        let url = URL(string: "https://google.com")!
    ///        let param = ["q": "Swifter Swift"]
    ///        url.axc_appendQueryParam(params) -> "https://google.com?q=Swifter%20Swift"
    ///
    /// - Parameter parameters: 参数字典
    /// - Returns: 添加后参数后的Url
    @discardableResult
    mutating func axc_addParam(_ param: [String: String]) -> URL {
        guard var urlComponents = axc_urlComponents else { return self }
        guard var _param = axc_allParam else { return self }
        _param += param // 优先覆盖之前的key
        var items: [URLQueryItem] = []
        _param.forEach { items.append(URLQueryItem(name: $0, value: $1)) }
        urlComponents.queryItems = items
        guard let url = urlComponents.url else { return self }
        self = url
        return self
    }
    
    /// 移除url的一对键值对
    /// - Parameter key: 需要移除的键值对
    @discardableResult
    mutating func axc_removeParam(for key: String) -> URL {
        guard var urlComponents = axc_urlComponents else { return self }
        var items: [URLQueryItem] = []
        urlComponents.queryItems?.forEach{
            if $0.name != key{ items.append($0) }
        }
        urlComponents.queryItems = items
        guard let url = urlComponents.url else { return self }
        self = url
        return self
    }
    
    /// 移除所有参数
    /// - Returns: 返回所有移除的参数对象
    @discardableResult
    mutating func axc_removeAllParam() -> URL {
        guard var urlComponents = axc_urlComponents else { return self }
        urlComponents.queryItems?.removeAll()
        guard let newUrl = urlComponents.url else { return self }
        var newUrlStr = newUrl.axc_string
        if (newUrlStr.hasSuffix("?")) { newUrlStr.removeLast() }
        guard let newUrl2 = newUrlStr.axc_url else { return self }
        self = newUrl2
        return self
    }
    
    /// 通过key获取参数中的值
    /// - Parameter key: String
    /// - Returns: String
    func axc_value(for key: String) -> String? {
        return URLComponents(string: absoluteString)?.queryItems?.first(where: { $0.name == key })? .value
    }
    
    /// 获取url中所有的参数
    var axc_allParam: [String: String]? {
        guard let components = axc_urlComponents else { return nil }
        var _param: [String: String] = [:]
        if let queryItems = components.queryItems {
            queryItems.forEach({ item in
                _param[item.name] = item.value
            })
        }
        return _param
    }
    
    /// 移除所有附加路径
    ///
    ///        var url = URL(string: "https://domain.com/path/other")!
    ///        url.axc_removeAllPath()
    ///        print(url) // prints "https://domain.com/"
    ///
    @discardableResult
    mutating func axc_removeAllPath() -> URL {
        for _ in 0..<pathComponents.count - 1 {
            deleteLastPathComponent()
        }
        return self
    }
    
    /// 获取域名
    ///
    ///        let url = URL(string: "https://domain.com")!
    ///        print(url.droppedScheme()) // prints "domain.com"
    ///
    var axc_droppedScheme: URL? {
        if let scheme = scheme {
            let droppedScheme = String(absoluteString.dropFirst(scheme.count + 3))
            return URL(string: droppedScheme)
        }
        guard host != nil else { return self }
        let droppedScheme = String(absoluteString.dropFirst(2))
        return URL(string: droppedScheme)
    }
}

// MARK: - 决策判断
public extension URL {
    
    /// 是否是一个有效的Schem URL
    var axc_isValidSchemedUrl: Bool { return self.scheme != nil }
    
    /// 是否是一个http的Url
    var axc_isHttpUrl: Bool { return self.scheme == "http" }
    
    /// 是否是一个https的Url
    var axc_isHttpsUrl: Bool { return self.scheme == "https" }
    
    /// 是否是文件Url
    var axc_isFileUrl: Bool { return self.isFileURL }
    
    /// 是否含有参数
    var axc_isHasParam: Bool {
        guard let items = axc_urlComponents?.queryItems else { return false }
        return (items.count) > 0
    }
}

// MARK: - 操作符
public extension URL {
    /// 使url取值能像字典一样
    ///
    ///     var url = "https://google.com".axc_url
    ///     url["123"] = "456" -> "https://google.com?123=456"
    ///
    subscript(_ key: String) -> String? {
        set{ if (newValue != nil) { self.axc_addParam([key:newValue!]) } }
        get{ return self.axc_value(for: key) }
    }
}

// MARK: - 运算符
public extension URL {
    
    /// 向Url中加一段键值对
    ///
    ///     "https://google.com".axc_url + ["axc":"Swifter"] -> "https://google.com?axc=Swifter"
    ///     "https://google.com?axc=Swifter".axc_url + ["axc":"123"] -> "https://google.com?axc=123"
    ///
    static func + (leftValue: URL, rightValue: [String:String]) -> URL? {
        var url = leftValue
        url.axc_addParam(rightValue)
        return url
    }
    
    /// 向url移除一对键值对
    ///
    ///     "https://google.com?axc=Swifter" - "axc" -> "https://google.com"
    ///
    /// - Parameters:
    ///   - leftValue: 需要移除的url
    ///   - rightValue: 需要移除的key
    /// - Returns: 返回移除的对象
    static func - (leftValue: URL, rightValue: String) -> URL? {
        var url = leftValue
        url.axc_removeParam(for: rightValue)
        return url
    }
}
