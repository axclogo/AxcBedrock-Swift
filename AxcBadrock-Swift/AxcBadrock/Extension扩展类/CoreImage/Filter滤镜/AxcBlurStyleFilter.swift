//
//  AxcBlurFilter.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/13.
//

import UIKit

// MARK: - 模糊滤镜组对象
public class AxcBlurStyleFilter: AxcBaseStyleFilter {}

// MARK: - 内部包含的所有可选滤镜链式语法
public extension AxcBlurStyleFilter {
    /// 渲染方形模糊滤镜
    var axc_boxBlurFilter: AxcBoxBlurFilter {
        return AxcBoxBlurFilter().axc_inputUIImage(image).axc_radius(10)
    }
    
    /// 渲染圆形模糊滤镜
    var axc_discBlurFilter: AxcDiscBlurFilter {
        return AxcDiscBlurFilter().axc_inputUIImage(image).axc_radius(8)
    }
    
    /// 渲染高斯模糊滤镜
    var axc_gaussianBlurFilter: AxcGaussianBlurFilter {
        return AxcGaussianBlurFilter().axc_inputUIImage(image).axc_radius(10)
    }
    /// 渲染遮罩模糊滤镜
    var axc_maskedVariableBlurFilter: AxcMaskedVariableBlurFilter {
        return AxcMaskedVariableBlurFilter().axc_inputUIImage(image).axc_radius(5)
    }
    
    /// 渲染运动模糊滤镜
    var axc_motionBlurFilter: AxcMotionBlurFilter {
        return AxcMotionBlurFilter().axc_inputUIImage(image).axc_radius(20)
    }
    
    /// 渲染变焦模糊滤镜
    var axc_zoomBlurFilter: AxcZoomBlurFilter {
        let filter = AxcZoomBlurFilter().axc_inputUIImage(image).axc_amount(20)
        guard let img = image else { return filter}
        filter.axc_center(CIVector(cgPoint: img.axc_center ))
        return filter
    }
}

// MARK: - 所有可选滤镜
/// 方形模糊滤镜
public class AxcBoxBlurFilter: AxcBaseFilter,
                               AxcFilterImageInterFace,
                               AxcFilterRadiusInterFace {
    override func setFilterName() -> String { return "CIBoxBlur" }
}
/// 圆形模糊滤镜
public class AxcDiscBlurFilter: AxcBaseFilter,
                                AxcFilterImageInterFace,
                                AxcFilterRadiusInterFace {
    override func setFilterName() -> String { return "CIDiscBlur" }
}
/// 高斯模糊滤镜
public class AxcGaussianBlurFilter: AxcBaseFilter,
                                    AxcFilterImageInterFace,
                                    AxcFilterRadiusInterFace {
    override func setFilterName() -> String { return "CIGaussianBlur" }
}
/// 遮罩模糊滤镜
public class AxcMaskedVariableBlurFilter: AxcBaseFilter,
                                          AxcFilterImageInterFace,
                                          AxcFilterRadiusInterFace,
                                          AxcFilterMaskInterFace {
    override func setFilterName() -> String { return "CIMaskedVariableBlur" }
}
/// 运动模糊滤镜
public class AxcMotionBlurFilter: AxcBaseFilter,
                                  AxcFilterImageInterFace,
                                  AxcFilterRadiusInterFace,
                                  AxcFilterAngleInterFace {
    override func setFilterName() -> String { return "CIMotionBlur" }
}
/// 变焦模糊滤镜
public class AxcZoomBlurFilter: AxcBaseFilter,
                                AxcFilterImageInterFace,
                                AxcFilterAmountInterFace,
                                AxcFilterCenterInterFace {
    override func setFilterName() -> String { return "CIZoomBlur" }
}

