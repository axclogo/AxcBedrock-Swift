//
//  AxcUnifiedImage+AppKit.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/21.
//

#if canImport(AppKit)

import AppKit

// MARK: - NSImage + AxcUnifiedImage

extension NSImage: AxcUnifiedImage { }

public extension AxcSpace where Base: AxcUnifiedImage {
    /// 转换成图片NSImage
    var nsImage: NSImage {
        return NSImage.Axc.Create(base)
    }

    /// 转换成图片NSImage
    var nsImage_optional: NSImage? {
        return NSImage.Axc.CreateOptional(base)
    }
}

#endif
