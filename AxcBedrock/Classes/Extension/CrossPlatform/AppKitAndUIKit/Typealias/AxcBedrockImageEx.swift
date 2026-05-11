//
//  AxcBedrock.swift
//  AxcBedrock
//
//  Created by 赵新 on 2022/2/11.
//

#if os(macOS)
import AppKit

/// （💈跨平台标识）图片类型
public typealias AxcBedrockImage = NSImage

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit

/// （💈跨平台标识）图片类型
public typealias AxcBedrockImage = UIImage
#endif

// MARK: - [AxcImageSpace]

public class AxcImageSpace<Base: AxcBedrockImage>: AxcAssertUnifiedTransformTarget {
    init(_ base: Base) {
        self.base = base
    }

    var base: Base
}

public extension AxcBedrockImage {
    /// 命名空间
    var axc: AxcImageSpace<AxcBedrockImage> {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcImageSpace<AxcBedrockImage>.Type {
        return AxcImageSpace.self
    }
}

// MARK: - [AxcEnum.ImageDataType]

public extension AxcEnum {
    /// （💈跨平台标识）数据类型
    enum ImageDataType: CaseIterable {
        case png
        case jpeg
    }
}

// MARK: - 数据转换

public extension AxcImageSpace {
    /// （💈跨平台标识）将这个图片转换成PNG的base64字符
    var base64StrPNG: String? {
        return pngData?.base64EncodedString()
    }

    /// （💈跨平台标识）将这个图片转换成JPEG的base64字符
    func base64StrJPEG(compressed: CGFloat) -> String? {
        return jpegData(compressed: compressed)?.base64EncodedString()
    }
}

// MARK: - Data转换

public extension AxcImageSpace {
    /// （💈跨平台标识）获取数据
    /// - Parameter type: 数据类型
    /// - Returns: Data数据
    func data(type: AxcEnum.ImageDataType) -> Data? {
        switch type {
        case .png: return pngData
        case .jpeg: return jpegData
        }
    }

    /// （💈跨平台标识）转成Data
    var pngData: Data? {
        #if os(macOS)
        let pngData = bitmapImageRep?.representation(using: .png,
                                                     properties: [:])
        return pngData

        #elseif os(iOS) || os(tvOS) || os(watchOS)

        return base.pngData()
        #endif
    }

    /// （💈跨平台标识）压缩这个image生成data
    /// 如果图像没有CGImageRef或无效的位图格式，可能返回nil
    var jpegData: Data? {
        return jpegData()
    }

    /// （💈跨平台标识）压缩这个image生成data
    /// 如果图像没有CGImageRef或无效的位图格式，可能返回nil
    func jpegData(compressed: CGFloat = 1) -> Data? {
        #if os(macOS)
        let properties: [NSBitmapImageRep.PropertyKey: Any] = [
            NSBitmapImageRep.PropertyKey.compressionFactor: (compressed),
        ]
        let jpegData = bitmapImageRep?.representation(using: .jpeg,
                                                      properties: properties)
        return jpegData

        #elseif os(iOS) || os(tvOS) || os(watchOS)

        return base.jpegData(compressionQuality: compressed)
        #endif
    }

    #if os(macOS)
    /// 转换成位图
    /// - Parameters:
    ///   - compression: 压缩模式
    ///   - factor: 因子
    /// - Returns: 位图数据
    var bitmapImageRep: NSBitmapImageRep? {
        guard let data = base.tiffRepresentation else { return nil }
        let imageRep = NSBitmapImageRep(data: data)
        return imageRep
    }

    /// 转换成位图
    /// - Parameters:
    ///   - compression: 压缩模式
    ///   - factor: 因子
    /// - Returns: 位图数据
    func bitmapImageRep(using compression: NSBitmapImageRep.TIFFCompression,
                        factor: CGFloat) -> NSBitmapImageRep? {
        guard let data = base.tiffRepresentation(using: compression, factor: Float(factor)) else { return nil }
        let imageRep = NSBitmapImageRep(data: data)
        return imageRep
    }
    #endif
}

// MARK: - 富文本

public extension AxcImageSpace {
    /// 转换成富文本的附件对象
    var textAttachment: NSTextAttachment {
        return textAttachment()
    }

    /// 转换成富文本的附件对象
    func textAttachment(_ type: String? = nil) -> NSTextAttachment {
        let attachment = NSTextAttachment()
        attachment.image = base
        return attachment
    }
}

// MARK: - 类方法

public extension AxcImageSpace {
    /// （💈跨平台标识）创建图片
    /// - Parameters:
    ///   - name: 图片名
    ///   - bundle: 资源
    /// - Returns: 图片对象
    static func Create(name: String,
                       in bundle: Bundle?) -> Base? {
        #if os(macOS)
        guard let bundle = bundle else {
            return Base(named: name)
        }
        guard let image = bundle.image(forResource: name) else { return nil }
        image.setName(name)
        return image as? Base

        #elseif os(iOS) || os(tvOS) || os(watchOS)

        return Base(named: name, in: bundle, compatibleWith: nil)
        #endif
    }
}

// MARK: - 属性 & Api

public extension AxcImageSpace {
    /// （💈跨平台标识）设置渲染颜色
    func set(tintColor: AxcBedrockColor) -> Base? {
        return set(tintUnifiedColor: tintColor)
    }

    /// （💈跨平台标识）设置渲染颜色
    func set(tintUnifiedColor: AxcUnifiedColor) -> Base? {
        #if os(macOS)
        let imageSize = base.size
        let tintColor = assertTransformColor(tintUnifiedColor)
        /// 使用CGContext绘制图像
        base.lockFocus()
        guard let context = NSGraphicsContext.current?.cgContext else { return nil }
        context.setFillColor(tintColor.cgColor)
        /// 获取图像的mask(alpha通道)
        let rect = CGRect(origin: .zero, size: imageSize)
        guard let mask = base.representations.first as? NSBitmapImageRep,
              let cgImage = mask.converting(to: .deviceRGB,
                                            renderingIntent: .default)?.cgImage
        else { return nil }
        context.clip(to: rect, mask: cgImage)
        context.fill(CGRect(origin: .zero, size: imageSize))

        base.unlockFocus()
        return base

        #elseif os(iOS) || os(tvOS) || os(watchOS)

        UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.translateBy(x: 0, y: base.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        let rect = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height) as CGRect
        guard let cgimg = base.cgImage else { return nil }
        context.clip(to: rect, mask: cgimg)
        assertTransformColor(tintUnifiedColor).setFill()
        context.fill(rect)
        guard let currentContext = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        let newImage = currentContext as UIImage
        UIGraphicsEndImageContext()
        return newImage as? Base

        #endif
    }
}

// MARK: - 决策判断

public extension AxcImageSpace { }
