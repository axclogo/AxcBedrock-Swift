//
//  AxcClosedRangeEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/25.
//

import Foundation

// MARK: - [AxcClosedRangeSpace]

public struct AxcClosedRangeSpace<Bound> where Bound: Comparable {
    init(_ base: ClosedRange<Bound>) {
        self.base = base
    }

    var base: ClosedRange<Bound>
}

public extension ClosedRange {
    /// 命名空间
    var axc: AxcClosedRangeSpace<Bound> {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcClosedRangeSpace<Bound>.Type {
        return AxcClosedRangeSpace<Bound>.self
    }
}

// PartialRangeUpTo
// PartialRangeThrough

public extension AxcClosedRangeSpace {
    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedRange?) -> ClosedRange<Bound>? where Bound == Int {
        guard let unifiedValue = unifiedValue else { return nil }
        var newValue: ClosedRange<Bound>?
        if let nsRange = unifiedValue as? NSRange {
            if let range = Range<Bound>(nsRange) {
                newValue = ClosedRange(range)
            }
        }
        if let range = unifiedValue as? Range<Bound> {
            newValue = ClosedRange(range)
        }
        if let closedRange = unifiedValue as? ClosedRange<Bound> {
            newValue = closedRange
        }
        return newValue
    }
}
