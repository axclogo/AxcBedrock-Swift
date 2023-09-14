//
//  AxcNSAttributedStringEx+Platform.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/21.
//

#if os(macOS)
import AppKit

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit
#endif

// MARK: - 数据转换

public extension AxcSpace where Base: NSAttributedString { }

// MARK: - 类方法

public extension AxcSpace where Base: NSAttributedString {
    /// （💈跨平台标识）处理富文本
    /// - Parameter makeBlock: 处理闭包
    static func CreateAttributedString(_ makeBlock: AxcBlock.Maker<AxcMaker.AttributedString>)
        -> NSMutableAttributedString {
        return .init().axc.makeAttributed(makeBlock)
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: NSAttributedString {
    // MARK: 富文本

    /// （💈跨平台标识）处理富文本
    /// - Parameter makeBlock: 处理闭包
    func makeAttributed(_ makeBlock: AxcBlock.Maker<AxcMaker.AttributedString>)
        -> NSMutableAttributedString {
        let handle: AxcMaker.AttributedString = .init(attString: base)
        makeBlock(handle)
        return handle.attributedString
    }

    // MARK: 大小计算

    /// （💈跨平台标识）获取文本的宽度
    func textWidth(maxHeight: CGFloat) -> CGFloat {
        let maxSize = CGSize(width: .Axc.Max, height: maxHeight)
        return textSize(maxSize: maxSize).width
    }

    /// （💈跨平台标识）获取文本的高度
    func textHeight(maxWidth: CGFloat) -> CGFloat {
        let maxSize = CGSize(width: maxWidth, height: .Axc.Max)
        return textSize(maxSize: maxSize).height
    }

    /// （💈跨平台标识）获取文本的大小
    func textSize(maxSize: CGSize,
                  options: AxcBedrockNSStringDrawingOptions = [
                      .usesLineFragmentOrigin,
                      .usesFontLeading,
                      .usesDeviceMetrics,
                      .truncatesLastVisibleLine,
                  ]) -> CGSize {
        let attributes = attributes()
        let rect = base.string.boundingRect(with: maxSize,
                                            options: options,
                                            attributes: attributes,
                                            context: nil)
        let newWidth = rect.size.width.axc.ceil + 1
        let newHeight = rect.size.height.axc.ceil + 1
        return CGSize(width: newWidth, height: newHeight)
    }

    // MARK: 根据宽度获取每行的富文本

    /// 根据宽度分割成多行富文本
    /// - Parameter width: 最大宽度
    /// - Returns: 由每一行富文本构成的数组
    func componentsLines(maxWidth: CGFloat) -> [NSAttributedString] {
        let frameSetter = CTFramesetterCreateWithAttributedString(cfAttributedString)
        let path = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: maxWidth, height: .greatestFiniteMagnitude))
        let ctFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, base.length), path, nil)
        let ctLines = CTFrameGetLines(ctFrame) as! [CTLine]
        var lines: [NSAttributedString] = []
        for ctLine in ctLines {
            let lineRange = CTLineGetStringRange(ctLine)
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            let lineString = base.attributedSubstring(from: range)
            lines.append(lineString)
        }
        return lines
    }
}
