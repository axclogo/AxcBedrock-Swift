//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

public extension AxcCIFilterCategory {
    /// 非方形像素
    enum NonSquarePixels: String {
        /// 加法合成
        case additionCompositing
        /// 双三次尺度变换
        case bicubicScaleTransform
        /// 色彩绝对差异
        case colorAbsoluteDifference
        /// 色彩混合模式
        case colorBlendMode
        /// 色彩加深混合模式
        case colorBurnBlendMode
        /// 色彩范围限制
        case colorClamp
        /// 色彩控制
        case colorControls
        /// 色彩交叉多项式
        case colorCrossPolynomial
        /// 色彩立方体
        case colorCube
        /// 与掩膜混合的色彩立方体
        case colorCubesMixedWithMask
        /// 带有色彩空间的色彩立方体
        case colorCubeWithColorSpace
        /// 色彩曲线
        case colorCurves
        /// 色彩减淡混合模式
        case colorDodgeBlendMode
        /// 色彩反转
        case colorInvert
        /// 色彩映射
        case colorMap
        /// 色彩矩阵
        case colorMatrix
        /// 单色色彩
        case colorMonochrome
        /// 色彩多项式
        case colorPolynomial
        /// 色彩分色
        case colorPosterize
        /// 色彩阈值
        case colorThreshold
        /// 奥兹色彩阈值
        case colorThresholdOtsu
        /// 转换Lab到RGB
        case convertLabToRGB
        /// 转换RGB到Lab
        case convertRGBtoLab
        /// 变暗混合模式
        case darkenBlendMode
        /// 差异混合模式
        case differenceBlendMode
        /// 溶解过渡
        case dissolveTransition
        /// 除法混合模式
        case divideBlendMode
        /// 文档增强
        case documentEnhancer
        /// 保持边缘的上采样滤镜
        case edgePreserveUpsampleFilter
        /// 排除混合模式
        case exclusionBlendMode
        /// 曝光调整
        case exposureAdjust
        /// 虚假颜色
        case falseColor
        /// 伽马调整
        case gammaAdjust
        /// 强光混合模式
        case hardLightBlendMode
        /// 色调调整
        case hueAdjust
        /// 色调混合模式
        case hueBlendMode
        /// Lab Delta E
        case labDeltaE
        /// 变亮混合模式
        case lightenBlendMode
        /// 线性加深混合模式
        case linearBurnBlendMode
        /// 线性减淡混合模式
        case linearDodgeBlendMode
        /// 线性光混合模式
        case linearLightBlendMode
        /// 线性到SRGB色调曲线
        case linearToSRGBToneCurve
        /// 亮度混合模式
        case luminosityBlendMode
        /// 掩膜到Alpha通道
        case maskToAlpha
        /// 最大分量
        case maximumComponent
        /// 最大合成
        case maximumCompositing
        /// 最小分量
        case minimumComponent
        /// 最小合成
        case minimumCompositing
        /// 乘法混合模式
        case multiplyBlendMode
        /// 乘法合成
        case multiplyCompositing
        /// 叠加混合模式
        case overlayBlendMode
        /// 照片效果 - 铬
        case photoEffectChrome
        /// 照片效果 - 褪色
        case photoEffectFade
        /// 照片效果 - 即时
        case photoEffectInstant
        /// 照片效果 - 单色
        case photoEffectMono
        /// 照片效果 - 黑色
        case photoEffectNoir
        /// 照片效果 - 处理
        case photoEffectProcess
        /// 照片效果 - 色调
        case photoEffectTonal
        /// 照片效果 - 转换
        case photoEffectTransfer
        /// 锁定光混合模式
        case pinLightBlendMode
        /// 饱和度混合模式
        case saturationBlendMode
        /// 屏幕混合模式
        case screenBlendMode
        /// 乌墨色调
        case sepiaTone
        /// 柔光混合模式
        case softLightBlendMode
        /// 源在顶部合成
        case sourceAtopCompositing
        /// 源在内部合成
        case sourceInCompositing
        /// 源在外部合成
        case sourceOutCompositing
        /// 源在上方合成
        case sourceOverCompositing
        /// sRGB色调曲线到线性
        case sRGBToneCurveToLinear
        /// 减法混合模式
        case subtractBlendMode
        /// 温度和色调
        case temperatureAndTint
        /// 热感
        case thermal
        /// 色调曲线
        case toneCurve
        /// 鲜艳度
        case vibrance
        /// 鲜艳光混合模式
        case vividLightBlendMode
        /// 白点调整
        case whitePointAdjust
        /// X射线
        case xRay
    }
}
