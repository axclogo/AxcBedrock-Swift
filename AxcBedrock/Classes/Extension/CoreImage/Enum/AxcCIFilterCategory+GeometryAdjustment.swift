//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

public extension AxcCIFilterCategory {
    /// 几何调整
    enum GeometryAdjustment: String {
        /// 仿射变换
        case affineTransform
        /// 双三次比例变换
        case bicubicScaleTransform
        /// 裁剪
        case crop
        /// 边缘保护增强滤镜
        case edgePreserveUpsampleFilter
        /// 引导滤波器
        case guidedFilter
        /// 基石校正（综合）
        case keystoneCorrectionCombined
        /// 基石校正（水平）
        case keystoneCorrectionHorizontal
        /// 基石校正（垂直）
        case keystoneCorrectionVertical
        /// Lanczos比例变换
        case lanczosScaleTransform
        /// 透视校正
        case perspectiveCorrection
        /// 透视旋转
        case perspectiveRotate
        /// 透视变换
        case perspectiveTransform
        /// 带范围的透视变换
        case perspectiveTransformWithExtent
        /// 直平滤镜
        case straightenFilter
    }
}
