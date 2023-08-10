//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

// MARK: - [AxcCIFilterCategory.Sharpen]

public extension AxcCIFilterCategory {
    /// 锐化效果
    enum Sharpen: String {
        /// 提升亮度
        case sharpenLuminance
        /// 锐化蒙版
        case unsharpMask
    }
}

// MARK: - AxcCIFilterCategory.Sharpen + _AxcCIFilterNameProtocol

extension AxcCIFilterCategory.Sharpen: _AxcCIFilterNameProtocol { }
