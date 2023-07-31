//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

// MARK: - [AxcCIFilterCategory.Stylize]

public extension AxcCIFilterCategory {
    /// 风格化效果
    enum Stylize: String {
        /// 使用alpha遮罩混合
        case blendWithAlphaMask
        /// 使用蓝色遮罩混合
        case blendWithBlueMask
        /// 使用遮罩混合
        case blendWithMask
        /// 使用红色遮罩混合
        case blendWithRedMask
        /// 光晕效果
        case bloom
        /// 漫画效果
        case comicEffect
        /// 3x3卷积
        case convolution3X3
        /// 5x5卷积
        case convolution5X5
        /// 7x7卷积
        case convolution7X7
        /// 横向9像素卷积
        case convolution9Horizontal
        /// 纵向9像素卷积
        case convolution9Vertical
        /// 3x3 RGB卷积
        case convolutionRGB3X3
        /// 5x5 RGB卷积
        case convolutionRGB5X5
        /// 7x7 RGB卷积
        case convolutionRGB7X7
        /// 横向9像素RGB卷积
        case convolutionRGB9Horizontal
        /// 纵向9像素RGB卷积
        case convolutionRGB9Vertical
        /// 使用Core ML模型过滤
        case coreMLModelFilter
        /// 晶化效果
        case crystallize
        /// 景深效果
        case depthOfField
        /// 边缘效果
        case edges
        /// 边缘处理
        case edgeWork
        /// Gabor梯度
        case gaborGradients
        /// 阴暗效果
        case gloom
        /// 从遮罩生成高度场
        case heightFieldFromMask
        /// 六边形像素化
        case hexagonalPixellate
        /// 高亮阴影调整
        case highlightShadowAdjust
        /// 线条叠加效果
        case lineOverlay
        /// 混合处理
        case mix
        /// 人体分割
        case personSegmentation
        /// 像素化处理
        case pixellate
        /// 点状处理
        case pointillize
        /// 显著性过滤
        case saliencyMapFilter
        /// 最近采样
        case sampleNearest
        /// 阴影材质
        case shadedMaterial
        /// 斑点颜色
        case spotColor
        /// 聚光灯效果
        case spotLight
    }
}

// MARK: - AxcCIFilterCategory.Stylize + _AxcCIFilterNameProtocol

extension AxcCIFilterCategory.Stylize: _AxcCIFilterNameProtocol { }
