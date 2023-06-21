//
//  AxcCTLineEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/15.
//

import CoreText

// MARK: - CTLine + AxcSpaceProtocol

extension CTLine: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base: CTLine { }

// MARK: - 类方法

public extension AxcSpace where Base: CTLine { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: CTLine {
    /// 获取当前行的Bounds
    var useOpticalBounds: CGRect {
        return CTLineGetBoundsWithOptions(base, CTLineBoundsOptions.useOpticalBounds)
    }

    /// 获取当前行的高度
    var height: CGFloat {
        return useOpticalBounds.size.height
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: CTLine { }
