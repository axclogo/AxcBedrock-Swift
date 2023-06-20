//
//  AxcBaseFilter.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/13.
//

import UIKit
import CoreImage

// MARK: - 基类
public class AxcBaseFilter {
    /// 滤镜对象
    lazy var filter: CIFilter? = {
        return CIFilter(name: setFilterName())
    }()
    /// 子类设置自己需要的滤镜名字
    func setFilterName() -> String {
        return ""
    }
    // 资源图片
    var sourceImage: CIImage?
    // 上下文
    lazy var context: CIContext = {
        return CIContext(options: nil)
    }()
    // 图片绘制大小
    func drawRect() -> CGRect? {
        return nil
    }
    
    // MARK: 同步渲染获取
    /// 同步获取渲染后的CIImage
    var axc_ciImage: CIImage? {
        return filter?.outputImage
    }
    /// 同步获取渲染后的CIImage
    var axc_cgImage: CGImage? {
        return axc_ciImage?.axc_cgImage
    }
    /// 同步获取渲染后的UIImage
    var axc_uiImage: UIImage? {
        return axc_ciImage?.axc_image
    }
    
    // MARK: 异步渲染获取
    /// 异步获取渲染后的CIImage
    func axc_asyncCIImage(_ block: @escaping (_ image: CIImage? )-> Void) {
        var outputImage: CIImage?
        AxcGCD.async { outputImage = self.axc_ciImage }
            _: { block(outputImage) }
    }
    /// 异步获取渲染后的CGImage
    func axc_asyncCGImage(_ block: @escaping (_ image: CGImage? )-> Void) {
        axc_asyncCIImage { block( $0?.cgImage ) }
    }
    /// 异步获取渲染后的UIImage
    func axc_asyncUIImage(_ block: @escaping (_ image: UIImage? )-> Void) {
        axc_asyncCIImage { block( $0?.axc_image ) }
    }
}

// MARK: - 协议接口
/// 输入图片参数的接口协议
public protocol AxcFilterImageInterFace {}
public extension AxcFilterImageInterFace where Self : AxcBaseFilter {
    /// 设置CI图片对象
    @discardableResult
    func axc_inputCIImage(_ inputCIImage: CIImage? ) -> Self {
        self.sourceImage = inputCIImage
        let attributes = self.filter?.attributes ?? [:]
        if attributes.axc_isHasKey("inputImage") {
            self.filter?.setValue(inputCIImage, forKey: "inputImage")
        }
        return self
    }
    /// 设置CG图片对象
    @discardableResult
    func axc_inputCGImage(_ inputCGImage: CGImage? ) -> Self {
        guard let cgImage = inputCGImage else { return self }
        return axc_inputCIImage( CIImage(cgImage: cgImage) )
    }
    /// 设置UI图片对象
    @discardableResult
    func axc_inputUIImage(_ inputUIImage: UIImage? ) -> Self {
        guard let cgImage = inputUIImage?.cgImage else { return self }
        return axc_inputCGImage(cgImage)
    }
}

/// 半径参数的接口协议
public protocol AxcFilterRadiusInterFace {}
public extension AxcFilterRadiusInterFace where Self : AxcBaseFilter {
    /// 设置半径
    @discardableResult
    func axc_radius(_ radius: CGFloat = 0 ) -> Self {
        self.filter?.setValue(radius.axc_number, forKey: "inputRadius")
        return self
    }
}

/// 半径参数的接口协议
public protocol AxcFilterRadius0InterFace {}
public extension AxcFilterRadius0InterFace where Self : AxcBaseFilter {
    /// 设置半径
    @discardableResult
    func axc_radius0(_ radius0: CGFloat = 0 ) -> Self {
        self.filter?.setValue(radius0.axc_number, forKey: "inputRadius0")
        return self
    }
}

/// 半径参数的接口协议
public protocol AxcFilterRadius1InterFace {}
public extension AxcFilterRadius1InterFace where Self : AxcBaseFilter {
    /// 设置半径
    @discardableResult
    func axc_radius1(_ radius1: CGFloat = 0 ) -> Self {
        self.filter?.setValue(radius1.axc_number, forKey: "inputRadius1")
        return self
    }
}

