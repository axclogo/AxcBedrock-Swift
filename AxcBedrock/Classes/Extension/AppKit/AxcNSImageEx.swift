//
//  AxcMSImageEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/21.
//

#if canImport(AppKit)

import AppKit

// MARK: - 数据转换

public extension AxcImageSpace { }

// MARK: - 类方法

public extension AxcImageSpace {
    /// 配合协议用创建方法
    static func Create(_ unifiedValue: AxcUnifiedImage?) -> Base {
        return CreateOptional(unifiedValue) ?? .init()
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedImage?) -> Base? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let string = unifiedValue as? String {
            return Base(named: string)

        } else if let nsString = unifiedValue as? NSString {
            return Base(named: NSImage.Name(nsString.axc.string))

        } else if let baseImage = unifiedValue as? Base {
            return baseImage

        } else if let ciImage = unifiedValue as? CIImage,
                  let cgImage = ciImage.cgImage {
            return Base(cgImage: cgImage, size: .zero)

        } else if let cgImage = AxcFunc.CFType(self, as: CGImage.self) {
            return Base(cgImage: cgImage, size: .zero)
        }
        return nil
    }
}

// MARK: - 属性 & Api

public extension AxcImageSpace {
    /// SwifterSwift:根据纵横比将NSImage缩放到最大尺寸
    /// - Parameter maxSize: 最大尺寸
    /// - Returns: 新图片
    func scale(toMaxSize maxSize: CGSize) -> NSImage {
        let imageWidth = base.size.width
        let imageHeight = base.size.height
        guard imageHeight > 0 else { return base }
        // 获取比例(横向或纵向)
        let ratio: CGFloat
        if imageWidth > imageHeight {
            ratio = maxSize.width / imageWidth
        } else {
            ratio = maxSize.height / imageHeight
        }
        // 根据比率计算新的尺寸
        let newWidth = imageWidth * ratio
        let newHeight = imageHeight * ratio
        // 用新计算的大小创建一个新的NSSize对象
        let newSize = CGSize(width: newWidth.rounded(.down),
                             height: newHeight.rounded(.down))
        // 将NSImage转换为CGImage
        var imageRect = CGRect(origin: .zero, size: base.size)
        guard let imageRef = base.cgImage(forProposedRect: &imageRect,
                                          context: nil,
                                          hints: nil)
        else { return base }
        return NSImage(cgImage: imageRef, size: newSize)
    }
}

// MARK: - [AxcBedrockLib.ImageFileType]

public extension AxcEnum {
    /// 图片文件类型
    enum ImageFileType {
        case tiff
        case bmp
        case gif
        case jpeg(compression: CGFloat = 1.0)
        case png
        case jpeg2000

        /// 转换为NSBitmapImageRep.FileType
        var bitmapImageFileType: NSBitmapImageRep.FileType {
            switch self {
            case .tiff: return .tiff
            case .bmp: return .bmp
            case .gif: return .gif
            case .jpeg: return .jpeg
            case .png: return .png
            case .jpeg2000: return .jpeg2000
            }
        }
    }
}

public extension AxcImageSpace {
    /// 将图片写入地址
    /// - Parameters:
    ///   - url: 所需文件URL.
    ///   - type: 图片类型。默认jpeg
    @discardableResult
    func writeToFile(url fileUrl: AxcUnifiedUrl,
                     fileType: AxcEnum.ImageFileType = .jpeg(compression: 1)) -> Bool {
        guard let data = base.tiffRepresentation,
              let imageRep = NSBitmapImageRep(data: data) else { return false }
        var compressionFactor: NSNumber = 1
        switch fileType {
        case let .jpeg(compression: compression):
            compressionFactor = assertTransformNumber(compression)
        default: break
        }
        guard let imageData = imageRep.representation(using: fileType.bitmapImageFileType,
                                                      properties: [.compressionFactor: compressionFactor])
        else { return false }
        do {
            try imageData.write(to: assertTransformURL(fileUrl))
            return true
        } catch let err {
            AxcBedrockLib.Log(err.localizedDescription, logLevel: .warning)
            return false
        }
    }
}

// MARK: - 决策判断

public extension AxcImageSpace { }

#endif
