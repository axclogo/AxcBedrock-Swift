//
//  AxcCGImageEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/3/8.
//

import CoreImage
import CoreGraphics

#if os(macOS)
import AppKit

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit
#endif

// MARK: - [AxcCGImageSpace]

public struct AxcCGImageSpace<Base: CGImage>: AxcAssertUnifiedTransformTarget {
    init(_ base: Base) {
        self.base = base
    }

    var base: Base
}

public extension CGImage {
    /// 命名空间
    var axc: AxcCGImageSpace<CGImage> {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcCGImageSpace<CGImage>.Type {
        return AxcCGImageSpace.self
    }
}

// MARK: - 数据转换

public extension AxcCGImageSpace { }

// MARK: - 类方法

public extension AxcCGImageSpace {
    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedImage?) -> CGImage? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let string = unifiedValue as? String {
            #if os(macOS)
            return string.axc.nsImage.axc.cgImage
            #else
            return string.axc.uiImage.axc.cgImage
            #endif

        } else if let nsString = unifiedValue as? NSString {
            #if os(macOS)
            return nsString.axc.nsImage.axc.cgImage
            #else
            return nsString.axc.uiImage.axc.cgImage
            #endif

        } else if let platformImage = unifiedValue as? AxcBedrockImage {
            #if os(macOS)
            return platformImage.cgImage(forProposedRect: nil, context: nil, hints: nil)
            #else
            return platformImage.cgImage
            #endif

        } else if let cgImage = AxcFunc.CFType(unifiedValue, as: Base.self) {
            return cgImage

        } else if let ciImage = unifiedValue as? CIImage {
            return CIContext().createCGImage(ciImage, from: ciImage.extent)
        }
        return nil
    }

    /// 配合协议用创建方法
    static func Create(_ unifiedValue: AxcUnifiedImage?) -> CGImage {
        #if os(macOS)
        return CreateOptional(unifiedValue) ?? NSImage().cgImage(forProposedRect: nil, context: nil, hints: nil)!
        #else
        return CreateOptional(unifiedValue) ?? UIImage().cgImage!
        #endif
    }

    /// 创建高清位图
    /// - Parameters:
    ///   - ciImage: ciImage
    ///   - size: 大小
    /// - Returns: 位图
    static func CreateHD(with ciImage: CIImage, size: CGSize) -> CGImage? {
        let context = CIContext(options: nil)
        let extent = ciImage.extent
        let bitmapImage = context.createCGImage(ciImage, from: extent)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height),
                                      bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace,
                                      bitmapInfo: CGImageAlphaInfo.none.rawValue)
        let scale = min(size.width / extent.width, size.height / extent.height)
        bitmapContext!.interpolationQuality = CGInterpolationQuality.none
        bitmapContext?.scaleBy(x: scale, y: scale)
        bitmapContext?.draw(bitmapImage!, in: extent)
        guard let scaledImage = bitmapContext?.makeImage() else { return nil }
        return scaledImage
    }
}

// MARK: - 属性 & Api

public extension AxcCGImageSpace {
    /// 图片旋转 0 - 320
    /// - Parameter angle: 0 - 320
    func setRotate(angle: CGFloat) -> CGImage? {
        return setRotate(radians: angle.axc.angleToRadian)
    }

    /// 图片旋转 0 - 2.pi
    /// - Parameter radians: 0 - 2.pi
    func setRotate(radians: CGFloat) -> CGImage? {
        let ciImage = CIImage(cgImage: base)
        return ciImage.axc.setRotate(radians: radians).cgImage
    }

    /// 图片裁剪
    /// - Parameter rect: 裁剪范围单位为图片像素
    /// - Returns: 裁剪后的
    func setCropping(rect: CGRect) -> CGImage? {
        return base.cropping(to: rect)
    }
}

// MARK: - 决策判断

public extension AxcCGImageSpace { }
