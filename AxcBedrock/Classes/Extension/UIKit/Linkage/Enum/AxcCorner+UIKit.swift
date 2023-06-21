//
//  AxcCorner+UIKit.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/15.
//

#if canImport(UIKit)

import UIKit

public extension AxcCorner {
    /// 转换成UIRectCorner
    var toUIRectCorner: UIRectCorner {
        switch self {
        case .topLeft: return .topLeft
        case .topRight: return .topRight
        case .bottomLeft: return .bottomLeft
        case .bottomRight: return .bottomRight
        case .all: return .allCorners
        default: return []
        }
    }
}

#endif
