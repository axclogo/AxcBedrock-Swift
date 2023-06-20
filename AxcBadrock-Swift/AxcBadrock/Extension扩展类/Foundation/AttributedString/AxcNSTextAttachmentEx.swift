//
//  AxcNSTextAttachmentEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/5.
//

import UIKit

// MARK: - 数据转换
public extension NSTextAttachment {
    /// 转成富文本
    var axc_attributedStr: NSAttributedString {
        return NSAttributedString(attachment: self)
    }
    
}
 
// MARK: - 类方法/属性
public extension NSTextAttachment {
}
 
// MARK: - 属性 & Api
public extension NSTextAttachment {
    /// 设置bounds
    func axc_setBounds(_ bounds: CGRect) -> NSTextAttachment {
        self.bounds = bounds
        return self
    }
    /// 设置size
    func axc_setSize(_ size: CGSize) -> NSTextAttachment {
        self.bounds = CGRect((0,0,size.width,size.height))
        return self
    }
    /// 设置image
    func axc_setImage(_ image: UIImage) -> NSTextAttachment {
        self.image = image
        return self
    }
    /// 设置fileType
    func axc_setFileType(_ fileType: String) -> NSTextAttachment {
        self.fileType = fileType
        return self
    }
    /// 设置contents
    func axc_setContents(_ contents: Data) -> NSTextAttachment {
        self.contents = contents
        return self
    }
}
 
// MARK: - 决策判断
public extension NSTextAttachment {
}
 
