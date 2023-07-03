//
//  AxcNSTextFieldEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/4/7.
//

#if canImport(AppKit)

import AppKit

// MARK: - 数据转换

public extension AxcSpace where Base: NSTextField { }

// MARK: - 类方法

public extension AxcSpace where Base: NSTextField {
    /// 创建标签
    static func CreateLabel(text: String? = nil,
                            font: AxcUnifiedFont? = nil,
                            color: AxcUnifiedColor? = nil,
                            alignment: NSTextAlignment = .left,
                            toolTip: String? = nil) -> Base {
        let label = NSTextField()
        label.isBezeled = false
        label.isEditable = false // 不可编辑
        label.isBordered = false // 不显示边框
        label.isSelectable = false
        label.drawsBackground = true // 渲染背景色
        label.backgroundColor = .clear
        if let text {
            label.stringValue = text
        }
        if let font {
            label.font = AssertTransformFont(font)
        }
        if let color {
            label.textColor = AssertTransformColor(color)
        }
        label.alignment = alignment
        label.toolTip = toolTip
        return label as! Base
    }

    /// 实例化富文本
    /// - Parameter attributedText: 富文本
    static func CreateLabel(_ attributedText: NSAttributedString) -> Base {
        let label: Base = .init()
        label.backgroundColor = .clear
        label.isEditable = false // 不可编辑
        label.isBordered = false // 不显示边框
        label.attributedStringValue = attributedText
        return label
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: NSTextField { }

// MARK: - 决策判断

public extension AxcSpace where Base: NSTextField { }

#endif
