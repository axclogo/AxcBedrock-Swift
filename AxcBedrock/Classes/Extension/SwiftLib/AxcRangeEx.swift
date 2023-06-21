//
//  AxcRangeEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/25.
//

import Foundation

// MARK: - [AxcRangeSpace]

public struct AxcRangeSpace<Bound> where Bound: Comparable {
    init(_ base: Range<Bound>) {
        self.base = base
    }

    var base: Range<Bound>
}

public extension Range {
    /// 命名空间
    var axc: AxcRangeSpace<Bound> {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcRangeSpace<Bound>.Type {
        return AxcRangeSpace<Bound>.self
    }
}

public extension AxcRangeSpace {
    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedRange?) -> Range<Bound>? where Bound == Int {
        guard let unifiedValue = unifiedValue else { return nil }
        var newValue: Range<Bound>?
        if let nsRange = unifiedValue as? NSRange {
            newValue = Range(nsRange)
        }
        if let range = unifiedValue as? Range<Bound> {
            newValue = range
        }
        if let closedRange = unifiedValue as? ClosedRange<Bound> {
            newValue = Range(closedRange)
        }
        return newValue
    }
}
