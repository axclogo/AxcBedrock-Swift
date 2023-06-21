//
//  AxcTextAttachmentMaker.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/26.
//

#if canImport(UIKit)

import UIKit

// MARK: - [AxcMaker.TextAttachment]

public extension AxcMaker {
    /// 富文本样式相关
    struct TextAttachment {
        init(attachment: NSTextAttachment) {
            self.attachment = attachment
        }

        var attachment: NSTextAttachment
    }
}

// MARK: - AxcMaker.TextAttachment + AxcAssertUnifiedTransformTarget

extension AxcMaker.TextAttachment: AxcAssertUnifiedTransformTarget { }

public extension AxcMaker.TextAttachment {
    /// 设置bounds
    @discardableResult
    func set(bounds: CGRect) -> Self {
        attachment.bounds = bounds
        return self
    }

    /// 设置size
    @discardableResult
    func set(size: CGSize) -> Self {
        attachment.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        return self
    }

    /// 设置image
    @discardableResult
    func set(image: UIImage) -> Self {
        attachment.image = image
        return self
    }

    /// 设置fileType
    @discardableResult
    func set(fileType: String) -> Self {
        attachment.fileType = fileType
        return self
    }

    /// 设置contents
    @discardableResult
    func set(contents: Data) -> Self {
        attachment.contents = contents
        return self
    }
}

#endif
