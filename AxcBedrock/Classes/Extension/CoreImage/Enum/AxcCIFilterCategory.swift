//
//  AxcCIFilterType.swift
//  AxcBedrock-Core
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

/// CI滤镜类别
public typealias AxcCIFilterCategory = AxcBedrockLib.CIFilterCategory

// MARK: - [AxcBedrockLib.CIFilterCategory]

public extension AxcBedrockLib {
    /// CI滤镜类别
    enum CIFilterCategory {
        /// 扭曲效果
        case distortionEffect(type: DistortionEffect)
        /// 几何调整
        case geometryAdjustment(type: GeometryAdjustment)
        /// 合成操作
        case compositeOperation(type: CompositeOperation)
        /// 半色调效果
        case halftoneEffect(type: HalftoneEffect)
        /// 颜色调整
        case colorAdjustment(type: ColorAdjustment)
        /// 颜色效果
        case colorEffect(type: ColorEffect)
        /// 过渡效果
        case transition(type: Transition)
        /// 平铺效果
        case tileEffect(type: TileEffect)
        /// 生成器
        case generator(type: Generator)
        /// 降低效果
        case reduction(type: Reduction)
        /// 渐变效果
        case gradient(type: Gradient)
        /// 风格化效果
        case stylize(type: Stylize)
        /// 锐化效果
        case sharpen(type: Sharpen)
        /// 模糊效果
        case blur(type: Blur)
        /// 视频
        case video(type: Video)
        /// 静态图像
        case stillImage(type: StillImage)
        /// 交错
        case interlaced(type: Interlaced)
        /// 非方形像素
        case nonSquarePixels(type: NonSquarePixels)
        /// 高动态范围
        case highDynamicRange(type: HighDynamicRange)
        /// 内置
        case builtIn(type: BuiltIn)
    }
}
