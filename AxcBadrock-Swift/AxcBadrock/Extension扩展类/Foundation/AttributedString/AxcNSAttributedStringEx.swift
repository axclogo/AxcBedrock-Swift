//
//  AxcNSAttributedStringEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/4.
//

import UIKit


// MARK: - 数据转换
public extension NSAttributedString {
}

// MARK: - 类方法/属性
public extension NSAttributedString {
}

// MARK: - 属性 & Api
public extension NSAttributedString {
    /// 计算文字的宽度
    func axc_width(_ maxHeight: CGFloat) -> CGFloat {
        return axc_size(CGSize(width: Axc_floatMax, height: maxHeight)).width
    }
    /// 计算文字的高度
    func axc_height(_ maxWidth: CGFloat) -> CGFloat {
        return axc_size(CGSize(width: maxWidth, height: Axc_floatMax)).height
    }
    /// 计算文字的大小
    func axc_size(_ size: CGSize) -> CGSize {
        return string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: axc_attributes, context: nil).size
    }
    
    /// 获取富文本全部属性
    var axc_attributes: [NSAttributedString.Key : Any] {
        guard string.count > 0 else { return [:] }
        return attributes(at: 0, effectiveRange: nil)
    }
    /// 为这段富文本新增一种属性
    @discardableResult
    func axc_applying(_ attributes: [Key: Any], range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        let copy = axc_mutableCopy()
        var attRange = NSRange(0..<length)
        if let r = range { attRange = r }
        copy.addAttributes(attributes, range: attRange)
        return copy
    }
    /// 拷贝可变
    func axc_mutableCopy() -> NSMutableAttributedString {
        var copy = NSMutableAttributedString()
        if let mutable = self as? NSMutableAttributedString {
            copy = mutable
        }else{
            copy = NSMutableAttributedString(attributedString: self)
        }
        return copy
    }
}

