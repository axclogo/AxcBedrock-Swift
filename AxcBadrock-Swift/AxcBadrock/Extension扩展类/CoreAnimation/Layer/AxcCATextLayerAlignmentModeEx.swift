//
//  AxcCATextLayerAlignmentModeEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/7/7.
//

import Foundation

public extension CATextLayerAlignmentMode {
    /// 转换成NSTextAlignment
    var axc_nsTextAlignment: NSTextAlignment {
        var alignment: NSTextAlignment = .left
        switch self {
        case .left:      alignment = .left
        case .center:    alignment = .center
        case .right:     alignment = .right
        case .justified: alignment = .justified
        case .natural:   alignment = .natural
        default: break
        }
        return alignment
    }
}
