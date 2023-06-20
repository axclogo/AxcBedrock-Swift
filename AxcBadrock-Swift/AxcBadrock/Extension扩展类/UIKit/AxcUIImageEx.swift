//
//  AxcUIImageEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit

// MARK: - 数据转换
public extension UIImage {
    /// 将这个图片转换成PNG的base64字符
    var axc_base64StrPNG: String? {
        return axc_pngData?.base64EncodedString()
    }
    /// 将这个图片转换成JPEG的base64字符
    func axc_base64StrJPEG(compressed: CGFloat) -> String? {
        return axc_jpegData(compressed: compressed)?.base64EncodedString()
    }
    
    /// 数据类型
    enum AxcDataType {
        case png, jpeg
    }
    
    /// 获取数据
    /// - Parameter type: 数据类型
    /// - Returns: Data数据
    func axc_data(_ type: AxcDataType) -> Data? {
        switch type {
        case .png: return axc_pngData
        case .jpeg: return axc_jpegData
        }
    }
    /// 转成Data
    var axc_pngData: Data? {
        return self.pngData()
    }
    /// 压缩这个image生成data
    var axc_jpegData: Data? {
        return self.axc_jpegData()
    }
    /// 压缩这个image生成data
    func axc_jpegData(compressed: CGFloat = 1) -> Data? {
        return self.jpegData(compressionQuality: compressed)
    }
    
    /// 转换成富文本的附件对象
    var axc_textAttachment: NSTextAttachment {
        return axc_textAttachment()
    }
    /// 转换成富文本的附件对象
    func axc_textAttachment(_ type: String? = nil) -> NSTextAttachment {
        let attachment = NSTextAttachment()
        attachment.image = self
        return attachment
    }
}

// MARK: - 类方法/属性
public extension UIImage {
    /// 通过字符串实例化
    /// - Parameter name: 图片名称
    convenience init?(_ name: String) {
        self.init(named: name)
        setImageName(name) // 保存图片名称
    }
    
    /// 通过颜色生成Image
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 大小 默认最小
    /// - Returns: UIImage
    convenience init?(_ color: AxcUnifiedColorTarget, size: CGSize = CGSize.axc_minSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        defer { UIGraphicsEndImageContext() }
        color.axc_color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil}
        self.init(cgImage: aCgImage)
    }
    
    /// 通过base64Str生成图片
    /// - Parameters:
    ///   - base64Str: base64Str
    ///   - scale:  比例缩放
    convenience init?(base64Str: String, scale: CGFloat = 1.0) {
        guard let data = Data(base64Encoded: base64Str) else { return nil }
        self.init(data: data, scale: scale)
    }
    
    /// 获取AppIcon
    static var axc_appIcon: UIImage? {
        guard let CFBundleIcons = Axc_infoDictionary!["CFBundleIcons"] as? [String:Any] else { return nil }
        guard let CFBundlePrimaryIcon = CFBundleIcons["CFBundlePrimaryIcon"] as? [String:Any] else { return nil }
        guard let CFBundleIconFiles = CFBundlePrimaryIcon["CFBundleIconFiles"] as? [Any] else { return nil }
        guard let imageName = CFBundleIconFiles.last as? String else { return nil }
        return UIImage(named: imageName)
    }
}

// MARK: - 属性 & Api
public extension UIImage {
    /// 获取宽度
    var axc_width: CGFloat {
        return size.width
    }
    /// 获取高度
    var axc_height: CGFloat {
        return size.height
    }
    /// 获取中心
    var axc_center: CGPoint {
        return CGPoint(x: axc_width/2, y: axc_height/2)
    }
    /// 上左
    var axc_topLeft: CGPoint {
        return CGPoint.zero
    }
    /// 上右
    var axc_topRight: CGPoint {
        return CGPoint(x: size.width, y: 0)
    }
    /// 下左
    var axc_bottomLeft: CGPoint {
        return CGPoint(x: 0, y: size.height)
    }
    /// 下右
    var axc_bottomRight: CGPoint {
        return CGPoint(x: size.width, y: size.height)
    }
    
    
    /// 保存到系统相册，需要权限访问
    @discardableResult
    func axc_saveAlbum(target: Any? = nil, selector: Selector? = nil) -> UIImage {
        UIImageWriteToSavedPhotosAlbum(self, target, selector, nil)
        return self
    }
    
