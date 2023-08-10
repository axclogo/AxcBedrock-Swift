//
//  AxcCIFilterEx.swift
//  AxcBedrock-Core
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

// MARK: - 数据转换

public extension AxcSpace where Base: CIFilter { }

// MARK: - 类方法

public extension AxcSpace where Base: CIFilter {
    /// 使用枚举创建滤镜
    /// - Parameter category: 二级分类
    /// - Returns: Base
    static func CreateOptional(category: AxcCIFilterCategory) -> Base? {
        guard let filter = CIFilter(name: category.filterName) else { return nil }
        filter.setDefaults()
        return filter as? Base
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: CIFilter { }

// MARK: - 决策判断

public extension AxcSpace where Base: CIFilter { }
