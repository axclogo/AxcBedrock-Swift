//
//  _AxcAssertUnifiedTransformTarget+CoreGraphics.swift
//  FBSnapshotTestCase
//
//  Created by 赵新 on 2023/2/13.
//

import CoreGraphics

extension AxcAssertUnifiedTransformTarget {
    /// 设置CGFloat相关
    func assertTransformCGFloat(_ number: AxcUnifiedNumber) -> CGFloat {
        return Self.AssertTransformCGFloat(number)
    }

    /// 设置CGFloat相关
    static func AssertTransformCGFloat(_ number: AxcUnifiedNumber) -> CGFloat {
        guard let float = CGFloat.Axc.CreateOptional(number) else {
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
    /// 设置CGFloat相关
    func assertTransformCGColor(_ color: AxcUnifiedColor) -> CGColor {
        return Self.AssertTransformCGColor(color)
    }

    /// 设置CGFloat相关
    static func AssertTransformCGColor(_ color: AxcUnifiedColor) -> CGColor {
        guard let cgColor = CGColor.Axc.CreateOptional(color) else {
            AxcBedrockLib.Log(FailureContent)
            #if DEBUG
            AxcBedrockLib.FatalLog(FailureContent)
            #else
            return AxcBedrockColor.black.cgColor
            #endif
        }
        return cgColor
    }
}
