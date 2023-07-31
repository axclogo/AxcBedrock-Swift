//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

public extension AxcCIFilterCategory {
    /// 渐变效果
    enum Gradient: String {
        /// 高斯梯度
        case gaussianGradient
        /// 色相饱和度值渐变
        case hueSaturationValueGradient
        /// 线性渐变
        case linearGradient
        /// 径向渐变
        case radialGradient
        /// 平滑线性渐变
        case smoothLinearGradient
    }
}
