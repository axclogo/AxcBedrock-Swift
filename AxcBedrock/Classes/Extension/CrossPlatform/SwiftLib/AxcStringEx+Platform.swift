//
//  AxcStringEx+Platform.swift
//  Pods-AxcBedrock_Example
//
//  Created by 赵新 on 2023/2/21.
//

#if os(macOS)
import AppKit

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit
#endif

// MARK: - 数据转换

public extension AxcSpace where Base == String {
    /// 将这个base64字符转换成图片
    var base64Image: AxcBedrockImage? {
        guard let data = Data(base64Encoded: base, options: .ignoreUnknownCharacters) else { return nil }
        return AxcBedrockImage(data: data)
    }

    /// 生成字符串对应的二维码图片
    var qrCodeImage: AxcBedrockImage? {
        return qrCodeImage()
    }

    /// 生成字符串对应的二维码图片
    /// - Parameter size: 大小，默认1024
    /// - Returns: 图片
    func qrCodeImage(size: CGSize = 1024.axc.cgSize) -> AxcBedrockImage? {
        guard let ciImage = qrCodeCIImage else { return nil }
        guard let cgImage = CGImage.Axc.CreateHD(with: ciImage, size: size) else { return nil }
        #if os(macOS)
        return AxcBedrockImage(cgImage: cgImage, size: .zero)

        #elseif os(iOS) || os(tvOS) || os(watchOS)

        return AxcBedrockImage(cgImage: cgImage)
        #endif
    }

    
    // TODO: 更新滤镜为对象扩展
    /// 获取以这个字符串为内容生成CIImage格式的二维码
    var qrCodeCIImage: CIImage? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setDefaults()
        guard let data = data(using: .utf8) else { return nil }
        filter.setValue(data, forKey: "inputMessage")
        guard let outPutImage = filter.outputImage else { return nil }
        return outPutImage
            
    }
}

// MARK: - 富文本

public extension AxcSpace where Base == String {
    /// （💈跨平台标识）处理富文本
    /// - Parameters:
    ///   - foregroundColor: 文字颜色
    ///   - font: 文字字体
    /// - Returns: 富文本
    func attributedStr(foregroundColor: AxcUnifiedColor? = nil,
                       font: AxcUnifiedFont? = nil) -> NSMutableAttributedString {
        return makeAttributed { make in
            if let foregroundColor = foregroundColor {
                make.set(foregroundColor: foregroundColor)
            }
            if let font = font {
                make.set(font: font)
            }
        }
    }

    /// （💈跨平台标识）处理富文本
    /// - Parameter makeBlock: 处理闭包
    /// - Returns: 富文本
    func makeAttributed(_ makeBlock: AxcBlock.Maker<AxcMaker.AttributedString>) -> NSMutableAttributedString
    {
        let attributedHandle: AxcMaker.AttributedString = .init(attString: .init(string: base))
        makeBlock(attributedHandle)
        return attributedHandle.attributedString
    }

    /// （💈跨平台标识）标记成富文本
    /// - Parameters:
    ///   - text: 标记文字
    ///   - color: 颜色可选
    ///   - font: 字体可选
    ///   - backgroundColor: 背景色可选
    /// - Returns: NSMutableAttributedString
    func mark(text: String,
              color: AxcUnifiedColor? = nil,
              font: AxcUnifiedFont? = nil,
              backgroundColor: AxcUnifiedColor? = nil) -> NSMutableAttributedString {
        return mark(textList: [text], color: color, font: font, backgroundColor: backgroundColor)
    }

    /// （💈跨平台标识）标记成富文本
    /// - Parameters:
    ///   - text: 标记文字
    ///   - attributes: 标记属性
    /// - Returns: NSMutableAttributedString
    func mark(text: String,
              attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        return mark(textList: [text], attributes: attributes)
    }

    /// （💈跨平台标识）标记成富文本
    /// - Parameters:
    ///   - text: 标记文字
    ///   - color: 颜色可选
    ///   - font: 字体可选
    ///   - backgroundColor: 背景色可选
    /// - Returns: NSMutableAttributedString
    func mark(textList: [String],
              color: AxcUnifiedColor? = nil,
              font: AxcUnifiedFont? = nil,
              backgroundColor: AxcUnifiedColor? = nil) -> NSMutableAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        if let _color = color {
            attributes[.foregroundColor] = AxcBedrockColor.Axc.Create(_color)
        }
        if let _font = font {
            attributes[.font] = AxcBedrockFont.Axc.Create(_font)
        }
        if let _backgroundColor = backgroundColor {
            attributes[.backgroundColor] = AxcBedrockColor.Axc.Create(_backgroundColor)
        }
        return mark(textList: textList, attributes: attributes)
    }

    /// （💈跨平台标识）标记成富文本
    /// - Parameters:
    ///   - text: 标记文字
    ///   - attributes: 标记属性
    /// - Returns: NSMutableAttributedString
    func mark(textList: [String],
              attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        let ranges = searchRanges(with: textList)
        let attStr = NSMutableAttributedString(string: base)
        for range in ranges {
            attStr.setAttributes(attributes, range: range)
        }
        return attStr
    }

    /// （💈跨平台标识）将这段字符串复制到剪贴板
    func copyToPasteboard() {
        #if os(macOS)
        NSPasteboard.general.setString(base, forType: .string)
        #elseif os(iOS) || os(tvOS) || os(watchOS)
        UIPasteboard.general.string = base
        #endif
    }
}

// MARK: - 大小计算

public extension AxcSpace where Base == String {
    /// （💈跨平台标识）计算文字的宽度
    func textWidth(maxHeight: CGFloat,
                   font: AxcUnifiedFont,
                   paragraphStyle: NSParagraphStyle? = nil) -> CGFloat {
        let maxSize = CGSize(width: .Axc.Max, height: maxHeight)
        return textSize(maxSize: maxSize, font: font, paragraphStyle: paragraphStyle).width
    }

    /// （💈跨平台标识）计算文字的高度
    func textHeight(maxWidth: CGFloat,
                    font: AxcUnifiedFont,
                    paragraphStyle: NSParagraphStyle? = nil) -> CGFloat {
        let maxSize = CGSize(width: maxWidth, height: .Axc.Max)
        return textSize(maxSize: maxSize, font: font, paragraphStyle: paragraphStyle).height
    }

    /// （💈跨平台标识）计算文字的大小
    func textSize(maxSize: CGSize,
                  font: AxcUnifiedFont,
                  paragraphStyle: NSParagraphStyle? = nil,
                  options: AxcBedrockNSStringDrawingOptions = [
                      .usesLineFragmentOrigin,
                      .usesFontLeading,
                  ]) -> CGSize {
        // 配置富文本属性
        let attStr = makeAttributed { make in
            make.set(font: font)
            if let paragraphStyle = paragraphStyle {
                make.set(paragraphStyle: paragraphStyle)
            }
        }
        return attStr.axc.textSize(maxSize: maxSize, options: options)
    }
}
