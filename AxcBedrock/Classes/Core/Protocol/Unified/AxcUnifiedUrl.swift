//
//  AxcUnifiedUrl.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/3.
//

import Foundation

// MARK: - [AxcUnifiedUrl]

public protocol AxcUnifiedUrl { }
extension String:   AxcUnifiedUrl {}
extension URL:      AxcUnifiedUrl {}

public extension AxcSpace where Base: AxcUnifiedUrl {
    /// 转换URL类型
    var url: URL {
        return .Axc.Create(base)
    }

    /// 转换URL类型
    var url_optional: URL? {
        return .Axc.CreateOptional(base)
    }

    /// 转换成文件路径URL
    var fileUrl: URL {
        return fileUrl_optional ?? .init(fileURLWithPath: "")
    }

    /// 转换成文件路径URL
    var fileUrl_optional: URL? {
        guard let path = String.Axc.CreateOptional(base) else { return nil }
        return URL(fileURLWithPath: path)
    }

    /// 转换成URLRequest
    var urlRequest: URLRequest {
        return URLRequest(url: url)
    }

    /// 转换成URLRequest
    var urlRequest_optional: URLRequest? {
        guard let url = url_optional else { return nil }
        return URLRequest(url: url)
    }
}
