//
//  _AxcAssertUnifiedTransformTarget+SwiftLib.swift
//  FBSnapshotTestCase
//
//  Created by 赵新 on 2023/2/13.
//

import Foundation

extension AxcAssertUnifiedTransformTarget {
    /// 设置字符串相关
    func assertTransformString(_ string: AxcUnifiedString) -> String {
        return Self.AssertTransformString(string)
    }

    /// 设置字符串相关
    static func AssertTransformString(_ string: AxcUnifiedString) -> String {
        guard let string = String.Axc.CreateOptional(string) else {
            AxcBedrockLib.Log(FailureContent)
            #if DEBUG
            AxcBedrockLib.FatalLog(FailureContent)
            #else
            return ""
            #endif
        }
        return string
    }
}

extension AxcAssertUnifiedTransformTarget {
    /// 设置URL相关
    func assertTransformURL(_ url: AxcUnifiedUrl) -> URL {
        return Self.AssertTransformURL(url)
    }

    /// 设置字符串相关
    static func AssertTransformURL(_ url: AxcUnifiedUrl) -> URL {
        guard let url = URL.Axc.CreateOptional(url) else {
            AxcBedrockLib.Log(FailureContent)
            #if DEBUG
            AxcBedrockLib.FatalLog(FailureContent)
            #else
            return "".axc.url
            #endif
        }
        return url
    }
}

extension AxcAssertUnifiedTransformTarget {
    /// 设置Float相关
    func assertTransformFloat(_ number: AxcUnifiedNumber) -> Float {
        return Self.AssertTransformFloat(number)
    }

    /// 设置Float相关
    static func AssertTransformFloat(_ number: AxcUnifiedNumber) -> Float {
        guard let float = Float.Axc.CreateOptional(number) else {
            AxcBedrockLib.Log(FailureContent)
            #if DEBUG
            AxcBedrockLib.FatalLog(FailureContent)
            #else
            return 0
            #endif
        }
        return float
    }
}

extension AxcAssertUnifiedTransformTarget {
    /// 设置Double相关
    func assertTransformDouble(_ number: AxcUnifiedNumber) -> Double {
        return Self.AssertTransformDouble(number)
    }

    /// 设置Double相关
    static func AssertTransformDouble(_ number: AxcUnifiedNumber) -> Double {
        guard let double = Double.Axc.CreateOptional(number) else {
            AxcBedrockLib.Log(FailureContent)
            #if DEBUG
            AxcBedrockLib.FatalLog(FailureContent)
            #else
            return 0
            #endif
        }
        return double
    }
}

extension AxcAssertUnifiedTransformTarget {
    /// 设置Int相关
    func assertTransformInt(_ number: AxcUnifiedNumber) -> Int {
        return Self.AssertTransformInt(number)
    }

    /// 设置Int相关
    static func AssertTransformInt(_ number: AxcUnifiedNumber) -> Int {
        guard let int = Int.Axc.CreateOptional(number) else {
            AxcBedrockLib.Log(FailureContent)
            #if DEBUG
            AxcBedrockLib.FatalLog(FailureContent)
            #else
            return 0
            #endif
        }
        return int
    }
}
