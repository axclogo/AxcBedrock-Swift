//
//  AxcShadowMaker.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/26.
//

#if os(macOS)
import AppKit

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit
#endif

// MARK: - [AxcMaker.Shadow]

public extension AxcMaker {
    /// 阴影相关
    struct Shadow {
        init(shadow: NSShadow) {
            self.shadow = shadow
        }

        var shadow: NSShadow
    }
}

// MARK: - AxcMaker.Shadow + AxcAssertUnifiedTransformTarget

extension AxcMaker.Shadow: AxcAssertUnifiedTransformTarget { }

public extension AxcMaker.Shadow {
    /// 设置阴影偏移量
    @discardableResult
    func set(offset: CGSize) -> Self {
        shadow.shadowOffset = offset
        return self
    }

    /// 设置阴影圆角
    @discardableResult
    func set(blurRadius: AxcUnifiedNumber) -> Self {
        shadow.shadowBlurRadius = assertTransformCGFloat(blurRadius)
        return self
    }

    /// 设置阴影颜色
    @discardableResult
    func set(shadowColor: AxcUnifiedColor) -> Self {
        #if os(macOS)
        shadow.shadowColor = assertTransformColor(shadowColor)
        #elseif os(iOS) || os(tvOS) || os(watchOS)
        shadow.shadowColor = assertTransformColor(shadowColor)
        #endif
        return self
    }
}
