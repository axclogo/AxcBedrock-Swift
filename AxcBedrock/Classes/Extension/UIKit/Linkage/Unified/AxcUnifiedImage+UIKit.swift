//
//  AxcUnifiedImage+UIKit.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

#if canImport(UIKit)

import UIKit

// MARK: - UIImage + AxcUnifiedImage

extension UIImage: AxcUnifiedImage { }

public extension AxcSpace where Base: AxcUnifiedImage {
    /// 转换成图片UIImage
    var uiImage: UIImage {
        return UIImage.Axc.Create(base)
    }

    /// 转换成图片UIImage
    var uiImage_optional: UIImage? {
        return UIImage.Axc.CreateOptional(base)
    }
}

#endif
