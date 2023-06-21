//
//  AxcNSViewEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/22.
//

#if canImport(AppKit)

import AppKit

// MARK: - 数据转换

public extension AxcSpace where Base: NSView { }

// MARK: - 类方法

public extension AxcSpace where Base: NSView { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: NSView {
    
    /// 添加一组视图
    /// - Parameter subviews: 视图合集
    func addSubviews(_ subviews: [NSView]) {
        base.subviews.forEach { base.addSubview($0) }
    }

    /// 移除所有View
    func removeAllSubviews() {
        base.subviews.forEach { $0.removeFromSuperview() }
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: NSView { }

#endif
