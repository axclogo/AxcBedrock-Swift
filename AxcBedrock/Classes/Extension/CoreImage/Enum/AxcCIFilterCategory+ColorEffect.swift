//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

// MARK: - [AxcCIFilterCategory.ColorEffect]

public extension AxcCIFilterCategory {
    /// 颜色效果
    enum ColorEffect: String {
        /// 颜色交叉多项式
        case colorCrossPolynomial
        /// 颜色立方体
        case colorCube
        /// 与掩模混合的颜色立方体
        case colorCubesMixedWithMask
        /// 具有颜色空间的颜色立方体
        case colorCubeWithColorSpace
        /// 颜色曲线
        case colorCurves
        /// 颜色反转
        case colorInvert
        /// 颜色映射
        case colorMap
        /// 灰度图
        case colorMonochrome
        /// 颜色分级处理
        case colorPosterize
        /// 将Lab转换为RGB
        case convertLabToRGB
        /// 将RGB转换为Lab
        case convertRGBtoLab
        /// 抖动处理
        case dither
        /// 文档增强器
        case documentEnhancer
        /// 伪彩色效果
        case falseColor
        /// Lab Delta E
        case labDeltaE
        /// 掩模转为Alpha通道
        case maskToAlpha
        /// 最大分量
        case maximumComponent
        /// 最小分量
        case minimumComponent
        /// 调色板质心
        case paletteCentroid
        /// 调色板
        case palettize
        /// 铬效果
        case photoEffectChrome
        /// 褪色效果
        case photoEffectFade
        /// 即时效果
        case photoEffectInstant
        /// 单色效果
        case photoEffectMono
        /// 黑白效果
        case photoEffectNoir
        /// 处理效果
        case photoEffectProcess
        /// 色调效果
        case photoEffectTonal
        /// 转移效果
        case photoEffectTransfer
        /// 老照片效果
        case sepiaTone
        /// 热效应
        case thermal
        /// 晕影效果
        case vignette
        /// 晕影效果
        case vignetteEffect
        /// X光效果
        case xRay
    }
}

// MARK: - AxcCIFilterCategory.ColorEffect + _AxcCIFilterNameProtocol

extension AxcCIFilterCategory.ColorEffect: _AxcCIFilterNameProtocol { }
