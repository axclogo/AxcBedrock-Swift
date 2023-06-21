//
//  AxcUIColorEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/19.
//

#if canImport(UIKit)

import UIKit

fileprivate extension AxcLazyCache.TableKey {
    /// 颜色转换缓存表，启用缓存
    static let uiColorTable = AxcLazyCache.Table("uiColor_table", enableCache: true)
}

// MARK: - 数据转换

public extension AxcSpace where Base == UIColor {
    /// 颜色生成图片
    var uiImage: UIImage? {
        return uiImage()
    }

    /// 颜色生成图片
    func uiImage(size: CGSize = .Axc.Create(1)) -> UIImage? {
        let rect: CGRect = .init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(cgColor)
        context.fill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsGetCurrentContext()
        return image
    }
}

// MARK: - 类方法

public extension AxcSpace where Base == UIColor { }

// MARK: - 属性 & Api

public extension AxcSpace where Base == UIColor { }

// MARK: - 获取

public extension AxcSpace where Base == UIColor { }

// MARK: - 决策判断

public extension AxcSpace where Base == UIColor { }

#endif
