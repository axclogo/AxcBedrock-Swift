//
//  AxcUnifiedImage+CoreImage.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

import CoreImage

// MARK: - CIImage + AxcUnifiedImage

extension CIImage: AxcUnifiedImage { }

public extension AxcSpace where Base: AxcUnifiedImage {
    /// 转换成图片CIImage
    var ciImage: CIImage {
        return CIImage.Axc.Create(base)
    }

    /// 转换成图片CIImage
    var ciImage_optional: CIImage? {
        return CIImage.Axc.CreateOptional(base)
    }
}