    /// 获取图片某一点的颜色
    func axc_pointColor(_ point: CGPoint) -> UIColor? {
        guard CGRect(origin: CGPoint(x: 0, y: 0), size: size).contains(point) else { return nil }
        let pointX = trunc(point.x);
        let pointY = trunc(point.y);
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        var pixelData: [UInt8] = [0, 0, 0, 0]
        pixelData.withUnsafeMutableBytes { pointer in
            if let context = CGContext(data: pointer.baseAddress, width: 1, height: 1,
                                       bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace,
                                       bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue),
               let cgImage = cgImage {
                context.setBlendMode(.copy)
                context.translateBy(x: -pointX, y: pointY - size.height)
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            }
        }
        return UIColor(CGFloat(pixelData[0]),CGFloat(pixelData[1]), CGFloat(pixelData[2]),a: CGFloat(pixelData[3]))
    }
    
    /// 设置渲染颜色
    func axc_setTintColor(_ color: AxcUnifiedColorTarget) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(.normal)
        let rect = CGRect(x:0, y:0, width: axc_width, height: axc_height) as CGRect
        guard let cgimg = axc_cgImage else { return nil }
        context.clip(to: rect, mask: cgimg)
        color.axc_color.setFill()
        context.fill(rect)
        guard let currentContext = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        let newImage = currentContext as UIImage
        UIGraphicsEndImageContext()
        return newImage
    }
}

// MARK: - 元数据读写
public extension UIImage {
//    var axc_pngExif: [String: Any]? {
//        let metaData = axc_metaData(.png)
//        
//    }
    
    func axc_setExif(_ type: AxcDataType = .png) -> UIImage? {
        let options = [kCGImageSourceShouldCache : kCFBooleanTrue]
        guard let cfData = axc_data(type),
              let imgSrc = CGImageSourceCreateWithData(cfData.axc_cfData, options.axc_cfDic)
        else { return nil }
        let source = CGImageSourceCopyPropertiesAtIndex(imgSrc, 0, options.axc_cfDic)
        let metadata = CFDictionaryCreateMutableCopy(nil, 0, source).axc_nsMutableDic
        
        guard let exifdata = metadata.value(forKey: kCGImagePropertyExifDictionary.axc_string)
                as? NSMutableDictionary
        else { return nil }
        // 设置key的时候只能设置kCGImagePropertyExif-list里的，不能自定义
        exifdata.setValue("yaw:axc, pitch:123, roll:asd",
                          forKey: kCGImagePropertyExifUserComment.axc_string)
        metadata.setValue(exifdata, forKey: kCGImagePropertyExifDictionary.axc_string)
        
        guard let uniformType = CGImageSourceGetType(imgSrc) else { return nil }
        let finalData = NSMutableData()
        // destination可以理解为操作image的对象，往finalData里加入数据
        guard let destination = CGImageDestinationCreateWithData((finalData.axc_cfMutableData),
                                                                 uniformType, 1, nil)
        else { return nil}
        CGImageDestinationAddImageFromSource(destination, imgSrc, 0, metadata)
        guard CGImageDestinationFinalize(destination), finalData.count > 0 else { return nil }
        let newImgData = finalData.axc_data
        return newImgData.axc_image
    }
    
    /// 获取媒体数据, 默认png
    var axc_metaData: [String:Any]? {
        return axc_metaData()
    }
    /// 获取媒体数据
    /// - Parameter type: 数据类型 默认png
    /// - Returns: CGImageMetadata
    func axc_metaData(_ type: AxcDataType = .png) -> [String:Any]? {
        let options = [kCGImageSourceShouldCache : kCFBooleanTrue]
        guard let cfData = axc_data(type),
              let imgSrc = CGImageSourceCreateWithData(cfData.axc_cfData, options.axc_cfDic)
        else { return nil }
        let source = CGImageSourceCopyPropertiesAtIndex(imgSrc, 0, options.axc_cfDic)
        let metadata = CFDictionaryCreateMutableCopy(nil, 0, source).axc_nsMutableDic
        var meta = [String:Any]()
        metadata.enumerateKeysAndObjects { (key, value, _) in
            if let newKey = key as? String {
                meta[newKey] = value
            }
        }
        return meta
    }
    //    struct AxcImageExif: Dictionary<Key, Value> {
    //    }
}

