//
//  AxcReductionStyleFilter.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/14.
//

import UIKit

// MARK: - 渐变滤镜组对象
public class AxcReductionStyleFilter: AxcBaseStyleFilter {}

// MARK: - 内部包含的所有可选滤镜链式语法
public extension AxcReductionStyleFilter {
    /// 渲染表示某个区域内的平均颜色
    var axc_areaAverageFilter: AxcAreaAverageFilter {
        return AxcAreaAverageFilter().axc_inputUIImage(image).axc_extent( _imageVector )
    }
    
    /// 渲染表示某个区域内的柱状图
    var axc_areaHistogramFilter: AxcAreaHistogramFilter {
        return AxcAreaHistogramFilter().axc_inputUIImage(image).axc_count(10).axc_scale(1).axc_extent( _imageVector )
    }
    
    /// 渲染包含一块颜色区内最大的颜色成分
    var axc_areaMaximumFilter: AxcAreaMaximumFilter {
        return AxcAreaMaximumFilter().axc_inputUIImage(image).axc_extent( _imageVector )
    }
    
    /// 渲染颜色区中最大透明度的颜色矢量
    var axc_areaMaximumAlphaFilter: AxcAreaMaximumAlphaFilter {
        return AxcAreaMaximumAlphaFilter().axc_inputUIImage(image).axc_extent( _imageVector )
    }
    
    /// 渲染包含一块颜色区内最小的颜色成分
    var axc_areaMinimumFilter: AxcAreaMinimumFilter {
        return AxcAreaMinimumFilter().axc_inputUIImage(image).axc_extent( _imageVector )
    }
    
    /// 渲染颜色区中最小透明度的颜色矢量
    var axc_areaMinimumAlphaFilter: AxcAreaMinimumAlphaFilter {
        return AxcAreaMinimumAlphaFilter().axc_inputUIImage(image).axc_extent( _imageVector )
    }
    
    /// 渲染一个高为1像素的图像，包含每个扫描列的平均颜色
    var axc_columnAverageFilter: AxcColumnAverageFilter {
        return AxcColumnAverageFilter().axc_inputUIImage(image).axc_extent( _imageVector )
    }
    
    /// 渲染1个像素宽的图像，其中包含每行扫描的平均颜色
    var axc_rowAverageFilter: AxcRowAverageFilter {
        return AxcRowAverageFilter().axc_inputUIImage(image).axc_extent( _imageVector )
    }
}

// MARK: - 所有可选滤镜
/// 递减滤镜的抽象基类
public class AxcBaseReductionFilter: AxcBaseFilter {
    override var axc_ciImage: CIImage? {
        guard let ciImage = filter?.outputImage else { return nil }
        let rect = drawRect() ?? sourceImage?.extent ?? CGRect.zero
        guard let cgImage = context.createCGImage(ciImage, from: rect) else { return nil }
        return CIImage(cgImage: cgImage)
    }
    override func drawRect() -> CGRect? { return CGRect(x: 0, y: 0, width: 1, height: 1) }
}

/// 表示某个区域内的平均颜色
public class AxcAreaAverageFilter: AxcBaseReductionFilter,
                                   AxcFilterImageInterFace,
                                   AxcFilterExtentInterFace {
    override func setFilterName() -> String { return "CIAreaAverage" }
}

/// 表示某个区域内的柱状图
public class AxcAreaHistogramFilter: AxcBaseReductionFilter,
                                     AxcFilterImageInterFace,
                                     AxcFilterCountInterFace,
                                     AxcFilterScaleInterFace,
                                     AxcFilterExtentInterFace {
    override func setFilterName() -> String { return "CIAreaHistogram" }
    override func drawRect() -> CGRect? {
        var rect: CGRect = super.drawRect() ?? CGRect.zero
        guard let count = self.filter?.value(forKey: "inputCount") as? NSNumber else { return rect }
        rect.size.width = CGFloat(count.floatValue)
        return rect
    }
}

/// 包含一块颜色区内最大的颜色成分
public class AxcAreaMaximumFilter: AxcBaseReductionFilter,
                                   AxcFilterImageInterFace,
                                   AxcFilterExtentInterFace {
    override func setFilterName() -> String { return "CIAreaMaximum" }
}

/// 包含颜色区中最大透明度的颜色矢量
public class AxcAreaMaximumAlphaFilter: AxcBaseReductionFilter,
                                        AxcFilterImageInterFace,
                                        AxcFilterExtentInterFace {
    override func setFilterName() -> String { return "CIAreaMaximumAlpha" }
}

/// 包含一块颜色区内最小的颜色成分
public class AxcAreaMinimumFilter: AxcBaseReductionFilter,
                                   AxcFilterImageInterFace,
                                   AxcFilterExtentInterFace {
    override func setFilterName() -> String { return "CIAreaMinimum" }
}

/// 包含颜色区中最小透明度的颜色矢量
public class AxcAreaMinimumAlphaFilter: AxcBaseReductionFilter,
                                        AxcFilterImageInterFace,
                                        AxcFilterExtentInterFace {
    override func setFilterName() -> String { return "CIAreaMinimumAlpha" }
}

/// 返回一个高为1像素的图像，包含每个扫描列的平均颜色
public class AxcColumnAverageFilter: AxcBaseReductionFilter,
                                     AxcFilterImageInterFace,
                                     AxcFilterExtentInterFace {
    override func setFilterName() -> String { return "CIColumnAverage" }
    override func drawRect() -> CGRect? {
        var rect: CGRect = super.drawRect() ?? CGRect.zero
        guard let extent = self.filter?.value(forKey: "inputExtent") as? CIVector else { return rect }
        rect.size.width = extent.value(at: 2)
        return rect
    }
}

/// 返回1个像素宽的图像，其中包含每行扫描的平均颜色
public class AxcRowAverageFilter: AxcBaseReductionFilter,
                                  AxcFilterImageInterFace,
                                  AxcFilterExtentInterFace {
    override func setFilterName() -> String { return "CIRowAverage" }
    override var axc_ciImage: CIImage? {
        guard let ciImage = filter?.outputImage else { return nil }
        guard let extent = sourceImage?.extent else { return nil }
        let rect = CGRect(x: CGFloat(0), y: CGFloat(0),
                          width: extent.size.axc_bigger, height: extent.size.axc_bigger)
        guard let cgImage = context.createCGImage(ciImage, from: rect)?.axc_setRotate(angle: 90) else { return nil }
        var draw_y = extent.size.axc_bigger - extent.size.axc_smaller
        if draw_y < 0 { draw_y = 0 }
        let drawRect = CGRect(x: rect.width - 1, y: 0, width: 1, height: rect.height - draw_y)
        guard let drawCIImage = cgImage.axc_ciImage,
              let drawCGImage = context.createCGImage(drawCIImage, from: drawRect) else { return nil }
        return CIImage(cgImage: drawCGImage)
    }
}


