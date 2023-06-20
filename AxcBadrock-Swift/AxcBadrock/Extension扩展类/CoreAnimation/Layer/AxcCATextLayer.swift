//
//  AxcCATextLayer.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/6/16.
//

import UIKit

// MARK: - 数据转换
public extension CATextLayer {
}

// MARK: - 类方法/属性
public extension CATextLayer {
    /// 快速实例化方法
    convenience init(text: String? = nil,
                     font: AxcUnifiedFontTarget? = nil,
                     color: AxcUnifiedColorTarget? = nil,
                     alignment: NSTextAlignment = .left) {
        self.init()
        axc_text = text
        axc_font = font
        axc_textColor = color
        axc_textAlignment = alignment
        axc_scaleWrapped()
    }
}

// MARK: - 属性 & Api
private var kaxc_font = "kaxc_font"
public extension CATextLayer {
    /// 文字
    var axc_text: String? {
        set { string = newValue }
        get {
            guard let text = string as? String
            else { return nil }
            return text
        }
    }
    
    /// 富文本
    var axc_attributedStr: NSAttributedString? {
        set { string = newValue }
        get {
            guard let attText = string as? NSAttributedString
            else { return nil }
            return attText
        }
    }
    
    /// 文字颜色
    var axc_textColor: AxcUnifiedColorTarget? {
        set { foregroundColor = newValue?.axc_cgColor }
        get { return foregroundColor?.axc_color }
    }
    
    /// 对齐模式
    var axc_textAlignment: NSTextAlignment {
        set { alignmentMode = newValue.axc_caTextLayerAlignmentMode }
        get { return alignmentMode.axc_nsTextAlignment }
    }
    
    /// 字体
    var axc_font: AxcUnifiedFontTarget? {
        set {
            AxcRuntime.setObj(self, &kaxc_font, newValue)
            font = newValue?.axc_font.fontName.axc_cfString
            fontSize = newValue?.axc_font.pointSize ?? 12
        }
        get { return AxcRuntime.getObj(self, &kaxc_font) }
    }
    
    /// 设置缩放和清晰度
    func axc_scaleWrapped() {
        contentsScale = UIScreen.main.scale
        isWrapped = true
    }
}


// MARK: - 【对象特性扩展区】
public extension CATextLayer {
}

// MARK: - 决策判断
public extension CATextLayer {
}

// MARK: - 操作符
public extension CATextLayer {
}

// MARK: - 运算符
public extension CATextLayer {
}
