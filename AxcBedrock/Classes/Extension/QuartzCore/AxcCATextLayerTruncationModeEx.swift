//
//  AxcCATextLayerTruncationModeEx.swift
//  Pods
//
//  Created by 赵新 on 2023/7/1.
//

import QuartzCore

// MARK: - CATextLayerAlignmentMode + AxcSpaceProtocol

extension CATextLayerTruncationMode: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == CATextLayerTruncationMode {
    /// 转换成NSLineBreakMode
    var nsLineBreakMode: NSLineBreakMode? {
        switch base {
        case .start: return .byTruncatingHead
        case .end: return .byTruncatingTail
        case .middle: return .byTruncatingMiddle
        case .none: return .byWordWrapping
        default: return nil
        }
    }
}

// MARK: - 类方法

public extension AxcSpace where Base == CATextLayerTruncationMode { }

// MARK: - 属性 & Api

public extension AxcSpace where Base == CATextLayerTruncationMode { }

// MARK: - 决策判断

public extension AxcSpace where Base == CATextLayerTruncationMode { }
