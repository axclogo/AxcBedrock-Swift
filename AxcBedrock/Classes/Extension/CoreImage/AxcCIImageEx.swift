//
//  AxcCIImageEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/12.
//

import CoreImage

// MARK: - [AxcCIImageSpace]

public struct AxcCIImageSpace<Base: CIImage>: AxcAssertUnifiedTransformTarget {
    init(_ base: Base) {
        self.base = base
    }

    var base: Base
}

public extension CIImage {
    /// 命名空间
    var axc: AxcCIImageSpace<CIImage> {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcCIImageSpace<CIImage>.Type {
        return AxcCIImageSpace.self
    }
}

// MARK: - 数据转换

public extension AxcCIImageSpace { }

// MARK: - 类方法

public extension AxcCIImageSpace {
    /// 配合协议用创建方法
    static func Create(_ unifiedValue: AxcUnifiedImage?) -> CIImage {
        return CreateOptional(unifiedValue) ?? CIImage()
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedImage?) -> CIImage? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let string = unifiedValue as? String {
            #if os(macOS)
            return string.axc.nsImage.axc.ciImage
            #elseif os(iOS)
            return string.axc.uiImage.axc.ciImage
            #endif

        } else if let nsString = unifiedValue as? NSString {
            #if os(macOS)
            return nsString.axc.nsImage.axc.ciImage
            #elseif os(iOS)
            return nsString.axc.uiImage.axc.ciImage
            #endif

        } else if let platformImage = unifiedValue as? AxcBedrockImage {
            #if os(macOS)
            let cgImage = platformImage.cgImage(forProposedRect: nil, context: nil, hints: nil)
            return CIImage(cgImage: cgImage!)
            #elseif os(iOS)
            return CIImage(cgImage: platformImage.cgImage!)
            #endif

        } else if let cgImage = AxcFunc.CFType(unifiedValue, as: CGImage.self) {
            return CIImage(cgImage: cgImage)

        } else if let ciImage = unifiedValue as? CIImage {
            return ciImage
        }
        return nil
    }
}

// MARK: - 属性 & Api

public extension AxcCIImageSpace {
    /// 图片旋转 0 - 320
    /// - Parameter angle: 0 - 320
    func setRotate(angle: CGFloat) -> CIImage {
        return setRotate(radians: angle.axc.angleToRadian)
    }

    /// 图片旋转 0 - 2.pi
    /// - Parameter radians: 0 - 2.pi
    func setRotate(radians: CGFloat) -> CIImage {
        return base.transformed(by: CGAffineTransform(rotationAngle: radians))
    }

    /// 图片裁剪
    /// - Parameter rect: 裁剪范围单位为图片像素
    /// - Returns: 裁剪后的
    func setCropping(rect: CGRect) -> CIImage? {
        return base.cropped(to: rect)
    }
}

// MARK: - 决策判断

public extension AxcCIImageSpace { }
