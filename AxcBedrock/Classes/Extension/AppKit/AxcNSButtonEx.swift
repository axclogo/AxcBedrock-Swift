//
//  AxcNSButtonEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/21.
//

#if canImport(AppKit)

import AppKit

// MARK: - 数据转换

public extension AxcSpace where Base: NSButton { }

// MARK: - 类方法

public extension AxcSpace where Base: NSButton {
    /// 创建按钮
    static func Create(title: String,
                       font: AxcUnifiedFont = 14,
                       color: AxcUnifiedColor = NSColor.white,
                       alignment: NSTextAlignment = .center,
                       toolTip: String? = nil) -> Base {
        let btn = NSButton()
        btn.wantsLayer = true
        btn.attributedTitle = title.axc.makeAttributed({ make in
            make.set(font: font)
            make.set(foregroundColor: color)
            let paragraph = NSMutableParagraphStyle.Axc.CreateParagraphStyle { make in
                make.set(alignment: alignment)
            }
            make.set(paragraphStyle: paragraph)
        })
        btn.toolTip = toolTip
        btn.bezelStyle = .regularSquare
        btn.setButtonType(.momentaryLight)
        return btn as! Base
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: NSButton { }

// MARK: - 决策判断

public extension AxcSpace where Base: NSButton { }

#endif
