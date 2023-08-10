//
//  AxcNSRangeEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/25.
//

import Foundation

// MARK: - NSRange + AxcSpaceProtocol

extension NSRange: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == NSRange { }

// MARK: - 类方法

public extension AxcSpace where Base == NSRange {
    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedRange?) -> NSRange? {
        guard let unifiedValue = unifiedValue else { return nil }
        var newValue: NSRange?
        if let nsRange = unifiedValue as? NSRange {
            newValue = nsRange
        }
        if let range = unifiedValue as? Range<Int> {
            newValue = .init(range)
        }
        if let range = unifiedValue as? ClosedRange<Int> {
            newValue = .init(range)
        }
        return newValue
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base == NSRange { }

// MARK: - 决策判断

public extension AxcSpace where Base == NSRange { }
