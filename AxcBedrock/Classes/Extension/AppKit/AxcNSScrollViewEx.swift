//
//  AxcNSScrollViewEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 26/9/2023.
//
#if canImport(AppKit)

import AppKit

// MARK: - 数据转换

public extension AxcSpace where Base: NSScrollView { }

// MARK: - 类方法

public extension AxcSpace where Base: NSScrollView { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: NSScrollView {
    /// 滚动到最底部
    func scrollToBottom() {
        let contentView = base.contentView
        let documentVisibleRect = contentView.documentVisibleRect
        let documentRect = contentView.documentRect
        if documentVisibleRect.maxY < documentRect.maxY {
            let maxY = documentRect.maxY - documentVisibleRect.height
            let newOrigin = NSPoint(x: documentVisibleRect.origin.x, y: maxY)
            scrollTo(newOrigin)
        }
    }

    /// 滚动到某个位置
    func scrollTo(_ newOrigin: NSPoint) {
        let clipView = base.contentView
        let documentRect = clipView.documentRect
        let contentViewBounds = clipView.bounds
        let boundsOrigin = contentViewBounds.origin
        var constrainedOrigin = newOrigin
        constrainedOrigin.x = min(constrainedOrigin.x, documentRect.width - contentViewBounds.width)
        constrainedOrigin.x = max(constrainedOrigin.x, 0)
        constrainedOrigin.y = min(constrainedOrigin.y, documentRect.height - contentViewBounds.height)
        constrainedOrigin.y = max(constrainedOrigin.y, 0)
        if boundsOrigin != constrainedOrigin {
            clipView.setBoundsOrigin(constrainedOrigin)
        }
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: NSScrollView { }

#endif
