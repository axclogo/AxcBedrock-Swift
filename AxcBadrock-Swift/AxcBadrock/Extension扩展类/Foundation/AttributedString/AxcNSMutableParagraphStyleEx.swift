//
//  AxcNSMutableParagraphStyleEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/5.
//

import UIKit

// MARK: - 链式调用富文本的各项属性
public extension NSMutableParagraphStyle {
    /// 设置行间距
    /// - Parameter lineSpacing: 行间距
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setLineSpacing(_ lineSpacing: CGFloat) -> NSMutableParagraphStyle {
        self.lineSpacing = lineSpacing
        return self
    }
    
    /// 设置段落间距
    /// - Parameter paragraphSpacing: 段落间距
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setParagraphSpacing(_ paragraphSpacing: CGFloat) -> NSMutableParagraphStyle {
        self.paragraphSpacing = paragraphSpacing
        return self
    }
    
    /// 设置文字对齐
    /// - Parameter alignment: 文字对齐
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setAlignment(_ alignment: NSTextAlignment) -> NSMutableParagraphStyle {
        self.alignment = alignment
        return self
    }
    
    /// 设置头缩进
    /// - Parameter headIndent: 头缩进
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setHeadIndent(_ headIndent: CGFloat) -> NSMutableParagraphStyle {
        self.headIndent = headIndent
        return self
    }
    
    /// 设置尾缩进
    /// - Parameter tailIndent: 尾缩进
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setTailIndent(_ tailIndent: CGFloat) -> NSMutableParagraphStyle {
        self.tailIndent = tailIndent
        return self
    }
    
    /// 设置首行缩进
    /// - Parameter firstLineHeadIndent: 首行缩进
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setFirstLineHeadIndent(_ firstLineHeadIndent: CGFloat) -> NSMutableParagraphStyle {
        self.firstLineHeadIndent = firstLineHeadIndent
        return self
    }
    
    /// 设置最小行高
    /// - Parameter minimumLineHeight: 最小行高
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setMinimumLineHeight(_ minimumLineHeight: CGFloat) -> NSMutableParagraphStyle {
        self.minimumLineHeight = minimumLineHeight
        return self
    }
    
    /// 设置最大行高
    /// - Parameter maximumLineHeight: 最大行高
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setMaximumLineHeight(_ maximumLineHeight: CGFloat) -> NSMutableParagraphStyle {
        self.maximumLineHeight = maximumLineHeight
        return self
    }
    
    /// 设置换行模式
    /// - Parameter lineBreakMode: 换行模式
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setLineBreakMode(_ lineBreakMode: NSLineBreakMode) -> NSMutableParagraphStyle {
        self.lineBreakMode = lineBreakMode
        return self
    }
    
    /// 设置基础写作方向
    /// - Parameter baseWritingDirection: 基础写作方向
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setBaseWritingDirection(_ baseWritingDirection: NSWritingDirection) -> NSMutableParagraphStyle {
        self.baseWritingDirection = baseWritingDirection
        return self
    }
    
    /// 设置在受最小和最大行高限制之前，将自然行高乘以这个因子(如果是正数)。
    /// - Parameter lineHeightMultiple: 行高
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setLineHeightMultiple(_ lineHeightMultiple: CGFloat) -> NSMutableParagraphStyle {
        self.lineHeightMultiple = lineHeightMultiple
        return self
    }
    
    /// 设置段前间距
    /// - Parameter paragraphSpacingBefore: 段前间距
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setParagraphSpacingBefore(_ paragraphSpacingBefore: CGFloat) -> NSMutableParagraphStyle {
        self.paragraphSpacingBefore = paragraphSpacingBefore
        return self
    }
    
    /// 指定连字符的阈值。有效值介于0.0和1.0之间(包括1.0)。
    /// 当不使用连字符的文本宽度与行片段的宽度之比小于连字符系数时，将尝试使用连字符。
    /// 当它采用默认值0.0时，将使用布局管理器的连字符因子。当两者都为0.0时，将禁用连字符。
    /// - Parameter hyphenationFactor: 用连字符号连接的因子
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setHyphenationFactor(_ hyphenationFactor: CGFloat) -> NSMutableParagraphStyle {
        self.hyphenationFactor = hyphenationFactor.axc_float
        return self
    }
    
    /// 设置NSTextTabs的数组。内容应按位置排序。默认值是一个以28pt间隔左对齐的12个制表符的数组
    /// - Parameter tabStops: 制表符设置
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setTabStops(_ tabStops: [NSTextTab]) -> NSMutableParagraphStyle {
        self.tabStops = tabStops
        return self
    }
    
    /// 设置制表符中最后一个元素以外的位置使用的默认制表符间隔
    /// - Parameter defaultTabInterval: 默认选项卡间隔
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setDefaultTabInterval(_ defaultTabInterval: CGFloat) -> NSMutableParagraphStyle {
        self.defaultTabInterval = defaultTabInterval
        return self
    }
    
    /// 设置如果在开始截断之前换行模式是截断模式之一
    /// 则在尝试拟合比可用空间更宽的行时收紧字符间间距。
    /// 默认情况下没有。系统根据上下文(如字体、行宽等)决定执行的最大收紧量。
    /// - Parameter allowsDefaultTighteningForTruncation: 允许截断的默认紧缩
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setAllowsDefaultTighteningForTruncation(_ allowsDefaultTighteningForTruncation: Bool) -> NSMutableParagraphStyle {
        self.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
        return self
    }
    
    /// 设置换行策略
    /// - Parameter lineBreakStrategy: 换行策略
    /// - Returns: NSParagraphStyle
    @discardableResult
    func axc_setLineBreakStrategy(_ lineBreakStrategy: NSParagraphStyle.LineBreakStrategy) -> NSMutableParagraphStyle {
        self.lineBreakStrategy = lineBreakStrategy
        return self
    }
}
