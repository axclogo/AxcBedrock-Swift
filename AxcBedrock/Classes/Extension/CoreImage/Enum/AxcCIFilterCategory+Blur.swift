//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

public extension AxcCIFilterCategory {
    /// 模糊效果
    enum Blur: String {
        /// Bokeh模糊
        case bokehBlur
        /// 方框模糊
        case boxBlur
        /// 深度模糊效果
        case depthBlurEffect
        /// 圆形模糊
        case discBlur
        /// 高斯模糊
        case gaussianBlur
        /// 变量模糊
        case maskedVariableBlur
        /// 中值滤波
        case medianFilter
        /// 形态梯度
        case morphologyGradient
        /// 形态学最大值
        case morphologyMaximum
        /// 形态学最小值
        case morphologyMinimum
        /// 矩形形态学最大值
        case morphologyRectangleMaximum
        /// 矩形形态学最小值
        case morphologyRectangleMinimum
        /// 运动模糊
        case motionBlur
        /// 噪点降低
        case noiseReduction
        /// 缩放模糊
        case zoomBlur
    }
}
