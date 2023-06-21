//
//  AxcParagraphStyle.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/26.
//

#if os(macOS)
import AppKit

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit
#endif

// MARK: - [AxcMaker.ParagraphStyle]

public extension AxcMaker {
    /// 富文本样式相关
    struct ParagraphStyle {
        init(style: NSParagraphStyle) {
            self.style = style.axc.mutableParagraphStyle
        }

        var style: NSMutableParagraphStyle
    }
}

// MARK: - AxcMaker.ParagraphStyle + AxcAssertUnifiedTransformTarget

extension AxcMaker.ParagraphStyle: AxcAssertUnifiedTransformTarget { }

public extension AxcMaker.ParagraphStyle {
    /// 设置行间距
    /// - Parameter lineSpacing: 行间距
    @discardableResult
    func set(lineSpacing: AxcUnifiedNumber) -> Self {
        style.lineSpacing = assertTransformCGFloat(lineSpacing)
        return self
    }

    /// 设置段落间距
    /// - Parameter paragraphSpacing: 段落间距
    @discardableResult
    func set(paragraphSpacing: AxcUnifiedNumber) -> Self {
        style.paragraphSpacing = assertTransformCGFloat(paragraphSpacing)
        return self
    }

    /// 设置文字对齐
    /// - Parameter alignment: 文字对齐
    @discardableResult
    func set(alignment: NSTextAlignment) -> Self {
        style.alignment = alignment
        return self
    }

    /// 设置头缩进
    /// - Parameter headIndent: 头缩进
    @discardableResult
    func set(headIndent: AxcUnifiedNumber) -> Self {
        style.headIndent = assertTransformCGFloat(headIndent)
        return self
    }

    /// 设置尾缩进
    /// - Parameter tailIndent: 尾缩进
    @discardableResult
    func set(tailIndent: AxcUnifiedNumber) -> Self {
        style.tailIndent = assertTransformCGFloat(tailIndent)
        return self
    }

    /// 设置首行缩进
    /// - Parameter firstLineHeadIndent: 首行缩进
    @discardableResult
    func set(firstLineHeadIndent: AxcUnifiedNumber) -> Self {
        style.firstLineHeadIndent = assertTransformCGFloat(firstLineHeadIndent)
        return self
    }

    /// 设置最小行高
    /// - Parameter minimumLineHeight: 最小行高
    @discardableResult
    func set(minimumLineHeight: AxcUnifiedNumber) -> Self {
        style.minimumLineHeight = assertTransformCGFloat(minimumLineHeight)
        return self
    }

    /// 设置最大行高
    /// - Parameter maximumLineHeight: 最大行高
    @discardableResult
    func set(maximumLineHeight: AxcUnifiedNumber) -> Self {
        style.maximumLineHeight = assertTransformCGFloat(maximumLineHeight)
        return self
    }

    /// 设置换行模式
    /// - Parameter lineBreakMode: 换行模式
    @discardableResult
    func set(lineBreakMode: NSLineBreakMode) -> Self {
        style.lineBreakMode = lineBreakMode
        return self
    }

    /// 设置基础写作方向
    /// - Parameter baseWritingDirection: 基础写作方向
    @discardableResult
    func set(baseWritingDirection: NSWritingDirection) -> Self {
        style.baseWritingDirection = baseWritingDirection
        return self
    }

    /// 设置在受最小和最大行高限制之前，将自然行高乘以这个因子(如果是正数)。
    /// - Parameter lineHeightMultiple: 行高
    @discardableResult
    func set(lineHeightMultiple: AxcUnifiedNumber) -> Self {
        style.lineHeightMultiple = assertTransformCGFloat(lineHeightMultiple)
        return self
    }

    /// 设置段前间距
    /// - Parameter paragraphSpacingBefore: 段前间距
    @discardableResult
    func set(paragraphSpacingBefore: AxcUnifiedNumber) -> Self {
        style.paragraphSpacingBefore = assertTransformCGFloat(paragraphSpacingBefore)
        return self
    }

    /// 指定连字符的阈值。有效值介于0.0和1.0之间(包括1.0)。
    /// 当不使用连字符的文本宽度与行片段的宽度之比小于连字符系数时，将尝试使用连字符。
    /// 当它采用默认值0.0时，将使用布局管理器的连字符因子。当两者都为0.0时，将禁用连字符。
    /// - Parameter hyphenationFactor: 用连字符号连接的因子
    @discardableResult
    func set(hyphenationFactor: AxcUnifiedNumber) -> Self {
        style.hyphenationFactor = assertTransformFloat(hyphenationFactor)
        return self
    }

    /// 设置NSTextTabs的数组。内容应按位置排序。默认值是一个以28pt间隔左对齐的12个制表符的数组
    /// - Parameter tabStops: 制表符设置
    @discardableResult
    func set(tabStops: [NSTextTab]) -> Self {
        style.tabStops = tabStops
        return self
    }

    /// 设置制表符中最后一个元素以外的位置使用的默认制表符间隔
    /// - Parameter defaultTabInterval: 默认选项卡间隔
    @discardableResult
    func set(defaultTabInterval: AxcUnifiedNumber) -> Self {
        style.defaultTabInterval = assertTransformCGFloat(defaultTabInterval)
        return self
    }

    /// 设置如果在开始截断之前换行模式是截断模式之一
    /// 则在尝试拟合比可用空间更宽的行时收紧字符间间距。
    /// 默认情况下没有。系统根据上下文(如字体、行宽等)决定执行的最大收紧量。
    /// - Parameter allowsDefaultTighteningForTruncation: 允许截断的默认紧缩
    @discardableResult
    func set(allowsDefaultTighteningForTruncation: Bool) -> Self {
        style.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
        return self
    }

    /// 设置换行策略
    /// - Parameter lineBreakStrategy: 换行策略
    @discardableResult
    func set(lineBreakStrategy: NSParagraphStyle.LineBreakStrategy) -> Self {
        style.lineBreakStrategy = lineBreakStrategy
        return self
    }
}
