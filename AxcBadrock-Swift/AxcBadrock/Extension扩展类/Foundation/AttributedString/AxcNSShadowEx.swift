//
//  AxcNSShadowEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/5.
//

import UIKit

// MARK: - 属性 & Api
public extension NSShadow {
    /// 设置阴影偏移量
    func axc_setOffset(_ offset: CGSize) -> NSShadow {
        shadowOffset = offset
        return self
    }
    /// 设置阴影圆角
    func axc_setBlurRadius(_ blurRadius: CGFloat) -> NSShadow {
        shadowBlurRadius = blurRadius
        return self
    }
    /// 设置阴影颜色
    func axc_setColor(_ color: AxcUnifiedColorTarget) -> NSShadow {
        shadowColor = color.axc_cgColor
        return self
    }
}

