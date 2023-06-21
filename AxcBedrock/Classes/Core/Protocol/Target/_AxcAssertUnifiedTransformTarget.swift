//
//  AxcAssertionsTransformProtocol.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/26.
//

import Foundation

// MARK: - [AxcAssertUnifiedTransformTarget]

protocol AxcAssertUnifiedTransformTarget { }

extension AxcAssertUnifiedTransformTarget {
    /// 失败断言内容
    static var FailureContent: String {
        return "对象转换失败，请检查参数类型"
    }
}

