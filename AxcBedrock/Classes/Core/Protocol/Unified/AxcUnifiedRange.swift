//
//  AxcUnifiedRange.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/25.
//

import Foundation

// MARK: Range统一互转协议
public protocol AxcUnifiedRange { }
extension Range:        AxcUnifiedRange {}
extension ClosedRange:  AxcUnifiedRange {}

// MARK: 数据转换扩展

public extension AxcRangeSpace {
    /// 转换swift ClosedRange类型
    /// 转换仅支持Int类型
    var closedRange: ClosedRange<Int>? {
        return .Axc.CreateOptional(base)
    }
}

public extension AxcClosedRangeSpace {
    /// 转换swift Range类型
    /// 转换仅支持Int类型
    var range: Range<Int>? {
        return .Axc.CreateOptional(base)
    }
}
