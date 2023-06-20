//
//  AxcStylizeStyleFilter.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/13.
//

import UIKit

// MARK: - 风格化滤镜组对象
public class AxcStylizeStyleFilter: AxcBaseStyleFilter {}

// MARK: - 内部包含的所有可选滤镜链式语法
public extension AxcStylizeStyleFilter {
    /// 渲染Alpha蒙版混合滤镜
    /// 输入图片被maskImage图片形状镂空
    /// 后透出backgroundImage
    var axc_blendWithAlphaMaskFilter: AxcBlendWithAlphaMaskFilter {
        return AxcBlendWithAlphaMaskFilter().axc_inputUIImage(image)
    }
    
    /// 渲染蒙版混合滤镜
    /// 输入图片被maskImage带颜色部分镂空
    /// 后透出backgroundImage
    var axc_blendWithMaskFilter: AxcBlendWithMaskFilter {
        return AxcBlendWithMaskFilter().axc_inputUIImage(image)
    }
    
    /// 渲染Bloom布鲁姆滤镜
    var axc_bloomFilter: AxcBloomFilter {
        return AxcBloomFilter().axc_inputUIImage(image).axc_radius(10).axc_intensity(1)
    }
    
    /// 渲染像漫画书一样勾勒（图像）边缘，并应用半色调效果滤镜
    var axc_comicEffectFilter: AxcComicEffectFilter {
        return AxcComicEffectFilter().axc_inputUIImage(image)
    }
    
    /// 渲染用一个3x3旋转矩阵来调整像素值滤镜
    var axc_convolution3x3Filter: AxcConvolution3X3Filter {
        return AxcConvolution3X3Filter().axc_inputUIImage(image).axc_bias(0).axc_weights(_default3x3Vector)
    }
    
    /// 渲染用一个5x5旋转矩阵来调整像素值滤镜
    var axc_convolution5x5Filter: AxcConvolution5X5Filter {
        let vector = CIVector(values: [0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 1.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0], count: 25)
        return AxcConvolution5X5Filter().axc_inputUIImage(image).axc_bias(0).axc_weights(vector)
    }
    
    /// 渲染用一个7x7旋转矩阵来调整像素值滤镜
    var axc_convolution7x7Filter: AxcConvolution7X7Filter {
        let vector = CIVector(values: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], count: 49)
        return AxcConvolution7X7Filter().axc_inputUIImage(image).axc_bias(0).axc_weights(vector)
    }
    
    /// 渲染用一个3x3水平矩阵来调整像素值滤镜
    var axc_convolution9HorizontalFilter: AxcConvolution9HorizontalFilter {
        return AxcConvolution9HorizontalFilter().axc_inputUIImage(image).axc_bias(0).axc_weights(_default3x3Vector)
    }
    
    /// 渲染用一个3x3垂直矩阵来调整像素值滤镜
    var axc_convolution9VerticalFilter: AxcConvolution9VerticalFilter {
        return AxcConvolution9VerticalFilter().axc_inputUIImage(image).axc_bias(0).axc_weights(_default3x3Vector)
    }
    
    /// 渲染用一个3x3垂直矩阵来调整像素值滤镜
    var axc_crystallizeFilter: AxcCrystallizeFilter {
        let filter = AxcCrystallizeFilter().axc_inputUIImage(image).axc_radius(20)
        guard let img = image else { return filter}
        filter.axc_center(CIVector(cgPoint: img.axc_center ))
        return filter
    }
    
    /// 渲染模拟一个场景深入的效果滤镜
    var axc_depthOfFieldFilter: AxcDepthOfFieldFilter {
        let filter = AxcDepthOfFieldFilter().axc_inputUIImage(image).axc_radius(6)
            .axc_saturation(1.5).axc_unsharpMaskRadius(2.5).axc_unsharpMaskIntensity(0.5)
        guard let img = image else { return filter}
        filter.axc_point0(CIVector(values: [0.0, img.axc_height/2], count: 2))
            .axc_point1(CIVector(values: [img.axc_width/2, img.axc_height/2], count: 2))
        return filter
    }
    
    /// 渲染用颜色显示图像的边缘滤镜
    var axc_edgesFilter: AxcEdgesFilter {
        return AxcEdgesFilter().axc_inputUIImage(image).axc_intensity(1)
    }
    
    /// 渲染一个黑白风格的类似木块切口的图像滤镜
    var axc_edgesWorkFilter: AxcEdgeWorkFilter {
        return AxcEdgeWorkFilter().axc_inputUIImage(image).axc_radius(3)
    }
    
    /// 渲染忧郁效果滤镜
    var axc_gloomFilter: AxcGloomFilter {
        return AxcGloomFilter().axc_inputUIImage(image).axc_radius(10).axc_intensity(1)
    }
    /// 渲染一个连续的三维物体，一个阁楼形的灰场滤镜
    var axc_heightFieldFilter: AxcHeightFieldFilter {
        return AxcHeightFieldFilter().axc_inputUIImage(image).axc_radius(10)
    }
}