/// 遮罩参数的接口协议
public protocol AxcFilterMaskInterFace {}
public extension AxcFilterMaskInterFace where Self : AxcBaseFilter {
    /// 设置CIImage遮罩
    @discardableResult
    func axc_mask(_ mask: CIImage ) -> Self {
        self.filter?.setValue(mask, forKey: "inputMask")
        return self
    }
    /// 设置CGImage遮罩
    @discardableResult
    func axc_mask(_ mask: CGImage ) -> Self {
        return axc_mask( CIImage(cgImage: mask) )
    }
    /// 设置UIImage遮罩
    @discardableResult
    func axc_mask(_ mask: UIImage ) -> Self {
        guard let cgImg = mask.cgImage else { return self }
        return axc_mask( cgImg )
    }
}

/// 角度参数的接口协议
public protocol AxcFilterAngleInterFace {}
public extension AxcFilterAngleInterFace where Self : AxcBaseFilter {
    /// 设置角度，取值 0 ～ 360，默认0 也就是 .pi
    @discardableResult
    func axc_angle(angle: CGFloat = 0 ) -> Self {
        return axc_radian(radian: angle.axc_angleToRadian)
    }
    /// 设置弧度，取值 0 ～ 2.pi，默认0
    @discardableResult
    func axc_radian(radian: CGFloat = 0 ) -> Self {
        self.filter?.setValue(radian.axc_number, forKey: "inputAngle")
        return self
    }
}

/// 数量，程度参数的接口协议
public protocol AxcFilterAmountInterFace {}
public extension AxcFilterAmountInterFace where Self : AxcBaseFilter {
    /// 设置数量，程度
    @discardableResult
    func axc_amount(_ amount: CGFloat = 0 ) -> Self {
        self.filter?.setValue(amount.axc_number, forKey: "inputAmount")
        return self
    }
}

/// 中心参数的接口协议
public protocol AxcFilterCenterInterFace {}
public extension AxcFilterCenterInterFace where Self : AxcBaseFilter {
    /// 设置中心 CIVector
    @discardableResult
    func axc_center(_ center: CIVector ) -> Self {
        self.filter?.setValue(center, forKey: "inputCenter")
        return self
    }
    /// 设置中心 CGPoint
    @discardableResult
    func axc_center(_ center: CGPoint ) -> Self {
        return axc_center(CIVector(cgPoint: center))
    }
}

/// 锐度参数的接口协议
public protocol AxcFilterSharpnessInterFace {}
public extension AxcFilterSharpnessInterFace where Self : AxcBaseFilter {
    /// 设置锐度 取值0 ～ 1
    @discardableResult
    func axc_sharpness(_ sharpness: CGFloat = 0 ) -> Self {
        self.filter?.setValue(sharpness.axc_number, forKey: "inputSharpness")
        return self
    }
}

/// 强度参数的接口协议
public protocol AxcFilterIntensityInterFace {}
public extension AxcFilterIntensityInterFace where Self : AxcBaseFilter {
    /// 设置强度 取值0 ～ 1
    @discardableResult
    func axc_intensity(_ intensity: CGFloat = 0 ) -> Self {
        self.filter?.setValue(intensity.axc_number, forKey: "inputIntensity")
        return self
    }
}

/// 背景图片参数的接口协议
public protocol AxcFilterBackgroundImageInterFace {}
public extension AxcFilterBackgroundImageInterFace where Self : AxcBaseFilter {
    /// 设置CIImage背景图片
    @discardableResult
    func axc_backgroundImage(_ backgroundImage: CIImage ) -> Self {
        self.filter?.setValue(backgroundImage, forKey: "inputBackgroundImage")
        return self
    }
    /// 设置CGImage背景图片
    @discardableResult
    func axc_backgroundImage(_ backgroundImage: CGImage ) -> Self {
        return axc_backgroundImage( CIImage(cgImage: backgroundImage) )
    }
    /// 设置UIImage背景图片
    @discardableResult
    func axc_backgroundImage(_ backgroundImage: UIImage ) -> Self {
        guard let cgImg = backgroundImage.cgImage else { return self }
        return axc_backgroundImage( cgImg )
    }
}

