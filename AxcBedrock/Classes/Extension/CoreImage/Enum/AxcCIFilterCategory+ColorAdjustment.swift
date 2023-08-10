//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

// MARK: - [AxcCIFilterCategory.ColorAdjustment]

public extension AxcCIFilterCategory {
    /// 颜色调整
    enum ColorAdjustment: String {
        /// 颜色绝对差异
        case colorAbsoluteDifference
        /// 颜色限制
        case colorClamp
        /// 颜色控制
        case colorControls
        /// 颜色矩阵
        case colorMatrix
        /// 颜色多项式
        case colorPolynomial
        /// 颜色阈值
        case colorThreshold
        /// 颜色阈值（大津算法）
        case colorThresholdOtsu
        /// 深度到视差
        case depthToDisparity
        /// 视差到深度
        case disparityToDepth
        /// 曝光调整
        case exposureAdjust
        /// 伽马调整
        case gammaAdjust
        /// 色调调整
        case hueAdjust
        /// 线性到sRGB曲线
        case linearToSRGBToneCurve
        /// sRGB到线性曲线
        case sRGBToneCurveToLinear
        /// 色温和色调
        case temperatureAndTint
        /// 曲线
        case toneCurve
        /// 饱和度
        case vibrance
        /// 白点调整
        case whitePointAdjust
    }
}

// MARK: - AxcCIFilterCategory.ColorAdjustment + _AxcCIFilterNameProtocol

extension AxcCIFilterCategory.ColorAdjustment: _AxcCIFilterNameProtocol { }
