//
//  AxcNSTextAttachmentEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/26.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base: NSTextAttachment {
    /// 转成富文本
    var attributedStr: NSAttributedString {
        return NSAttributedString(attachment: base)
    }
}

// MARK: - 类方法

public extension AxcSpace where Base: NSTextAttachment {
    /// 生成文本附件
    static func CreateAttachment(_ makeBlock: AxcBlock.Maker<AxcMaker.TextAttachment>)
        -> NSTextAttachment
    {
        return .init().axc.makeTextAttachment(makeBlock)
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: NSTextAttachment {
    /// 设置文本附件属性
    func makeTextAttachment(_ makeBlock: AxcBlock.Maker<AxcMaker.TextAttachment>)
        -> NSTextAttachment
    {
        let handle: AxcMaker.TextAttachment = .init(attachment: base)
        makeBlock(handle)
        return handle.attachment
    }
}

#endif
