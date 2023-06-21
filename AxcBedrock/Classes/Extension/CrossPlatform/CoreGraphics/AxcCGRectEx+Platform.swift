//
//  AxcCGRectEx+Platform.swift
//  Kanna
//
//  Created by 赵新 on 2023/2/28.
//

import CoreGraphics

public extension AxcSpace where Base == CGRect {
    /// （💈跨平台标识）应用填充
    /// - Parameters:
    ///   - contentMode: 填充模式
    ///   - bounds: 框
    /// - Returns: 新框
    func apply(contentMode: AxcBedrockContentMode,
               bounds: CGRect) -> CGRect {
        var rect = base
        switch contentMode {
        case .scaleToFill:
            return bounds
        case .scaleAspectFit:
            return aspectFit(bounds)
        case .scaleAspectFill:
            return aspectFill(bounds)
        case .redraw:
            return rect
        case .center:
            rect.origin.x = (bounds.size.width - rect.size.width) / 2.0
            rect.origin.y = (bounds.size.height - rect.size.height) / 2.0
            return rect
        case .top:
            rect.origin.y = 0
            rect.origin.x = (bounds.size.width - rect.size.width) / 2.0
            return rect
        case .bottom:
            rect.origin.x = (bounds.size.width - rect.size.width) / 2.0
            rect.origin.y = bounds.size.height - rect.size.height
            return rect
        case .left:
            rect.origin.x = 0
            rect.origin.y = (bounds.size.height - rect.size.height) / 2.0
            return rect
        case .right:
            rect.origin.x = bounds.size.width - rect.size.width
            rect.origin.y = (bounds.size.height - rect.size.height) / 2.0
            return rect
        case .topLeft:
            rect.origin = CGPoint.zero
            return rect
        case .topRight:
            rect.origin.x = bounds.size.width - rect.size.width
            rect.origin.y = 0
            return rect
        case .bottomLeft:
            rect.origin.x = 0
            rect.origin.y = bounds.size.height - rect.size.height
            return rect
        case .bottomRight:
            rect.origin.x = bounds.size.width - rect.size.width
            rect.origin.y = bounds.size.height - rect.size.height
            return rect
        #if os(iOS) || os(tvOS)
        @unknown default:
            AxcBedrockLib.FatalLog("未知的转换类型")
        #endif
        }
    }
}
