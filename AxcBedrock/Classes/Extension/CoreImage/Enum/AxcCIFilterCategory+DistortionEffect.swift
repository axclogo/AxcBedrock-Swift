//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

// MARK: - [AxcCIFilterCategory.DistortionEffect]

public extension AxcCIFilterCategory {
    /// 扭曲效果
    enum DistortionEffect: String {
        /// 凸起扭曲
        case bumpDistortion
        /// 线性凸起扭曲
        case bumpDistortionLinear
        /// 相机校准镜头校正
        case cameraCalibrationLensCorrection
        /// 圆形飞溅扭曲
        case circleSplashDistortion
        /// 圆形包裹
        case circularWrap
        /// 位移扭曲
        case displacementDistortion
        /// 露丝特扭曲
        case droste
        /// 玻璃扭曲
        case glassDistortion
        /// 菱形玻璃
        case glassLozenge
        /// 穴扭曲
        case holeDistortion
        /// 光隧道
        case lightTunnel
        /// 九分拉伸
        case ninePartStretched
        /// 九分平铺
        case ninePartTiled
        /// 捏扭曲
        case pinchDistortion
        /// 拉伸裁剪
        case stretchCrop
        /// 圆环透镜扭曲
        case torusLensDistortion
        /// 旋转扭曲
        case twirlDistortion
        /// 漩涡扭曲
        case vortexDistortion
    }
}

// MARK: - AxcCIFilterCategory.DistortionEffect + _AxcCIFilterNameProtocol

extension AxcCIFilterCategory.DistortionEffect: _AxcCIFilterNameProtocol { }
