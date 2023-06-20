//
//  AxcCGImageEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/15.
//

import UIKit

// MARK: - 类方法/属性
public extension CGImage {
}

// MARK: - 属性 & Api
public extension CGImage {
    /// 图片旋转 0 - 320
    func axc_setRotate(angle: CGFloat) -> CGImage? {
        return axc_setRotate(radians: angle.axc_angleToRadian)
    }
    /// 图片旋转 0 - 2.pi
    func axc_setRotate(radians: CGFloat) -> CGImage? {
        let ciImage = CIImage(cgImage: self)
        return ciImage.axc_setRotate(radians: radians).axc_cgImage
    }
    
    /// 图片裁剪
    /// - Parameter rect: 裁剪范围单位为图片像素
    /// - Returns: 裁剪后的
    func axc_cropping(_ rect: CGRect) -> CGImage? {
        return cropping(to: rect)
    }
}

// MARK: - 决策判断
public extension CGImage {
}

// MARK: - 操作符
public extension CGImage {
}

// MARK: - 运算符
public extension CGImage {
}
