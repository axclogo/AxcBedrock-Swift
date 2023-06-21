//
//  AxcDataEx+AppKit.swift
//  Pods-AxcBedrock_Example
//
//  Created by 赵新 on 2023/2/21.
//

#if canImport(AppKit)

import AppKit

// MARK: - 数据转换

public extension AxcSpace where Base == Data {
    /// data转图片
    var nsImage: NSImage? {
        return NSImage(data: base)
    }
}

// MARK: - 类方法

public extension AxcSpace where Base == Data { }

// MARK: - 属性 & Api

public extension AxcSpace where Base == Data { }

// MARK: - 决策判断

public extension AxcSpace where Base == Data { }

#endif
