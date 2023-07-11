//
//  AxcUIImageViewEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/18.
//

#if canImport(UIKit)

import UIKit

// MARK: - [AxcUIImageViewSpace]

public struct AxcUIImageViewSpace<Base: UIImageView>: AxcAssertUnifiedTransformTarget {
    init(_ base: Base) {
        self.base = base
    }

    var base: Base
}

public extension UIImageView {
    /// 命名空间
    var axc: AxcUIImageViewSpace<UIImageView> {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcUIImageViewSpace<UIImageView>.Type {
        return AxcUIImageViewSpace.self
    }
}

// MARK: - 数据转换

public extension AxcUIImageViewSpace { }

// MARK: - 类方法

public extension AxcUIImageViewSpace {
    /// 创建图片展示视图
    /// - Parameters:
    ///   - imageName: 图片名称
    ///   - contentMode: 填充模式
    /// - Returns: 图片展示视图
    static func Create(imageName: String,
                       contentMode: UIView.ContentMode = .scaleAspectFit) -> Base {
        return Create(image: imageName.axc.uiImage,
                      contentMode: contentMode)
    }

    /// 创建图片展示视图
    /// - Parameters:
    ///   - image: 图片
    ///   - contentMode: 填充模式
    /// - Returns: 图片展示视图
    static func Create(image: UIImage?,
                       contentMode: UIView.ContentMode = .scaleAspectFit) -> Base {
        let imageView = Base(image: image)
        imageView.contentMode = contentMode
        return imageView
    }
}

// MARK: - 属性 & Api

public extension AxcUIImageViewSpace {
    /// 设置渲染颜色
    func set(tintColor: UIColor) {
        return set(tintUnifiedColor: tintColor)
    }

    /// 设置渲染模式颜色
    func set(tintUnifiedColor: AxcUnifiedColor) {
        base.image = base.image?.axc.setTemplateMode()
        base.tintColor = assertTransformColor(tintUnifiedColor)
    }

    /// 设置Git图片
    /// - Parameters:
    ///   - bundle: 资源包
    ///   - name: git文件名，可以例如：xxxx、xxxx.gif、xxxx.GIF
    ///   - duration: 时间，默认空，自动计算每张图展示0.2秒
    ///   - repeatCount: 重复次数，默认 0 无限
    func setGifImage(with bundle: Bundle? = nil,
                     name: String,
                     duration: AxcUnifiedNumber? = nil,
                     repeatCount: Int = 0) {
        var sourceBundle = Bundle.main
        if let bundle {
            sourceBundle = bundle
        }
        var gifPath: String?
        if let fileExtension = name.components(separatedBy: ".").last,
           fileExtension.lowercased() == "gif",
           let path = sourceBundle.path(forResource: name, ofType: nil) {
            gifPath = path
        } else if let path = sourceBundle.path(forResource: name, ofType: "gif") {
            gifPath = path
        } else if let path = sourceBundle.path(forResource: name, ofType: "GIF") {
            gifPath = path
        }
        guard let gifPath else { return }
        let url = URL(fileURLWithPath: gifPath)
        guard let gifSource = CGImageSourceCreateWithURL(url as CFURL, nil) else { return }
        let frameCount = CGImageSourceGetCount(gifSource)
        var imgLists: [UIImage] = []
        for idx in 0 ..< frameCount {
            if let imageRef = CGImageSourceCreateImageAtIndex(gifSource, idx, nil) {
                let img = UIImage(cgImage: imageRef)
                imgLists.append(img)
            }
        }
        playImages(imgLists, duration: duration, repeatCount: repeatCount)
    }

    /// 播放图片组
    /// - Parameters:
    ///   - images: 图片组
    ///   - duration: 时间，默认空，空则自动计算每张图展示0.2秒
    ///   - repeatCount: 重复次数，默认 0 无限
    func playImages(_ images: [UIImage],
                    duration: AxcUnifiedNumber? = nil,
                    repeatCount: Int = 0) {
        guard !images.isEmpty else { return }
        var _duration: Double = 0
        if let duration = duration {
            _duration = assertTransformDouble(duration)
            let count = images.count.axc.double
            base.animationDuration = count / _duration
        } else {
            _duration = images.count.axc.double * 0.2
            base.animationDuration = _duration
        }
        base.animationImages = images
        base.animationRepeatCount = repeatCount
        base.startAnimating()
    }

    /// 停止播放图片组
    func stopPlayImages() {
        guard base.isAnimating else { return }
        base.stopAnimating()
    }
}

// MARK: - 决策判断

public extension AxcUIImageViewSpace {
    /// 是否有图片
    var isImageEmpty: Bool { return base.image == nil }
}

#endif
