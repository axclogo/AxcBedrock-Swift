//
//  CGPath.swift
//  AxcBedrock-iOS
//
//  Created by 赵新 on 2023/6/30.
//
#if canImport(AppKit)

import AppKit

public extension AxcSpace where Base: CGPath {
    /// 转换成NSBezierPath
    var nsBezierPath: AxcBedrockBezierPath {
        return .Axc.Create(cgPath: base)
    }
}

#endif
