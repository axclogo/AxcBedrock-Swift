//
//  AxcUIImageEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2021/12/16.
//

#if canImport(UIKit)

import UIKit

fileprivate extension AxcLazyCache.TableKey {
    /// 图片缓存表，启用缓存
    static let uiImageTable = AxcLazyCache.Table("uiImage_table", enableCache: true)
}


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
            return .init(named: string)

        } else if let nsString = unifiedValue as? NSString {
            return .init(named: nsString.axc.string)

        } else if let baseImage = unifiedValue as? Base {
            return baseImage

        } else if let ciImage = unifiedValue as? CIImage {
            return .init(ciImage: ciImage)

        } else if let cgImage = AxcFunc.CFType(self, as: CGImage.self) {
            return .init(cgImage: cgImage)
        }
        return nil
    }

    /// 获取app图标
    static var AppIcon: Base? {
        // 包一层缓存，节约性能
        let cacheKey = "AppIcon"
        if let cacheAppIcon: Base = AxcLazyCache.MemoryCacheRead(table: .uiImageTable, key: cacheKey) {
            return cacheAppIcon
        } else {
            guard let infoDic = Bundle.main.infoDictionary,
                  let CFBundleIcons = infoDic["CFBundleIcons"] as? [String: Any],
                  let CFBundlePrimaryIcon = CFBundleIcons["CFBundlePrimaryIcon"] as? [String: Any],
                  let iconsArr = CFBundlePrimaryIcon["CFBundleIconFiles"] as? [Any],
                  let lastIconName = iconsArr.last as? String else { return nil }
            if let appIcon: Base = .init(named: lastIconName) {
                AxcLazyCache.MemoryCacheWrite(table: .uiImageTable, key: cacheKey, value: appIcon)
                return appIcon
            }
            return nil
        }
    }
}

// MARK: - 属性 & Api

public extension AxcImageSpace {
    /// 获取宽度
    var width: CGFloat {
        return base.size.width
    }

    /// 获取高度
    var height: CGFloat {
        return base.size.height
    }

    /// 使用.alwaysOriginal模式渲染
    func setOriginalMode() -> Base? {
        return base.withRenderingMode(.alwaysOriginal) as? Base
    }

    /// 使用.alwaysTemplate模式渲染
    func setTemplateMode() -> Base? {
        return base.withRenderingMode(.alwaysTemplate) as? Base
    }

    /// 压缩比值
    func set(compressed: CGFloat) -> Base? {
        guard let data = base.jpegData(compressionQuality: compressed) else { return nil }
        return UIImage(data: data) as? Base
    }

    /// 图片缩放绘制
    func setScale(ratio: CGFloat,
                  opaque: Bool = false) -> Base? {
        let newWidth = width * ratio
        let newHeight = height * ratio
        return setScale(size: CGSize(width: newWidth, height: newHeight), opaque: opaque)
    }

    /// 图片大小改变绘制
    func setScale(size: CGSize,
                  opaque: Bool = false) -> Base? {
        UIGraphicsBeginImageContextWithOptions(size, opaque, base.scale)
        base.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage as? Base
    }

    /// 图像重绘
    /// 这里是利用了UIImage中的drawInRect方法，它会将图像绘制到画布上，并且已经考虑好了图像的方向
    var normalized: Base? {
        return setScale(size: base.size)
    }

    /// 图片裁剪
    /// - Parameter edge: 边缘距离单位为图片像素
    /// - Returns: 裁剪后的图
    func setCropping(edge: UIEdgeInsets) -> Base? {
        let rect = CGRect(x: edge.left, y: edge.top,
                          width: base.size.width - edge.axc.horizontal,
                          height: base.size.height - edge.axc.vertical)
        return setCropping(rect: rect)
    }

    /// 图片裁剪
    /// - Parameter rect: 裁剪范围单位为图片像素
    /// - Returns: 裁剪后的
    func setCropping(rect: CGRect) -> Base? {
        guard let cgImage = base.cgImage?.axc.setCropping(rect: rect) else { return nil }
        return Base(cgImage: cgImage)
    }

    /// 图片切圆角，默认以最小宽高
    func set(cornerRadius: AxcUnifiedNumber) -> Base? {
        let radius = assertTransformCGFloat(cornerRadius)
        guard radius != 0 else { return base } // 无需旋转
        // 启动缓存
        let data = AxcLazyCache.DiskCache(table: .uiImageTable, fileName: base.hashValue.axc.string) {
            let maxRadius = base.size.axc.smaller / 2 // 取宽高中一个最小的
            let cornerRadius: CGFloat
            if radius > 0, radius <= maxRadius {
                cornerRadius = radius
            } else {
                cornerRadius = maxRadius
            }
            UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
            let rect = CGRect(origin: .zero, size: base.size)
            UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
            base.draw(in: rect)
            let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            if let data = image?.axc.pngData {
                return data
            } else {
                AxcBedrockLib.FatalLog("图片处理错误！")
            }
        }
        return data.axc.uiImage as? Base
    }

    /// 方形图
    func squared() -> UIImage? {
        let originalWidth = base.size.width
        let originalHeight = base.size.height
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        var edge: CGFloat = 0.0
        if (originalWidth > originalHeight) {
            // landscape
            edge = originalHeight
            x = (originalWidth - edge) / 2.0
            y = 0.0
        } else if (originalHeight > originalWidth) {
            // portrait
            edge = originalWidth
            x = 0.0
            y = (originalHeight - originalWidth) / 2.0
        } else {
            // square
            edge = originalWidth
        }
        let cropSquare = CGRect(x: x, y: y, width: edge, height: edge)
        guard let imageRef = base.cgImage?.cropping(to: cropSquare) else { return nil }
        return UIImage(cgImage: imageRef, scale: base.scale, orientation: base.imageOrientation)
    }