// MARK: - 链式调用富文本的各项属性
public extension NSAttributedString {
    /// 设置字体
    @discardableResult
    func axc_setFont(_ font: AxcUnifiedFontTarget, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.font: font.axc_font],range: range)
    }
    /// 设置段落样式
    @discardableResult
    func axc_setParagraphStyle(_ paragraphStyle: NSParagraphStyle, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.paragraphStyle:paragraphStyle],range: range)
    }
    /// 字色
    @discardableResult
    func axc_setTextColor(_ color: AxcUnifiedColorTarget, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.foregroundColor: color.axc_color],range: range)
    }
    /// 背景色
    @discardableResult
    func axc_setBackgroundColor(_ color: AxcUnifiedColorTarget, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.backgroundColor: color.axc_color],range: range)
    }
    /// 连体字符 - 该属性所对应的值是一个 NSNumber 对象(整数)。连体字符是指某些连在一起的字符，它们采用单个的图元符号。
    /// 0 表示没有连体字符。1 表示使用默认的连体字符。2表示使用所有连体符号。默认值为 1（注意，iOS 不支持值为 2）。
    @discardableResult
    func axc_setLigature(_ ligature: Bool, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.ligature:ligature.axc_number],range: range)
    }
    /// 包含浮点值，修改默认的字距。0表示禁用字距调整。
    @discardableResult
    func axc_setKern(_ kern: Float, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.kern:kern.axc_number],range: range)
    }
    /// 包含浮点值，金额修改默认跟踪。0表示禁用跟踪。
    @discardableResult
    @available(iOS 14.0, *)
    func axc_setTracking(_ tracking: Float, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.tracking:tracking.axc_number],range: range)
    }
    /// 删除线 默认0:没有划线
    @discardableResult
    func axc_setStrikethroughStyle(_ strikethroughStyle: Bool, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.strikethroughStyle:strikethroughStyle.axc_number],range: range)
    }
    /// 删除线颜色
    @discardableResult
    func axc_setStrikethroughColor(_ strikethroughColor: AxcUnifiedColorTarget, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.strikethroughColor: strikethroughColor.axc_color],range: range)
    }
    /// 下划线 默认0:没有划线
    @discardableResult
    func axc_setUnderlineStyle(_ underlineStyle: Bool, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.underlineStyle:underlineStyle.axc_number],range: range)
    }
    /// 下划线颜色
    @discardableResult
    func axc_setUnderlineColor(_ underlineColor: AxcUnifiedColorTarget, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.underlineColor: underlineColor.axc_color],range: range)
    }
    /// 笔画宽度(粗细)，取值为整数，负值填充效果，正值中空效果
    @discardableResult
    func axc_setStrokeWidth(_ strokeWidth: CGFloat, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.strokeWidth:strokeWidth.axc_number],range: range)
    }
    /// 填充部分颜色，不是字体颜色
    @discardableResult
    func axc_setStrokeColor(_ strokeColor: AxcUnifiedColorTarget, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.strokeColor:strokeColor.axc_color],range: range)
    }
    /// 设置阴影
    @discardableResult
    func axc_setShadow(_ shadow: NSShadow, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.shadow:shadow],range: range)
    }
    /// 文字效果
    @discardableResult
    func axc_setTextEffect(_ textEffect: String, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.textEffect:textEffect],range: range)
    }
    /// 附件数据
    @discardableResult
    func axc_setAttachment(_ attachment: NSTextAttachment, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.attachment:attachment],range: range)
    }
    /// 设置链接url，点击后调用浏览器打开指定URL地址
    @discardableResult
    func axc_setLink(_ link: URL, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.link:link],range: range)
    }
    /// 设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
    @discardableResult
    func axc_setBaselineOffset(_ baselineOffset: CGFloat, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.baselineOffset:baselineOffset.axc_number],range: range)
    }
    /// 设置字体倾斜
    @discardableResult
    func axc_setObliqueness(_ obliqueness: CGFloat, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.obliqueness:obliqueness.axc_number],range: range)
    }
    /// 要应用于符号的扩展因子的对数，默认0:不扩展
    @discardableResult
    func axc_setExpansion(_ expansion: CGFloat, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.expansion:expansion.axc_number],range: range)
    }
    /// 设置文字书写方向，从左向右书写或者从右向左书写
    ///
    ///     LRE: NSWritingDirectionLeftToRight | NSWritingDirectionEmbedding,
    ///     RLE: NSWritingDirectionRightToLeft | NSWritingDirectionEmbedding,
    ///     LRO: NSWritingDirectionLeftToRight | NSWritingDirectionOverride,
    ///     RLO: NSWritingDirectionRightToLeft | NSWritingDirectionOverride,
    @discardableResult
    func axc_setWritingDirection(_ writingDirection: Int, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.writingDirection:writingDirection.axc_number],range: range)
    }
    /// 文字排版方向，true表示竖排，false表示横排
    @discardableResult
    func axc_setVerticalGlyphForm(_ verticalGlyphForm: Bool, range: NSRange? = nil) -> NSAttributedString {
        return axc_applying([.verticalGlyphForm:verticalGlyphForm.axc_number],range: range)
    }
}

// MARK: - 操作符
public extension NSAttributedString {
    /// 如同字典一般设置、获取富文本属性
    ///
    ///     let aa = "asd".axc_attributedStr.axc_setFont(UIFont.systemFont(ofSize: 15))[.font] // 读取属性
    ///     "asd".axc_attributedStr[.font] = UIFont.systemFont(ofSize: 12)  // 设置属性
    ///
    subscript(_ key: NSAttributedString.Key ) -> Any? {
        set{
            guard let value = newValue else { return }
            axc_applying([key : value])
        }
        get{ return axc_attributes[key] }
    }
}

// MARK: - 运算符
public extension NSAttributedString {
    /// 拼接NSAttributedString
    static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        lhs = string
    }

    /// 相加生成一个新的NSAttributedString
    static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        return NSAttributedString(attributedString: string)
    }
}