/// 输入遮罩参数的接口协议
public protocol AxcFilterMaskImageInterFace {}
public extension AxcFilterMaskImageInterFace where Self : AxcBaseFilter {
    /// 设置CIImage输入遮罩图片
    @discardableResult
    func axc_maskImage(_ maskImage: CIImage ) -> Self {
        self.filter?.setValue(maskImage, forKey: "inputMaskImage")
        return self
    }
    /// 设置CGImage输入遮罩图片
    @discardableResult
    func axc_maskImage(_ maskImage: CGImage ) -> Self {
        return axc_maskImage( CIImage(cgImage: maskImage) )
    }
    /// 设置UIImage输入遮罩图片
    @discardableResult
    func axc_maskImage(_ maskImage: UIImage ) -> Self {
        guard let cgImg = maskImage.cgImage else { return self }
        return axc_maskImage( cgImg )
    }
}

/// 偏斜参数的接口协议
public protocol AxcFilterBiasInterFace {}
public extension AxcFilterBiasInterFace where Self : AxcBaseFilter {
    /// 设置偏斜
    @discardableResult
    func axc_bias(_ bias: CGFloat = 0 ) -> Self {
        self.filter?.setValue(bias.axc_number, forKey: "inputBias")
        return self
    }
}

/// 权重参数的接口协议
public protocol AxcFilterWeightsInterFace {}
public extension AxcFilterWeightsInterFace where Self : AxcBaseFilter {
    /// 设置权重
    @discardableResult
    func axc_weights(_ weights: CIVector ) -> Self {
        self.filter?.setValue(weights, forKey: "inputWeights")
        return self
    }
}

/// 点位参数的接口协议
public protocol AxcFilterPointInterFace {}
public extension AxcFilterPointInterFace where Self : AxcBaseFilter {
    /// 设置第一输入点位
    @discardableResult
    func axc_point(_ point: CIVector ) -> Self {
        self.filter?.setValue(point, forKey: "inputPoint")
        return self
    }
    /// 设置第一输入点位
    @discardableResult
    func axc_point(_ point: CGPoint ) -> Self {
        return axc_point(CIVector(cgPoint: point))
    }
}
/// 第一输入点位参数的接口协议
public protocol AxcFilterPoint0InterFace {}
public extension AxcFilterPoint0InterFace where Self : AxcBaseFilter {
    /// 设置第一输入点位
    @discardableResult
    func axc_point0(_ point0: CIVector ) -> Self {
        self.filter?.setValue(point0, forKey: "inputPoint0")
        return self
    }
    /// 设置第一输入点位
    @discardableResult
    func axc_point0(_ point0: CGPoint ) -> Self {
        return axc_point0(CIVector(cgPoint: point0))
    }
}

/// 第二输入点位参数的接口协议
public protocol AxcFilterPoint1InterFace {}
public extension AxcFilterPoint1InterFace where Self : AxcBaseFilter {
    /// 设置第二输入点位
    @discardableResult
    func axc_point1(_ point1: CIVector ) -> Self {
        self.filter?.setValue(point1, forKey: "inputPoint1")
        return self
    }
    /// 设置第二输入点位
    @discardableResult
    func axc_point1(_ point1: CGPoint ) -> Self {
        return axc_point1(CIVector(cgPoint: point1))
    }
}

/// 饱和参数的接口协议
public protocol AxcFilterSaturationInterFace {}
public extension AxcFilterSaturationInterFace where Self : AxcBaseFilter {
    /// 设置饱和
    @discardableResult
    func axc_saturation(_ saturation: CGFloat = 0 ) -> Self {
        self.filter?.setValue(saturation.axc_number, forKey: "inputSaturation")
        return self
    }
}

/// usm半径参数的接口协议
public protocol AxcFilterUnsharpMaskRadiusInterFace {}
public extension AxcFilterUnsharpMaskRadiusInterFace where Self : AxcBaseFilter {
    /// 设置usm半径
    @discardableResult
    func axc_unsharpMaskRadius(_ unsharpMaskRadius: CGFloat = 0 ) -> Self {
        self.filter?.setValue(unsharpMaskRadius.axc_number, forKey: "inputUnsharpMaskRadius")
        return self
    }
}

