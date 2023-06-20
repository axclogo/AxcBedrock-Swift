//
//  AxcTileEffectStyleFilter.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/15.
//

import UIKit

// MARK: - 瓷砖化滤镜组对象
public class AxcTileEffectStyleFilter: AxcBaseStyleFilter {}

// MARK: - 内部包含的所有可选滤镜链式语法
public extension AxcTileEffectStyleFilter {
    /// 渲染仿射效果
    var axc_affineClampFilter: AxcAffineClampFilter {
        return AxcAffineClampFilter().axc_inputUIImage(image).axc_transform( _defaultScaleTransform )
    }
    
    /// 渲染仿射Tile效果
    var axc_affineTileFilter: AxcAffineTileFilter {
        return AxcAffineTileFilter().axc_inputUIImage(image).axc_transform( _defaultTransform )
    }
    
    /// 渲染4倍Tile效果
    var axc_fourfoldReflectedTileFilter: AxcFourfoldReflectedTileFilter {
        return AxcFourfoldReflectedTileFilter().axc_inputUIImage(image).axc_width(_imageWidth).axc_angle(angle: 0).axc_acuteAngle(acuteAngle: 90)
            .axc_center( _imageCenter )
    }
    /// 渲染6倍Tile效果
    var axc_sixfoldReflectedTileFilter: AxcSixfoldReflectedTileFilter {
        return AxcSixfoldReflectedTileFilter().axc_inputUIImage(image).axc_width(_imageWidth).axc_angle(angle: 0)
            .axc_center( _imageCenter )
    }
    /// 渲染8倍Tile效果
    var axc_eightfoldReflectedTileFilter: AxcEightfoldReflectedTileFilter {
        return AxcEightfoldReflectedTileFilter().axc_inputUIImage(image).axc_width(_imageWidth).axc_angle(angle: 0)
            .axc_center( _imageCenter )
    }
    /// 渲染20倍Tile效果
    var axc_twelvefoldReflectedTileFilter: AxcTwelvefoldReflectedTileFilter {
        return AxcTwelvefoldReflectedTileFilter().axc_inputUIImage(image).axc_width(_imageWidth).axc_angle(angle: 0)
            .axc_center( _imageCenter )
    }
    
    /// 渲染4倍旋转Tile效果
    var axc_fourfoldRotatedTileFilter: AxcFourfoldRotatedTileFilter {
        return AxcFourfoldRotatedTileFilter().axc_inputUIImage(image).axc_width(_imageWidth).axc_angle(angle: 0)
            .axc_center( _imageCenter )
    }
    /// 渲染6倍旋转Tile效果
    var axc_sixfoldRotatedTileFilter: AxcSixfoldRotatedTileFilter {
        return AxcSixfoldRotatedTileFilter().axc_inputUIImage(image).axc_width(_imageWidth).axc_angle(angle: 0)
            .axc_center( _imageCenter )
    }
    
    /// 渲染4倍翻转Tile效果
    var axc_fourfoldTranslatedTileFilter: AxcFourfoldTranslatedTileFilter {
        return AxcFourfoldTranslatedTileFilter().axc_inputUIImage(image).axc_width(_imageWidth).axc_angle(angle: 0).axc_acuteAngle(acuteAngle: 90)
            .axc_center( _imageCenter )
    }
    
    /// 渲染滑动翻转瓷砖
    var axc_glideReflectedTileFilter: AxcGlideReflectedTileFilter {
        return AxcGlideReflectedTileFilter().axc_inputUIImage(image).axc_width(_imageWidth).axc_angle(angle: 0)
            .axc_center( _imageCenter )
    }
    
    /// 渲染万花筒
    var axc_kaleidoscopeFilter: AxcKaleidoscopeFilter {
        return AxcKaleidoscopeFilter().axc_inputUIImage(image).axc_count(6).axc_angle(angle: 0)
            .axc_center( _imageCenter )
    }
    /// 渲染三角万花筒
    var axc_triangleKaleidoscopeFilter: AxcTriangleKaleidoscopeFilter {
        return AxcTriangleKaleidoscopeFilter().axc_inputUIImage(image).axc_size(_imageWidth).axc_rotationAngle(rotationAngle: 135).axc_decay(0.85)
            .axc_point( _imageCenter )
    }
    
    /// 渲染OP瓷砖
    var axc_opTileFilter: AxcOpTileFilter {
        return AxcOpTileFilter().axc_inputUIImage(image).axc_width(65).axc_angle(angle: 0).axc_scale(2)
            .axc_center( _imageCenter )
    }
    
    /// 渲染OP瓷砖
    var axc_parallelogramTileFilter: AxcParallelogramTileFilter {
        return AxcParallelogramTileFilter().axc_inputUIImage(image).axc_width(_imageWidth).axc_angle(angle: 0).axc_acuteAngle(acuteAngle: 90)
            .axc_center( _imageCenter )
    }
    
    /// 渲染透视瓷砖
    var axc_perspectiveTileFilter: AxcPerspectiveTileFilter {
        let filter = AxcPerspectiveTileFilter().axc_inputUIImage(image)
        filter.axc_topLeft( _defaultTopLeft ).axc_topRight( _defaultTopRight )
            .axc_bottomLeft( _defaultBottomLeft ).axc_bottomRight( _defaultBottomRight )
        return filter
    }
    /// 渲染三角瓷砖
    var axc_triangleTileFilter: AxcTriangleTileFilter {
        return AxcTriangleTileFilter().axc_inputUIImage(image).axc_width(_imageWidth).axc_angle(angle: 0).axc_angle(angle: 0)
            .axc_center( _imageCenter )
    }
    
}

