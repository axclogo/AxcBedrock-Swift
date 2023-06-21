//
//  AxcNSTextAlignmentEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/4/8.
//

#if canImport(UIKit)

import UIKit

// MARK: - NSTextAlignment + AxcSpaceProtocol

extension NSTextAlignment: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == NSTextAlignment {
    /// 转换成CATextLayerAlignmentMode
    var caTextLayerAlignmentMode: CATextLayerAlignmentMode? {
        var alignment: CATextLayerAlignmentMode?
        switch base {
        case .left: alignment = .left
        case .center: alignment = .center
        case .right: alignment = .right
        case .justified: alignment = .justified
        case .natural: alignment = .natural
        @unknown default: alignment = nil
        }
        return alignment
    }
}

// MARK: - 类方法

public extension AxcSpace where Base == NSTextAlignment { }

// MARK: - 属性 & Api

public extension AxcSpace where Base == NSTextAlignment { }

// MARK: - 决策判断

public extension AxcSpace where Base == NSTextAlignment { }

// MARK: - 运算符

public extension AxcSpace where Base == NSTextAlignment { }

#endif