// MARK: - 所有可选滤镜
/// Alpha蒙版混合滤镜
public class AxcBlendWithAlphaMaskFilter: AxcBaseFilter,
                                          AxcFilterImageInterFace,
                                          AxcFilterBackgroundImageInterFace,    // 设置底部图片
                                          AxcFilterMaskImageInterFace {         // 设置切割的遮罩层图
    override func setFilterName() -> String { return "CIBlendWithAlphaMask" }
}

/// 蒙版混合滤镜
public class AxcBlendWithMaskFilter: AxcBaseFilter,
                                     AxcFilterImageInterFace,
                                     AxcFilterBackgroundImageInterFace,    // 设置底部图片
                                     AxcFilterMaskImageInterFace {         // 设置切割的遮罩层图
    override func setFilterName() -> String { return "CIBlendWithMask" }
}

/// Bloom布鲁姆滤镜
public class AxcBloomFilter: AxcBaseFilter,
                             AxcFilterImageInterFace,
                             AxcFilterRadiusInterFace,
                             AxcFilterIntensityInterFace {
    override func setFilterName() -> String { return "CIBloom" }
}

/// 像漫画书一样勾勒（图像）边缘，并应用半色调效果
public class AxcComicEffectFilter: AxcBaseFilter,
                                   AxcFilterImageInterFace {
    override func setFilterName() -> String { return "CIComicEffect" }
}

/// 用一个3x3旋转矩阵来调整像素值
public class AxcConvolution3X3Filter: AxcBaseFilter,
                                      AxcFilterImageInterFace,
                                      AxcFilterBiasInterFace,
                                      AxcFilterWeightsInterFace {
    override func setFilterName() -> String { return "CIConvolution3X3" }
}

/// 用一个5x5旋转矩阵来调整像素值
public class AxcConvolution5X5Filter: AxcBaseFilter,
                                      AxcFilterImageInterFace,
                                      AxcFilterBiasInterFace,
                                      AxcFilterWeightsInterFace {
    override func setFilterName() -> String { return "CIConvolution5X5" }
}

/// 用一个7x7旋转矩阵来调整像素值
public class AxcConvolution7X7Filter: AxcBaseFilter,
                                      AxcFilterImageInterFace,
                                      AxcFilterBiasInterFace,
                                      AxcFilterWeightsInterFace {
    override func setFilterName() -> String { return "CIConvolution7X7" }
}
/// 用一个3x3水平矩阵来调整像素值
public class AxcConvolution9HorizontalFilter: AxcBaseFilter,
                                              AxcFilterImageInterFace,
                                              AxcFilterBiasInterFace,
                                              AxcFilterWeightsInterFace {
    override func setFilterName() -> String { return "CIConvolution9Horizontal" }
}
/// 用一个3x3垂直矩阵来调整像素值
public class AxcConvolution9VerticalFilter: AxcBaseFilter,
                                            AxcFilterImageInterFace,
                                            AxcFilterBiasInterFace,
                                            AxcFilterWeightsInterFace {
    override func setFilterName() -> String { return "CIConvolution9Vertical" }
}
/// 通过汇集源像素的颜色值，创建多边形色块
public class AxcCrystallizeFilter: AxcBaseFilter,
                                   AxcFilterImageInterFace,
                                   AxcFilterRadiusInterFace,
                                   AxcFilterCenterInterFace {
    override func setFilterName() -> String { return "CICrystallize" }
}
/// 模拟一个场景深入的效果
public class AxcDepthOfFieldFilter: AxcBaseFilter,
                                    AxcFilterImageInterFace,
                                    AxcFilterRadiusInterFace,
                                    AxcFilterPoint0InterFace,
                                    AxcFilterPoint1InterFace,
                                    AxcFilterSaturationInterFace,
                                    AxcFilterUnsharpMaskRadiusInterFace,
                                    AxcFilterUnsharpMaskIntensityInterFace {
    override func setFilterName() -> String { return "CIDepthOfField" }
}
/// 用颜色显示图像的边缘
public class AxcEdgesFilter: AxcBaseFilter,
                             AxcFilterImageInterFace,
                             AxcFilterIntensityInterFace {
    override func setFilterName() -> String { return "CIEdges" }
}
/// 产生一个黑白风格的类似木块切口的图像
public class AxcEdgeWorkFilter: AxcBaseFilter,
                                AxcFilterImageInterFace,
                                AxcFilterRadiusInterFace {
    override func setFilterName() -> String { return "CIEdgeWork" }
}
/// 忧郁效果
public class AxcGloomFilter: AxcBaseFilter,
                             AxcFilterImageInterFace,
                             AxcFilterRadiusInterFace,
                             AxcFilterIntensityInterFace {
    override func setFilterName() -> String { return "CIGloom" }
}
/// 产生一个连续的三维物体，一个阁楼形的灰场
public class AxcHeightFieldFilter: AxcBaseFilter,
                                   AxcFilterImageInterFace,
                                   AxcFilterRadiusInterFace {
    override func setFilterName() -> String { return "CIHeightFieldFromMask" }
}


