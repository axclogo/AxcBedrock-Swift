//
//  AxcNSParagraphStyleEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/4/12.
//

import UIKit

// MARK: - 数据转换
public extension NSParagraphStyle {
    /// 转换成可变的段落样式
    var axc_mutable: NSMutableParagraphStyle {
        if let mutableStyle = self as? NSMutableParagraphStyle {
            return mutableStyle
        }else{
            let style = NSMutableParagraphStyle()
            style.setParagraphStyle(self)
            return style
        }
    }
}

// MARK: - 类方法/属性
public extension NSParagraphStyle {
    /// 生成可变段落样式
    static var axc_mutable: NSMutableParagraphStyle {
        return NSMutableParagraphStyle()
    }
}