/// usm强度参数的接口协议
public protocol AxcFilterUnsharpMaskIntensityInterFace {}
public extension AxcFilterUnsharpMaskIntensityInterFace where Self : AxcBaseFilter {
    /// 设置usm强度
    @discardableResult
    func axc_unsharpMaskIntensity(_ unsharpMaskIntensity: CGFloat = 0 ) -> Self {
        self.filter?.setValue(unsharpMaskIntensity.axc_number, forKey: "inputUnsharpMaskIntensity")
        return self
    }
}

/// 第一输入颜色参数的接口协议
public protocol AxcFilterColor0InterFace {}
public extension AxcFilterColor0InterFace where Self : AxcBaseFilter {
    /// 设置第一输入颜色
    @discardableResult
    func axc_color0(_ color0: AxcUnifiedColorTarget ) -> Self {
        self.filter?.setValue(color0.axc_ciColor, forKey: "inputColor0")
        return self
    }
}

/// 第二输入颜色参数的接口协议
public protocol AxcFilterColor1InterFace {}
public extension AxcFilterColor1InterFace where Self : AxcBaseFilter {
    /// 设置第二输入颜色
    @discardableResult
    func axc_color1(_ color1: AxcUnifiedColorTarget ) -> Self {
        self.filter?.setValue(color1.axc_ciColor, forKey: "inputColor1")
        return self
    }
}

/// 范围参数的接口协议
public protocol AxcFilterExtentInterFace {}
public extension AxcFilterExtentInterFace where Self : AxcBaseFilter {
    /// 设置范围
    @discardableResult
    func axc_extent(_ extent: CIVector ) -> Self {
        self.filter?.setValue(extent, forKey: "inputExtent")
        return self
    }
}

/// 数量参数的接口协议
public protocol AxcFilterCountInterFace {}
public extension AxcFilterCountInterFace where Self : AxcBaseFilter {
    /// 设置数量
    @discardableResult
    func axc_count(_ count: CGFloat = 0 ) -> Self {
        self.filter?.setValue(count.axc_number, forKey: "inputCount")
        return self
    }
}

///  比例缩放参数的接口协议
public protocol AxcFilterScaleInterFace {}
public extension AxcFilterScaleInterFace where Self : AxcBaseFilter {
    /// 设置 比例缩放
    @discardableResult
    func axc_scale(_ scale: CGFloat = 0 ) -> Self {
        self.filter?.setValue(scale.axc_number, forKey: "inputScale")
        return self
    }
}

///  转换参数的接口协议
public protocol AxcFilterTransformInterFace {}
public extension AxcFilterTransformInterFace where Self : AxcBaseFilter {
    /// 设置 转换
    @discardableResult
    func axc_transform(_ transform: CGAffineTransform ) -> Self {
        self.filter?.setValue(NSValue(cgAffineTransform: transform), forKey: "inputTransform")
        return self
    }
}

///  宽度参数的接口协议
public protocol AxcFilterWidthInterFace {}
public extension AxcFilterWidthInterFace where Self : AxcBaseFilter {
    /// 设置 宽度
    @discardableResult
    func axc_width(_ width: CGFloat ) -> Self {
        self.filter?.setValue(width.axc_number, forKey: "inputWidth")
        return self
    }
}

///  锐角参数的接口协议
public protocol AxcFilterAcuteAngleInterFace {}
public extension AxcFilterAcuteAngleInterFace where Self : AxcBaseFilter {
    /// 设置锐角角度，取值 0 ～ 360，默认0 也就是 .pi
    @discardableResult
    func axc_acuteAngle(acuteAngle: CGFloat = 0 ) -> Self {
        return axc_acuteRadian(acuteRadian: acuteAngle.axc_angleToRadian)
    }
    /// 设置锐角弧度，取值 0 ～ 2.pi，默认0
    @discardableResult
    func axc_acuteRadian(acuteRadian: CGFloat = 0 ) -> Self {
        self.filter?.setValue(acuteRadian.axc_number, forKey: "inputAcuteAngle")
        return self
    }
}

/// 左上参数的接口协议
public protocol AxcFilterTopLeftInterFace {}
public extension AxcFilterTopLeftInterFace where Self : AxcBaseFilter {
    /// 设置左上
    @discardableResult
    func axc_topLeft(_ topLeft: CIVector ) -> Self {
        self.filter?.setValue(topLeft, forKey: "inputTopLeft")
        return self
    }
}
/// 右上参数的接口协议
public protocol AxcFilterTopRightInterFace {}
public extension AxcFilterTopRightInterFace where Self : AxcBaseFilter {
    /// 设置右上
    @discardableResult
    func axc_topRight(_ topRight: CIVector ) -> Self {
        self.filter?.setValue(topRight, forKey: "inputTopRight")
        return self
    }
}

