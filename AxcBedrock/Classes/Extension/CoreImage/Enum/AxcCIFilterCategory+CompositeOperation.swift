//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

// MARK: - [AxcCIFilterCategory.CompositeOperation]

public extension AxcCIFilterCategory {
    /// 合成操作
    enum CompositeOperation: String {
        /// 加法合成
        case additionCompositing
        /// 颜色混合模式
        case colorBlendMode
        /// 颜色加深混合模式
        case colorBurnBlendMode
        /// 颜色减淡混合模式
        case colorDodgeBlendMode
        /// 变暗混合模式
        case darkenBlendMode
        /// 差异混合模式
        case differenceBlendMode
        /// 除法混合模式
        case divideBlendMode
        /// 排除混合模式
        case exclusionBlendMode
        /// 强光混合模式
        case hardLightBlendMode
        /// 色相混合模式
        case hueBlendMode
        /// 变亮混合模式
        case lightenBlendMode
        /// 线性加深混合模式
        case linearBurnBlendMode
        /// 线性减淡混合模式
        case linearDodgeBlendMode
        /// 线性光混合模式
        case linearLightBlendMode
        /// 亮度混合模式
        case luminosityBlendMode
        /// 最大合成
        case maximumCompositing
        /// 最小合成
        case minimumCompositing
        /// 乘法混合模式
        case multiplyBlendMode
        /// 乘法合成
        case multiplyCompositing
        /// 叠加混合模式
        case overlayBlendMode
        /// 点亮混合模式
        case pinLightBlendMode
        /// 饱和度混合模式
        case saturationBlendMode
        /// 屏幕混合模式
        case screenBlendMode
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
        /// 减法混合模式
        case subtractBlendMode
        /// 亮光混合模
        case vividLightBlendMode
    }
}

// MARK: - AxcCIFilterCategory.CompositeOperation + _AxcCIFilterNameProtocol

extension AxcCIFilterCategory.CompositeOperation: _AxcCIFilterNameProtocol { }
