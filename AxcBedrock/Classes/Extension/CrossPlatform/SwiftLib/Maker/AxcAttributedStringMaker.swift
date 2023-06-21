//
//  AttributedString.swift
//  FBSnapshotTestCase
//
//  Created by 赵新 on 2023/2/14.
//

#if os(macOS)
import AppKit

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit
#endif

// MARK: - [AxcMaker.AttributedString]

public extension AxcMaker {
    /// （💈跨平台标识）富文本相关
    struct AttributedString {
        init(attString: NSAttributedString) {
            self.attributedString = .init(attributedString: attString)
        }

        /// （💈跨平台标识）处理好的富文本
        var attributedString: NSMutableAttributedString
    }
}

// MARK: - AxcMaker.AttributedString + AxcAssertUnifiedTransformTarget

extension AxcMaker.AttributedString: AxcAssertUnifiedTransformTarget { }

public extension AxcMaker.AttributedString {
    /// （💈跨平台标识）设置字体
    @discardableResult
    func set(font: AxcUnifiedFont, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.font: assertTransformFont(font)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）设置段落样式
    @discardableResult
    func set(paragraphStyle: NSParagraphStyle, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.paragraphStyle: paragraphStyle],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）字色
    @discardableResult
    func set(foregroundColor: AxcUnifiedColor, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.foregroundColor: assertTransformColor(foregroundColor)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）背景色
    @discardableResult
    func set(backgroundColor: AxcUnifiedColor, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.backgroundColor: assertTransformColor(backgroundColor)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）连体字符 - 该属性所对应的值是一个 NSNumber 对象(整数)。连体字符是指某些连在一起的字符，它们采用单个的图元符号。
    /// 0 表示没有连体字符。1 表示使用默认的连体字符。2表示使用所有连体符号。默认值为 1（注意，iOS 不支持值为 2）。
    @discardableResult
    func set(ligature: Bool, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.ligature: assertTransformNumber(ligature)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）包含浮点值，修改默认的字距。0表示禁用字距调整。
    @discardableResult
    func set(kern: AxcUnifiedNumber, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.kern: assertTransformNumber(kern)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）包含浮点值，金额修改默认跟踪。0表示禁用跟踪。
    @discardableResult
    @available(iOS 14.0, *)
    func set(tracking: AxcUnifiedNumber, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.tracking: assertTransformNumber(tracking)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）删除线 默认0:没有划线
    @discardableResult
    func set(number: Bool, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.strikethroughStyle: assertTransformNumber(number)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）删除线颜色
    @discardableResult
    func set(strikethroughColor: AxcUnifiedColor, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.strikethroughColor: assertTransformColor(strikethroughColor)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）下划线 默认0:没有划线
    @discardableResult
    func set(underlineStyle: Bool, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.underlineStyle: assertTransformNumber(underlineStyle)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）下划线颜色
    @discardableResult
    func set(underlineColor: AxcUnifiedColor, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.underlineColor: assertTransformColor(underlineColor)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）笔画宽度(粗细)，取值为整数，负值填充效果，正值中空效果
    @discardableResult
    func set(strokeWidth: AxcUnifiedNumber, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.strokeWidth: assertTransformNumber(strokeWidth)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）填充部分颜色，不是字体颜色
    @discardableResult
    func set(strokeColor: AxcUnifiedColor, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.strokeColor: assertTransformColor(strokeColor)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）设置阴影
    @discardableResult
    func set(shadow: NSShadow, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.shadow: shadow],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）文字效果
    @discardableResult
    func set(textEffect: String, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.textEffect: textEffect],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）附件数据
    @discardableResult
    func set(attachment: NSTextAttachment, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.attachment: attachment],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）设置链接url，点击后调用浏览器打开指定URL地址
    @discardableResult
    func set(link: AxcUnifiedUrl, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.link: assertTransformURL(link)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
    @discardableResult
    func set(baselineOffset: AxcUnifiedNumber, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.baselineOffset: assertTransformNumber(baselineOffset)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）设置字体倾斜
    @discardableResult
    func set(obliqueness: AxcUnifiedNumber, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.obliqueness: assertTransformNumber(obliqueness)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）要应用于符号的扩展因子的对数，默认0:不扩展
    @discardableResult
    func set(expansion: AxcUnifiedNumber, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.expansion: assertTransformNumber(expansion)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）设置文字书写方向，从左向右书写或者从右向左书写
    ///
    ///     LRE: NSWritingDirectionLeftToRight | NSWritingDirectionEmbedding,
    ///     RLE: NSWritingDirectionRightToLeft | NSWritingDirectionEmbedding,
    ///     LRO: NSWritingDirectionLeftToRight | NSWritingDirectionOverride,
    ///     RLO: NSWritingDirectionRightToLeft | NSWritingDirectionOverride,
    @discardableResult
    func set(number: AxcUnifiedNumber, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.writingDirection: assertTransformNumber(number)],
                                     range: range)
        return self
    }

    /// （💈跨平台标识）文字排版方向，true表示竖排，false表示横排
    @discardableResult
    func set(verticalGlyphForm: Bool, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.verticalGlyphForm: assertTransformNumber(verticalGlyphForm)],
                                     range: range)
        return self
    }
}

#if os(macOS)

// MARK: - MacOS平台独占

public extension AxcMaker.AttributedString {
    /// 光标
    @discardableResult
    func set(cursor: NSCursor, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.cursor: cursor],
                                     range: range)
        return self
    }

    /// 工具提示
    @discardableResult
    func set(toolTip: String, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.toolTip: toolTip],
                                     range: range)
        return self
    }

    /// 子句段索引NSNumber (intValue)。此属性用于标记文本，指示子句段
    @discardableResult
    func set(markedClauseSegment: AxcUnifiedNumber, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.markedClauseSegment: assertTransformNumber(markedClauseSegment)],
                                     range: range)
        return self
    }

    /// 主要用作临时属性，primaryString等于它所附加的范围的子字符串
    /// 而alternativeStrings表示可能呈现给用户的该字符串的备选项。
    @discardableResult
    func set(textAlternatives: NSTextAlternatives, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.textAlternatives: textAlternatives],
                                     range: range)
        return self
    }

    /// NSSpellingStateAttributeName只作为一个临时属性被使用和识别(参见NSLayoutManager.h)。
    /// 它表示应该为指定的字符显示拼写和/或语法指示器，默认为0:没有拼写或语法指示器
    @discardableResult
    func set(spellingState: AxcUnifiedNumber, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.spellingState: assertTransformNumber(spellingState)],
                                     range: range)
        return self
    }

    /// 工具提示
    @discardableResult
    func set(superscript: AxcUnifiedNumber, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.superscript: assertTransformNumber(superscript)],
                                     range: range)
        return self
    }

    /// 字形信息
    @discardableResult
    func set(glyphInfo: NSGlyphInfo, range: AxcUnifiedRange? = nil) -> Self {
        attributedString.axc.applying([.glyphInfo: glyphInfo],
                                     range: range)
        return self
    }
}
#endif
