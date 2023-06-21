//
//  AxcUnifiedImage+CoreGraphic.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

import CoreGraphics

// MARK: - CGImage + AxcUnifiedImage

extension CGImage: AxcUnifiedImage { }

public extension AxcSpace where Base: AxcUnifiedImage {
    /// 转换成图片CGImage 具有默认值
    var cgImage: CGImage {
        return CGImage.Axc.Create(base)
    }

    /// 转换成图片CGImage 可选
    var cgImage_optional: CGImage? {
        return CGImage.Axc.CreateOptional(base)
    }
}
