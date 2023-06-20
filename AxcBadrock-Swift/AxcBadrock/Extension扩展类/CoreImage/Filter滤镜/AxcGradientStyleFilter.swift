//
//  AxcGradientStyleFilter.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/15.
//

import UIKit

// MARK: - 梯度变化滤镜组对象
public class AxcGradientStyleFilter: AxcBaseStyleFilter {}

// MARK: - 内部包含的所有可选滤镜链式语法
public extension AxcGradientStyleFilter {
    /// 渲染一个高斯梯度的效果图片
    var axc_gaussianGradientFilter: AxcGaussianGradientFilter {
        let filter = AxcGaussianGradientFilter().axc_inputUIImage(image)
            .axc_color0( _defaultColor_0 ).axc_color1( _defaultColor_1 )
        guard let img = image else { return filter }
        filter.axc_radius( img.size.axc_smaller ).axc_center( _imageCenter )
        return filter
    }
    
    /// 渲染一个线性梯度的效果图片
    var axc_linearGradientFilter: AxcLinearGradientFilter {
        let filter = AxcLinearGradientFilter().axc_inputUIImage(image)
            .axc_color0( _defaultColor_0 ).axc_color1( _defaultColor_1 )
        guard let img = image else { return filter }
        filter.axc_point0(CGPoint.zero).axc_point1(CGPoint(x: img.axc_width, y: img.axc_height))
        return filter
    }
    
    /// 渲染一个径向梯度的效果图片
    var axc_radialGradientFilter: AxcRadialGradientFilter {
        let filter = AxcRadialGradientFilter().axc_inputUIImage(image).axc_center( _imageCenter )
            .axc_color0( _defaultColor_0 ).axc_color1( _defaultColor_1 )
        guard let img = image else { return filter }
        filter.axc_radius0(0).axc_radius1( img.size.axc_smaller/2 )
        return filter
    }
    
    /// 渲染一个平滑线性梯度的效果图片
    var axc_smoothLinearFilter: AxcSmoothLinearFilter {
        let filter = AxcSmoothLinearFilter().axc_inputUIImage(image)
            .axc_color0( _defaultColor_0 ).axc_color1( _defaultColor_1 )
        guard let img = image else { return filter }
        filter.axc_point0(CGPoint.zero).axc_point1(CGPoint(x: img.axc_width, y: img.axc_height))
        return filter
    }
}

// MARK: - 所有可选滤镜
/// 渐变滤镜的抽象基类
public class AxcBaseGradientFilter: AxcBaseFilter,
                                    AxcFilterImageInterFace {
    override var axc_ciImage: CIImage? {
        let ciImg = super.axc_ciImage
        guard let img = sourceImage else { return ciImg }
        return ciImg?.axc_backgroundCIImage(img)
    }
}

/// 高斯梯度
public class AxcGaussianGradientFilter: AxcBaseGradientFilter,
                                        AxcFilterRadiusInterFace,
                                        AxcFilterColor0InterFace,
                                        AxcFilterColor1InterFace,
                                        AxcFilterCenterInterFace {
    override func setFilterName() -> String { return "CIGaussianGradient" }
}
/// 线性梯度
public class AxcLinearGradientFilter: AxcBaseGradientFilter,
                                      AxcFilterPoint0InterFace,
                                      AxcFilterPoint1InterFace,
                                      AxcFilterColor0InterFace,
                                      AxcFilterColor1InterFace {
    override func setFilterName() -> String { return "CILinearGradient" }
}
/// 径向梯度
public class AxcRadialGradientFilter: AxcBaseGradientFilter,
                                      AxcFilterRadius0InterFace,
                                      AxcFilterRadius1InterFace,
                                      AxcFilterColor0InterFace,
                                      AxcFilterColor1InterFace,
                                      AxcFilterCenterInterFace {
    override func setFilterName() -> String { return "CIRadialGradient" }
}
/// 平滑线性梯度
public class AxcSmoothLinearFilter: AxcBaseGradientFilter,
                                    AxcFilterPoint0InterFace,
                                    AxcFilterPoint1InterFace,
                                    AxcFilterColor0InterFace,
                                    AxcFilterColor1InterFace {
    override func setFilterName() -> String { return "CISmoothLinearGradient" }
}

