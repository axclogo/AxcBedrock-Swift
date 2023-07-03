//
//  AxcCATextLayerAlignmentModeEx.swift
//  Pods
//
//  Created by 赵新 on 2023/7/1.
//

import QuartzCore

// MARK: - CATextLayerAlignmentMode + AxcSpaceProtocol

extension CATextLayerAlignmentMode: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == CATextLayerAlignmentMode {
    /// 转换成NSTextAlignment
    var nsTextAlignment: NSTextAlignment? {
        switch base {
        case .natural: return .natural
        case .left: return .left
        case .right: return .right
        case .center: return .center
        case .justified: return .justified
        default: return nil
        }
    }
}

// MARK: - 类方法

public extension AxcSpace where Base == CATextLayerAlignmentMode { }

// MARK: - 属性 & Api

public extension AxcSpace where Base == CATextLayerAlignmentMode { }

// MARK: - 决策判断

public extension AxcSpace where Base == CATextLayerAlignmentMode { }
