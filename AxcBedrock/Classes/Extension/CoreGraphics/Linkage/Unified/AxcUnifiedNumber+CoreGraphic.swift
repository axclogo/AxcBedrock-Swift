//
//  AxcUnifiedNumber+CoreGraphic.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

import CoreGraphics

// MARK: - CGFloat + AxcUnifiedNumber

extension CGFloat: AxcUnifiedNumber { }

public extension AxcSpace where Base: AxcUnifiedNumber {
    /// 转换CGFloat类型 具有默认值
    var cgFloat: CGFloat {
        return CGFloat.Axc.Create(base)
    }

    /// 转换CGFloat类型 可选
    var cgFloat_optional: CGFloat? {
        return CGFloat.Axc.CreateOptional(base)
    }

    /// 转换成CGRect
    var cgRect: CGRect {
        return CGRect.Axc.Create(assertTransformCGFloat(base))
    }

    /// 转换成CGPoint
    var cgPoint: CGPoint {
        return CGPoint.Axc.Create(all: assertTransformCGFloat(base))
    }

    /// 转换成CGSize
    var cgSize: CGSize {
        return CGSize.Axc.Create(assertTransformCGFloat(base))
    }
}