// MARK: - 所有可选滤镜
/// 仿射效果
public class AxcAffineClampFilter: AxcBaseFilter,
                                   AxcFilterImageInterFace,
                                   AxcFilterTransformInterFace {
    override func setFilterName() -> String { return "CIAffineClamp" }
}
/// 仿射Tile效果
public class AxcAffineTileFilter: AxcBaseFilter,
                                  AxcFilterImageInterFace,
                                  AxcFilterTransformInterFace {
    override func setFilterName() -> String { return "CIAffineTile" }
}
/// 4倍Tile效果
public class AxcFourfoldReflectedTileFilter: AxcBaseFilter,
                                             AxcFilterImageInterFace,
                                             AxcFilterWidthInterFace,
                                             AxcFilterAngleInterFace,
                                             AxcFilterAcuteAngleInterFace,
                                             AxcFilterCenterInterFace {
    override func setFilterName() -> String { return "CIFourfoldReflectedTile" }
}
/// 6倍Tile效果
public class AxcSixfoldReflectedTileFilter: AxcBaseFilter,
                                            AxcFilterImageInterFace,
                                            AxcFilterWidthInterFace,
                                            AxcFilterAngleInterFace,
                                            AxcFilterCenterInterFace {
    override func setFilterName() -> String { return "CISixfoldReflectedTile" }
}
/// 8倍Tile效果
public class AxcEightfoldReflectedTileFilter: AxcBaseFilter,
                                              AxcFilterImageInterFace,
                                              AxcFilterWidthInterFace,
                                              AxcFilterAngleInterFace,
                                              AxcFilterCenterInterFace {
    override func setFilterName() -> String { return "CIEightfoldReflectedTile" }
}
/// 20倍Tile效果
public class AxcTwelvefoldReflectedTileFilter: AxcBaseFilter,
                                               AxcFilterImageInterFace,
                                               AxcFilterWidthInterFace,
                                               AxcFilterAngleInterFace,
                                               AxcFilterCenterInterFace {
    override func setFilterName() -> String { return "CITwelvefoldReflectedTile" }
}
/// 4倍旋转Tile效果
public class AxcFourfoldRotatedTileFilter: AxcBaseFilter,
                                           AxcFilterImageInterFace,
                                           AxcFilterWidthInterFace,
                                           AxcFilterAngleInterFace,
                                           AxcFilterCenterInterFace {
    override func setFilterName() -> String { return "CIFourfoldRotatedTile" }
}
/// 6倍旋转Tile效果
public class AxcSixfoldRotatedTileFilter: AxcBaseFilter,
                                          AxcFilterImageInterFace,
                                          AxcFilterWidthInterFace,
                                          AxcFilterAngleInterFace,
                                          AxcFilterCenterInterFace {
    override func setFilterName() -> String { return "CISixfoldRotatedTile" }
}
/// 4倍翻转Tile效果
public class AxcFourfoldTranslatedTileFilter: AxcBaseFilter,
                                              AxcFilterImageInterFace,
                                              AxcFilterWidthInterFace,
                                              AxcFilterAngleInterFace,
                                              AxcFilterAcuteAngleInterFace,
                                              AxcFilterCenterInterFace {
    override func setFilterName() -> String { return "CIFourfoldTranslatedTile" }
}
/// 滑动翻转瓷砖
public class AxcGlideReflectedTileFilter: AxcBaseFilter,
                                          AxcFilterImageInterFace,
                                          AxcFilterWidthInterFace,
                                          AxcFilterAngleInterFace,
                                          AxcFilterCenterInterFace {
    override func setFilterName() -> String { return "CIGlideReflectedTile" }
}
/// 万花筒
public class AxcKaleidoscopeFilter: AxcBaseFilter,
                                    AxcFilterImageInterFace,
                                    AxcFilterCountInterFace,
                                    AxcFilterAngleInterFace,
                                    AxcFilterCenterInterFace {
    override func setFilterName() -> String { return "CIKaleidoscope" }
}
/// 三角形万花筒
public class AxcTriangleKaleidoscopeFilter: AxcBaseFilter,
                                            AxcFilterImageInterFace,
                                            AxcFilterPointInterFace,
                                            AxcFilterSizeInterFace,
                                            AxcFilterRotationInterFace,
                                            AxcFilterDecayInterFace{
    override func setFilterName() -> String { return "CITriangleKaleidoscope" }
}
/// OP瓷砖效果
public class AxcOpTileFilter: AxcBaseFilter,
                              AxcFilterImageInterFace,
                              AxcFilterWidthInterFace,
                              AxcFilterScaleInterFace,
                              AxcFilterAngleInterFace,
                              AxcFilterCenterInterFace {
    override func setFilterName() -> String { return "CIOpTile" }
}
/// 平行四边形的瓷砖
public class AxcParallelogramTileFilter: AxcBaseFilter,
                                         AxcFilterImageInterFace,
                                         AxcFilterWidthInterFace,
                                         AxcFilterAngleInterFace,
                                         AxcFilterAcuteAngleInterFace,
                                         AxcFilterCenterInterFace {
    override func setFilterName() -> String { return "CIParallelogramTile" }
}
/// 透视瓷砖
public class AxcPerspectiveTileFilter: AxcBaseFilter,
                                       AxcFilterImageInterFace,
                                       AxcFilterTopLeftInterFace,
                                       AxcFilterTopRightInterFace,
                                       AxcFilterBottomLeftInterFace,
                                       AxcFilterBottomRightInterFace {
    override func setFilterName() -> String { return "CIPerspectiveTile" }
}
/// 三角瓷砖
public class AxcTriangleTileFilter: AxcBaseFilter,
                                    AxcFilterImageInterFace,
                                    AxcFilterWidthInterFace,
                                    AxcFilterCenterInterFace,
                                    AxcFilterAngleInterFace{
    override func setFilterName() -> String { return "CITriangleTile" }
}
