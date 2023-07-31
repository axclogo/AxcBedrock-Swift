//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

// MARK: - [AxcCIFilterCategory.Interlaced]

public extension AxcCIFilterCategory {
    /// 交错
    enum Interlaced: String {
        /// 加法合成
        case additionCompositing
        /// 颜色绝对差异
        case colorAbsoluteDifference
        /// 颜色混合模式
        case colorBlendMode
        /// 颜色燃烧混合模式
        case colorBurnBlendMode
        /// 颜色限制
        case colorClamp
        /// 颜色控制
        case colorControls
        /// 颜色交叉多项式
        case colorCrossPolynomial
        /// 颜色立方体
        case colorCube
        /// 与遮罩混合的颜色立方体
        case colorCubesMixedWithMask
        /// 色彩空间的颜色立方体
        case colorCubeWithColorSpace
        /// 颜色曲线
        case colorCurves
        /// 颜色避免混合模式
        case colorDodgeBlendMode
        /// 颜色反转
        case colorInvert
        /// 颜色映射
        case colorMap
        /// 颜色矩阵
        case colorMatrix
        /// 单色颜色
        case colorMonochrome
        /// 颜色多项式
        case colorPolynomial
        /// 颜色分级
        case colorPosterize
        /// 颜色阈值
        case colorThreshold
        /// Otsu颜色阈值
        case colorThresholdOtsu
        /// 转换Lab到RGB
        case convertLabToRGB
        /// 转换RGB到Lab
        case convertRGBtoLab
        /// 昏暗混合模式
        case darkenBlendMode
        /// 差异混合模式
        case differenceBlendMode
        /// 溶解过渡
        case dissolveTransition
        /// 除法混合模式
        case divideBlendMode
        /// 边缘保持上采样滤镜
        case edgePreserveUpsampleFilter
        /// 排除混合模式
        case exclusionBlendMode
        /// 曝光调整
        case exposureAdjust
        /// 伪彩色
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
        /// 亮光混合模式
        case lightenBlendMode
        /// 线性燃烧混合模式
        case linearBurnBlendMode
        /// 线性避免混合模式
        case linearDodgeBlendMode
        /// 线性光混合模式
        case linearLightBlendMode
        /// 线性到SRGB色调曲线
        case linearToSRGBToneCurve
        /// 亮度混合模式
        case luminosityBlendMode
        /// 遮罩转为透明
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
        /// 彩色效果
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
        /// 推光混合模式
        case pinLightBlendMode
        /// 饱和度混合模式
        case saturationBlendMode
        /// 屏幕混合模式
        case screenBlendMode
        /// 乌贼墨色调
        case sepiaTone
        /// 柔光混合模式
        case softLightBlendMode
        /// 源位于顶部合成
        case sourceAtopCompositing
        /// 源在合成中
        case sourceInCompositing
        /// 源在合成外
        case sourceOutCompositing
        /// 源覆盖合成
        case sourceOverCompositing
        /// sRGB色调曲线转线性
        case sRGBToneCurveToLinear
        /// 减法混合模式
        case subtractBlendMode
        /// 色温和色调
        case temperatureAndTint
        /// 热效应
        case thermal
        /// 色调曲线
        case toneCurve
        /// 色彩饱和度
        case vibrance
        /// 暗角
        case vignette
        /// 暗角效果
        case vignetteEffect
        /// 鲜明光混合模式
        case vividLightBlendMode
        /// 白点调整
        case whitePointAdjust
        /// X射线
        case xRay
    }
}

// MARK: - AxcCIFilterCategory.Interlaced + _AxcCIFilterNameProtocol

extension AxcCIFilterCategory.Interlaced: _AxcCIFilterNameProtocol { }
