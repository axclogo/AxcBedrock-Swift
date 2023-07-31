//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

// MARK: - [AxcCIFilterCategory.Reduction]

public extension AxcCIFilterCategory {
    /// 降低效果
    enum Reduction: String {
        /// 区域平均
        case areaAverage
        /// 区域直方图
        case areaHistogram
        /// 区域对数直方图
        case areaLogarithmicHistogram
        /// 区域最大值
        case areaMaximum
        /// 区域最大值Alpha通道
        case areaMaximumAlpha
        /// 区域最小值
        case areaMinimum
        /// 区域最小值Alpha通道
        case areaMinimumAlpha
        /// 区域最小值最大值
        case areaMinMax
        /// 区域最小值最大值红色通道
        case areaMinMaxRed
        /// 列平均
        case columnAverage
        /// 直方图显示滤镜
        case histogramDisplayFilter
        /// K均值
        case kMeans
        /// 行平均
        case rowAverage
    }
}

// MARK: - AxcCIFilterCategory.Reduction + _AxcCIFilterNameProtocol

extension AxcCIFilterCategory.Reduction: _AxcCIFilterNameProtocol { }