    /// 调整大小
    /// - Parameter maxSize: 最大大小
    /// - Returns: 结果
    func setResized(maxSize: CGFloat) -> UIImage? {
        let scale: CGFloat
        if base.size.width > base.size.height {
            scale = maxSize / base.size.width
        } else {
            scale = maxSize / base.size.height
        }

        let newWidth = base.size.width * scale
        let newHeight = base.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        base.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

// MARK: - 保存

public extension AxcEnum {
    /// 存储类型
    enum StorageType {
        /// 保存到沙盒路径
        case sandbox(path: String,
                     fileName: String,
                     type: AxcEnum.ImageDataType,
                     errorBlock: AxcBlock.OneParam<Error>? = nil)
        /// 保存到系统相册
        case photosAlbum(block: AxcBlock.SavedPhotosAlbumBlock)
    }
}

public extension AxcImageSpace {
    /// 图片保存到
    /// - Parameter storageType: 存储位置
    func save(to storageType: AxcEnum.StorageType) {
        switch storageType {
        case let .sandbox(path: path, fileName: fileName, type: type, errorBlock: errorBlock):
            var suffix: String = ""
            switch type {
            case .png: suffix = "png"
            case .jpeg: suffix = "jpeg"
            }
            var filePath = path.axc.appendSuffix(string: "/")
            filePath = filePath.appending("\(fileName).\(suffix)")
            let imageData = base.axc.data(type: type) // 创建Data数据
            do { // 将图片写入文件
                try imageData?.write(to: URL(fileURLWithPath: filePath), options: .atomic)
            } catch let err {
                errorBlock?(err)
            }
            
        case let .photosAlbum(block: block):
            _selectorImage.savedPhotosAlbumBlock = block
            UIImageWriteToSavedPhotosAlbum(base,
                                           _selectorImage,
                                           #selector(_selectorImage.image(_:didFinishSavingWithError:contextInfo:)),
                                           nil)
        }
    }
}

fileprivate var k_selectorImage = "k_fileprivate.AxcBedrock.selectorImage"

extension AxcImageSpace {
    /// 方法选择器转Block对象
    var _selectorImage: AxcSelector.Image {
        guard let selectorImage: AxcSelector.Image = AxcRuntime.GetObject(self, key: &k_selectorImage) else {
            let selectorImage = AxcSelector.Image()
            AxcRuntime.Set(object: self, key: &k_selectorImage, value: selectorImage)
            return selectorImage
        }
        return selectorImage
    }
}

// MARK: - 裁切样式

public extension AxcImageSpace {
    /// 正方形裁剪模式
    enum SquareMode {
        /// 图片中心做正方形裁切
        case center
    }

    /// 设置正方形裁剪模式
    /// - Parameter contentMode: 模式
    /// - Returns: 新图
    /// !!!: 还需要扩展枚举
    func set(squareMode: SquareMode) -> Base? {
        var offsetX: CGFloat = 0
        var offsetY: CGFloat = 0
        let imgSize: CGSize = .init(width: base.size.width * base.scale, height: base.size.height * base.scale)
        var drawSize: CGSize = .zero
        switch squareMode {
        case .center:
            var sideLength: CGFloat = 0
            if imgSize.width > imgSize.height { // 横长图
                sideLength = imgSize.height
                offsetX = (imgSize.width - imgSize.height) / 2.0
            } else if imgSize.width < imgSize.height { // 竖长图
                sideLength = imgSize.width
                offsetY = (imgSize.height - imgSize.width) / 2.0
            } else { // 本来就是正方形
                return base
            }
            drawSize = CGSize.Axc.Create(sideLength)
            /// 裁剪新图片
            let standardRect = CGRect(origin: CGPoint(x: offsetX, y: offsetY), size: drawSize)
            guard let newCGImage = base.cgImage?.cropping(to: standardRect) else { return nil }
            let newImage = Base(cgImage: newCGImage)
            return newImage
        }
    }
}

// MARK: - 旋转

public extension AxcImageSpace {
    /// 图片旋转 0 - 360
    func setRotate(angle: CGFloat) -> Base? {
        return setRotate(radians: angle.axc.angleToRadian)
    }

    /// 图片旋转 0 - 2.pi
    func setRotate(radians: CGFloat) -> Base? {
        guard radians != 0 else { return base } // 无需旋转
        guard let cgImage = base.cgImage else { return nil }
        let upImage = UIImage(cgImage: cgImage) // 清除旋转信息

        var newSize = CGRect(origin: CGPoint.zero, size: upImage.size)
            .applying(CGAffineTransform(rotationAngle: radians)).size

        newSize.width = Darwin.floor(newSize.width)
        newSize.height = Darwin.floor(newSize.height)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        let image = renderer.image { rendederContext in

            let context = rendederContext.cgContext

            context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
            context.rotate(by: radians)
            let drawRect = CGRect(origin: CGPoint(x: -upImage.size.width / 2, y: -upImage.size.height / 2), size: upImage.size)
            upImage.draw(in: drawRect)
        }

        return image as? Base
    }
}

// MARK: - 决策判断

public extension AxcImageSpace { }

#endif
