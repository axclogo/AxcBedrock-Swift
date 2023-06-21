//
//  AxcNSColorEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

#if canImport(AppKit)

import AppKit

fileprivate extension AxcLazyCache.TableKey {
    /// 颜色转换缓存表，启用缓存
    static let nsColorTable = AxcLazyCache.Table("nsColor_table", enableCache: true)
}

// MARK: - 数据转换

public extension AxcSpace where Base: NSColor { }

// MARK: - 类方法

public extension AxcSpace where Base: NSColor { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: NSColor { }

// MARK: - 决策判断

public extension AxcSpace where Base: NSColor { }

#endif
