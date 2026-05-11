//
//  AxcNSParagraphStyleEx+Platform.swift
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

public extension AxcSpace where Base: NSParagraphStyle {
    /// 转换成可变的段落样式
    var mutableParagraphStyle: NSMutableParagraphStyle {
        if let mutableStyle = base as? NSMutableParagraphStyle {
            return mutableStyle
        } else {
            let style = NSMutableParagraphStyle()
            style.setParagraphStyle(base)
            return style
        }
    }
}

// MARK: - 类方法

public extension AxcSpace where Base: NSParagraphStyle {
    /// 生成可变段落样式
    static func CreateParagraphStyle(_ makeBlock: AxcBlock.Maker<AxcMaker.ParagraphStyle>)
        -> NSMutableParagraphStyle {
        return .init().axc.makeParagraphStyle(makeBlock)
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: NSParagraphStyle {
    /// 设置属性
    func makeParagraphStyle(_ makeBlock: AxcBlock.Maker<AxcMaker.ParagraphStyle>)
        -> NSMutableParagraphStyle {
        let handle: AxcMaker.ParagraphStyle = .init(style: base)
        makeBlock(handle)
        return handle.style
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: NSParagraphStyle { }
