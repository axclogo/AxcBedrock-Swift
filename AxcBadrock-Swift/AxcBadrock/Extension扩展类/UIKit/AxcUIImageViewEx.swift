//
//  AxcUIImageViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

// MARK: - 数据转换
public extension UIImageView {
}

// MARK: - 类方法/属性
public extension UIImageView {
    /// 通过图片名创建ImageView
    /// - Parameter imageName: 图片名
    convenience init(_ imageName: String) {
        self.init()
        image = imageName.axc_image
    }
}

// MARK: - 属性 & Api
public extension UIImageView {
    /// 快速设置图片名称
    func axc_imageName(_ imageName: String) {
        image = imageName.axc_image
    }
    /// 快速设置渲染颜色
    func axc_tintColor(_ tintColor: AxcUnifiedColorTarget, mode: UIImage.RenderingMode = .alwaysTemplate ) {
        image = image?.withRenderingMode(mode)
        self.tintColor = tintColor.axc_color
    }
    /// 播放图片组
    /// - Parameters:
    ///   - images: 图片组
    ///   - duration: 时间，默认10
    ///   - repeatCount: 重复次数，默认0
    func axc_playImages(_ images: [UIImage], duration: CGFloat = 10, repeatCount: Int = 0) {
        guard !images.axc_isEmpty else { return }
        animationImages = images
        animationDuration = images.count.axc_double / duration.axc_double
        animationRepeatCount = repeatCount
        startAnimating()
    }
    func axc_stopPlayImages() {
        guard isAnimating else { return }
        stopAnimating()
    }
}

// MARK: - 决策判断
public extension UIImageView {
    /// 是否有图片
    var axc_isHasImage: Bool { return image != nil }
    
}
