//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

public extension AxcCIFilterCategory {
    /// 半色调效果
    enum HalftoneEffect: String {
        /// 圆形屏幕
        case circularScreen
        /// CMYK半色调
        case cMYKHalftone
        /// 点阵屏幕
        case dotScreen
        /// 斜线屏幕
        case hatchedScreen
        /// 直线屏幕
        case lineScreen
    }
}
