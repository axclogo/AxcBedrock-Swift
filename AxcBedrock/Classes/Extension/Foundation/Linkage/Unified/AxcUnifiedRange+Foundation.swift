//
//  AxcUnifiedRange+Foundation.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

import Foundation

// MARK: - NSRange + AxcUnifiedRange

extension NSRange: AxcUnifiedRange { }

public extension AxcRangeSpace {
    /// 转换NSRange类型
    /// 转换仅支持Int类型
    var nsRange: NSRange? {
        return .Axc.CreateOptional(base)
    }
}

public extension AxcClosedRangeSpace {
    /// 转换NSRange类型
    /// 转换仅支持Int类型
    var nsRange: NSRange? {
        return .Axc.CreateOptional(base)
    }
}
