//
//  AxcCorner+QuartzCore.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/15.
//

import QuartzCore

public extension AxcCorner {
    /// 转换成CACornerMask
    @available(iOS 11.0, tvOS 11.0, *)
    var toCACornerMask: CACornerMask {
        var cornerMask: CACornerMask = []
        if self.contains(.topLeft) {
            cornerMask.insert(.layerMinXMinYCorner)
        }
        if self.contains(.topRight) {
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        if self.contains(.bottomLeft) {
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        if self.contains(.bottomRight) {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        if self.contains(.all) {
            cornerMask = [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner,
            ]
        }
        return cornerMask
    }
}
