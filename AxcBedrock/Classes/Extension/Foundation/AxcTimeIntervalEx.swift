//
//  AxcTimeIntervalEx.swift
//  Pods
//
//  Created by 赵新 on 2023/2/24.
//

import Foundation

// MARK: - 数据转换

public extension AxcSpace where Base == TimeInterval { }

// MARK: - 类方法

public extension AxcSpace where Base == TimeInterval {
    /// 秒
    static let Minute: TimeInterval = 60

    /// 小时
    static let Hour: TimeInterval = 60 * Minute

    /// 天
    static let Day: TimeInterval = 24 * Hour

    /// 周
    static let Week: TimeInterval = 7 * Day

    /// 年
    static let Year: TimeInterval = 365.25 * Day

    /// 月
    static let Month: TimeInterval = Year / 12
}

// MARK: - 属性 & Api

public extension AxcSpace where Base == TimeInterval { }

// MARK: - 决策判断

public extension AxcSpace where Base == TimeInterval { }