/// 左下参数的接口协议
public protocol AxcFilterBottomLeftInterFace {}
public extension AxcFilterBottomLeftInterFace where Self : AxcBaseFilter {
    /// 设置左上
    @discardableResult
    func axc_bottomLeft(_ bottomLeft: CIVector ) -> Self {
        self.filter?.setValue(bottomLeft, forKey: "inputBottomLeft")
        return self
    }
}
/// 右下参数的接口协议
public protocol AxcFilterBottomRightInterFace {}
public extension AxcFilterBottomRightInterFace where Self : AxcBaseFilter {
    /// 设置右上
    @discardableResult
    func axc_bottomRight(_ bottomRight: CIVector ) -> Self {
        self.filter?.setValue(bottomRight, forKey: "inputBottomRight")
        return self
    }
}
/// 大小参数的接口协议
public protocol AxcFilterSizeInterFace {}
public extension AxcFilterSizeInterFace where Self : AxcBaseFilter {
    /// 设置大小
    @discardableResult
    func axc_size(_ size: CGFloat ) -> Self {
        self.filter?.setValue(size.axc_number, forKey: "inputSize")
        return self
    }
}
///  旋转参数的接口协议
public protocol AxcFilterRotationInterFace {}
public extension AxcFilterRotationInterFace where Self : AxcBaseFilter {
    /// 设置旋转角度，取值 0 ～ 360，默认0 也就是 .pi
    @discardableResult
    func axc_rotationAngle(rotationAngle: CGFloat = 0 ) -> Self {
        return axc_rotationRadian(rotationRadian: rotationAngle.axc_angleToRadian)
    }
    /// 设置旋转弧度，取值 0 ～ 2.pi，默认0
    @discardableResult
    func axc_rotationRadian(rotationRadian: CGFloat = 0 ) -> Self {
        self.filter?.setValue(rotationRadian.axc_number, forKey: "inputRotation")
        return self
    }
}
/// 衰变因子参数的接口协议
public protocol AxcFilterDecayInterFace {}
public extension AxcFilterDecayInterFace where Self : AxcBaseFilter {
    /// 设置衰变因子
    @discardableResult
    func axc_decay(_ decay: CGFloat ) -> Self {
        self.filter?.setValue(decay.axc_number, forKey: "inputDecay")
        return self
    }
}
/// 消息数据参数的接口协议
public protocol AxcFilterMessageInterFace {}
public extension AxcFilterMessageInterFace where Self : AxcBaseFilter {
    /// 设置消息数据
    @discardableResult
    func axc_message(_ message: Data ) -> Self {
        self.filter?.setValue(message, forKey: "inputMessage")
        return self
    }
}
/// 紧凑度参数的接口协议
public protocol AxcFilterCompactStyleInterFace {}
public extension AxcFilterCompactStyleInterFace where Self : AxcBaseFilter {
    /// 设置紧凑度
    @discardableResult
    func axc_compactStyle(_ compactStyle: Bool ) -> Self {
        self.filter?.setValue(compactStyle.axc_number, forKey: "inputCompactStyle")
        return self
    }
}
/// 图层参数的接口协议
public protocol AxcFilterLayersInterFace {}
public extension AxcFilterLayersInterFace where Self : AxcBaseFilter {
    /// 设置图层
    @discardableResult
    func axc_layers(_ layers: CGFloat ) -> Self {
        self.filter?.setValue(layers.axc_number, forKey: "inputLayers")
        return self
    }
}
/// 纠错率参数的接口协议
public protocol AxcFilterCorrectionLevelInterFace {}
public extension AxcFilterCorrectionLevelInterFace where Self : AxcBaseFilter {
    /// 设置校纠错率
    @discardableResult
    func axc_correctionLevel(_ correctionLevel: CGFloat ) -> Self {
        self.filter?.setValue(correctionLevel.axc_number, forKey: "inputCorrectionLevel")
        return self
    }
}



