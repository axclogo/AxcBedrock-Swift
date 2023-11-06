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
        var uiRectCorner: UIRectCorner = []
        if self.contains(.topLeft) {
            uiRectCorner.insert(.topLeft)
        }
        if self.contains(.topRight) {
            uiRectCorner.insert(.topRight)
        }
        if self.contains(.bottomLeft) {
            uiRectCorner.insert(.bottomLeft)
        }
        if self.contains(.bottomRight) {
            uiRectCorner.insert(.bottomRight)
        }
        if self.contains(.all) {
            uiRectCorner.insert(.allCorners)
        }
        return uiRectCorner
    }
}

#endif
