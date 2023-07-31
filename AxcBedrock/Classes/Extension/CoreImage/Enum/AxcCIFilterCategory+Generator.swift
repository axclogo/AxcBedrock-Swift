//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

// MARK: - [AxcCIFilterCategory.Generator]

public extension AxcCIFilterCategory {
    /// 生成器
    enum Generator: String {
        /// 属性文本图片生成器
        case attributedTextImageGenerator
        /// Aztec代码生成器
        case aztecCodeGenerator
        /// 条形码生成器
        case barcodeGenerator
        /// 棋盘格生成器
        case checkerboardGenerator
        /// Code 128条形码生成器
        case code128BarcodeGenerator
        /// 常量颜色生成器
        case constantColorGenerator
        /// 透镜光晕生成器
        case lenticularHaloGenerator
        /// 网格生成器
        case meshGenerator
        /// PDF417条形码生成器
        case pDF417BarcodeGenerator
        /// QR码生成器
        case qrCodeGenerator
        /// 随机生成器
        case randomGenerator
        /// 圆角矩形生成器
        case roundedRectangleGenerator
        /// 星光闪烁生成器
        case starShineGenerator
        /// 条纹生成器
        case stripesGenerator
        /// 阳光射线生成器
        case sunbeamsGenerator
        /// 文本图片生成器
        case textImageGenerator
    }
}

// MARK: - AxcCIFilterCategory.Generator + _AxcCIFilterNameProtocol

extension AxcCIFilterCategory.Generator: _AxcCIFilterNameProtocol { }
