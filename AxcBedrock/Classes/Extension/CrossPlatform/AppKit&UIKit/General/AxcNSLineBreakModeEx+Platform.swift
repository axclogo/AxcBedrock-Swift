//
//  AxcNSLineBreakModeEx.swift
//  Pods
//
//  Created by 赵新 on 2023/7/1.
//

#if os(macOS)
import AppKit

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit
#endif

// MARK: - NSLineBreakMode + AxcSpaceProtocol

extension NSLineBreakMode: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == NSLineBreakMode {
    /// 转换成CATextLayerTruncationMode
    var caTextLayerTruncationMode: CATextLayerTruncationMode? {
        switch base {
        case .byTruncatingHead: return .start
        case .byTruncatingTail: return .end
        case .byTruncatingMiddle: return .middle
        case .byWordWrapping, .byCharWrapping, .byClipping: return CATextLayerTruncationMode.none
        @unknown default: return nil
        }
    }
}

// MARK: - 类方法

public extension AxcSpace where Base == NSLineBreakMode { }

// MARK: - 属性 & Api

public extension AxcSpace where Base == NSLineBreakMode { }

// MARK: - 决策判断

public extension AxcSpace where Base == NSLineBreakMode { }