// MARK: - 图像处理
public extension UIImage {
    /// 使用.alwaysOriginal模式渲染
    var axc_setOriginalMode: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    
    /// 使用.alwaysTemplate模式渲染
    var axc_setTemplateMode: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
    
    /// 压缩比值，默认0.5压缩
    func axc_setCompressed(_ ratio: CGFloat = 0.5) -> UIImage? {
        guard let data = jpegData(compressionQuality: ratio) else { return nil }
        return UIImage(data: data)
    }
    
    /// 图片缩放绘制
    func axc_setScale(scale: CGFloat, opaque: Bool = false) -> UIImage? {
        let newWidth = size.width * scale
        let newHeight = size.height * scale
        return axc_setScale(size: CGSize(width: newWidth, height: newHeight), opaque: opaque)
    }
    /// 图片大小改变绘制
    func axc_setScale(size: CGSize, opaque: Bool = false) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, opaque, self.scale)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 图片旋转，选择一个方向
    /// - Parameter direction: 方向
    func axc_setRotate(direction: AxcDirection ) -> UIImage? {
        var angle = 0
        switch direction {
        case .top:      angle = 180
        case .left:     angle = 90
        case .right:    angle = -90
        default:        angle = 0 }
        return axc_setRotate(angle: CGFloat(angle))
    }
    
    /// 图片旋转 0 - 320
    func axc_setRotate(angle: CGFloat) -> UIImage? {
        return axc_setRotate(radians: angle.axc_angleToRadian)
    }
    
    /// 图片旋转 0 - 2.pi
    func axc_setRotate(radians: CGFloat) -> UIImage? {
        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())
        UIGraphicsBeginImageContextWithOptions(roundedDestRect.size, false, scale)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }
        contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        contextRef.rotate(by: radians)
        draw(in: CGRect(origin: CGPoint(x: -size.width / 2, y: -size.height / 2),size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 图片切圆角，默认以最小宽高
    func axc_setCornerRadius(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = size.axc_smaller / 2   // 取宽高中一个最小的
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0, radius <= maxRadius {
            cornerRadius = radius
        } else { cornerRadius = maxRadius }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    /// 选择横向拉伸
    /// - Parameters:
    ///   - width: width
    ///   - isCenter: 是否从中间拉伸，如果为true，则优先从中间拉伸
    /// - Returns: UIImage
    func axc_setTensileHorizontal(_ width: CGFloat? = nil, isCenter: Bool = false) -> UIImage? {
        var w: CGFloat = 0
        if width != nil { w = width! }
        if isCenter { w =  size.width / 2 }
        if w == 0 { return nil }
        return axc_setTensile(point: CGPoint(x: w, y: 0))
    }
    
    /// 选择纵向拉伸
    /// - Parameters:
    ///   - height: height
    ///   - isCenter: 是否从中间拉伸，如果为true，则优先从中间拉伸
    /// - Returns: UIImage
    func axc_setTensileVertical(_ height: CGFloat? = nil, isCenter: Bool = false) -> UIImage? {
        var h: CGFloat = 0
        if height != nil { h = height! }
        if isCenter { h =  size.height / 2 }
        if h == 0 { return nil }
        return axc_setTensile(point: CGPoint(x: 0, y: h))
    }
    
    /// 选择点位进行拉伸
    /// - Parameters:
    ///   - point: point
    ///   - isCenter: 是否从中间拉伸，如果为true，则优先从中间拉伸
    /// - Returns: UIImage
    func axc_setTensile(point: CGPoint? = nil, isCenter: Bool = false) -> UIImage? {
        var p = CGPoint.zero;
        if point != nil { p = point! }
        if isCenter { p = CGPoint(x: size.width / 2, y: size.height / 2) }
        if p.axc_isZero { return nil }
        return stretchableImage(withLeftCapWidth: Int(p.x), topCapHeight: Int(p.y))
    }
    
    /// 镜像翻转
    /// - Parameter axle: 沿轴向量 仅支持纵横翻转
    /// - Returns: UIImage
    func axc_setMirror(_ axle: AxcAxleVector) -> UIImage? {
        guard let _cgImage = cgImage else { return nil }
        var orientation: Orientation = .downMirrored
        if axle == .vertical { orientation = .upMirrored }
        return UIImage(cgImage: _cgImage, scale: scale, orientation: orientation)
    }
    
    /// 图片裁剪
    /// - Parameter rect: 裁剪范围单位为图片像素
    /// - Returns: 裁剪后的
    func axc_cropping(_ rect: CGRect) -> UIImage? {
        guard let cgImage = axc_cgImage?.axc_cropping(rect) else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    /// 图片裁剪
    /// - Parameter edge: 边缘距离单位为图片像素
    /// - Returns: 裁剪后的图
    func axc_cropping(_ edge: UIEdgeInsets) -> UIImage? {
        let rect = CGRect(x: edge.left, y: edge.top,
                          width: axc_width - edge.axc_horizontal,
                          height: axc_height - edge.axc_verticality)
        return axc_cropping(rect)
    }
}

// MARK: - 图像滤镜
/// 滤镜方法扩展
public extension UIImage {
    /// 添加滤镜
    func axc_setFilter(_ filter: AxcBaseFilter ) -> UIImage? {
        return filter.axc_uiImage
    }
    
    /// 渲染一个模糊类型的滤镜
    var axc_blurStyleFilter: AxcBlurStyleFilter {
        return AxcBlurStyleFilter(image: self)
    }
    /// 渲染一个锐化类型的滤镜
    var axc_sharpenStyleFilter: AxcSharpenStyleFilter {
        return AxcSharpenStyleFilter(image: self)
    }
    /// 渲染一个风格化类型的滤镜
    var axc_stylizeStyleFilter: AxcStylizeStyleFilter {
        return AxcStylizeStyleFilter(image: self)
    }
    /// 渲染一个风梯度类型的滤镜
    var axc_gradientStyleFilter: AxcGradientStyleFilter {
        return AxcGradientStyleFilter(image: self)
    }
    /// 渲染一个递减类型的滤镜
    var axc_reductionStyleFilter: AxcReductionStyleFilter {
        return AxcReductionStyleFilter(image: self)
    }
    /// 渲染一个生成器类型的滤镜
    var axc_generatorStyleFilter: AxcGeneratorStyleFilter {
        return AxcGeneratorStyleFilter(image: self)
    }
    /// 渲染一个平铺瓷砖类型的滤镜
    var axc_tileEffectStyleFilter: AxcTileEffectStyleFilter {
        return AxcTileEffectStyleFilter(image: self)
    }
}

// MARK: - 扩展属性
private var kaxc_imageName = "kaxc_imageName"
public extension UIImage {
    /// 只有通过使用
    /// axc_image、UIImage("")
    /// 实例化的图片才能获取图片名称
    var axc_imageName: String? {
        guard let imageName: String = AxcRuntime.getObj(self, &kaxc_imageName)
        else { return nil }
        return imageName
    }
    // 私有，设置图片名称
    fileprivate func setImageName(_ name: String) {
        AxcRuntime.setObj(self, &kaxc_imageName, name)
    }
}

// MARK: - 运算符
public extension UIImage {
    /// 添加滤镜
    /// - Parameters:
    ///   - leftValue: UIImage
    ///   - rightValue: AxcBaseFilter
    /// - Returns: 添加滤镜后的图片
    static func + (leftValue: UIImage, rightValue: AxcBaseFilter) -> UIImage? {
        return leftValue.axc_setFilter(rightValue)
    }
}
