//
//  AxcWKWebViewEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/12.
//

import WebKit

// MARK: - 数据转换

public extension AxcSpace where Base: WKWebView { }

// MARK: - 类方法

public extension AxcSpace where Base: WKWebView { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: WKWebView {
    /// Url加载网页
    @discardableResult
    func loadURL(_ url: URL) -> WKNavigation? {
        return base.load(URLRequest(url: url))
    }

    /// url字符串加载网页
    @discardableResult
    func loadURLString(_ urlString: String, timeout: TimeInterval? = nil) -> WKNavigation? {
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        if let timeout = timeout {
            request.timeoutInterval = timeout
        }
        return base.load(request)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: WKWebView { }
