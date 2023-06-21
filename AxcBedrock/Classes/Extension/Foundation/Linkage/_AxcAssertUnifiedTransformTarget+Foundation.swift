//
//  _AxcAssertUnifiedTransformTarget+Foundation.swift
//  FBSnapshotTestCase
//
//  Created by 赵新 on 2023/2/13.
//

import Foundation

extension AxcAssertUnifiedTransformTarget {
    /// 设置范围相关
    func assertTransformNSRange(_ range: AxcUnifiedRange) -> NSRange {
        return Self.AssertTransformNSRange(range)
    }

    /// 设置范围相关
    static func AssertTransformNSRange(_ range: AxcUnifiedRange) -> NSRange {
        guard let range = NSRange.Axc.CreateOptional(range) else {
            AxcBedrockLib.Log(FailureContent)
            #if DEBUG
            AxcBedrockLib.FatalLog(FailureContent)
            #else
            return NSRange(location: 0, length: 0)
            #endif
        }
        return range
    }
}

extension AxcAssertUnifiedTransformTarget {
    /// 设置Number相关
    func assertTransformNumber(_ number: AxcUnifiedNumber) -> NSNumber {
        return Self.AssertTransformNumber(number)
    }

    /// 设置Number相关
    static func AssertTransformNumber(_ number: AxcUnifiedNumber) -> NSNumber {
        guard let number = NSNumber.Axc.CreateOptional(number) else {
            AxcBedrockLib.Log(FailureContent)
            #if DEBUG
            AxcBedrockLib.FatalLog(FailureContent)
            #else
            return .init(value: 0)
            #endif
        }
        return number
    }
}
