//
//  AxcNSTextAlignmentEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/7/7.
//

import Foundation

public extension NSTextAlignment {
    /// 转换成CATextLayerAlignmentMode
    var axc_caTextLayerAlignmentMode: CATextLayerAlignmentMode {
        var alignment: CATextLayerAlignmentMode = .left
        switch self {
        case .left:      alignment = .left
        case .center:    alignment = .center
        case .right:     alignment = .right
        case .justified: alignment = .justified
        case .natural:   alignment = .natural
        }
        return alignment
    }
}
