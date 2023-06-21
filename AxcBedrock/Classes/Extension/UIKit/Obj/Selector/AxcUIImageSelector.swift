//
//  AxcUIImageSelector.swift
//  Pods
//
//  Created by 赵新 on 2023/3/1.
//

#if canImport(UIKit)

import UIKit

// MARK: - [AxcBlock.SavedPhotosAlbumBlock]

public extension AxcBlock {
    typealias SavedPhotosAlbumBlock = (_ image: UIImage,
                                       _ error: NSError?,
                                       _ contextInfo: UnsafeRawPointer) -> Void
}

// MARK: - [AxcSelector.Image]

public extension AxcSelector {
    @objc
    class Image: NSObject {
        /// 保存到图片相册回调-Block
        var savedPhotosAlbumBlock: AxcBlock.SavedPhotosAlbumBlock?

        /// 保存到图片相册回调
        @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
            savedPhotosAlbumBlock?(image, error, contextInfo)
        }
    }
}

#endif
