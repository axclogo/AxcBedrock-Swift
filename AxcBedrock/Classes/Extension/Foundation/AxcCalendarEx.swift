//
//  AxcCalendarEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/15.
//

import Foundation

// MARK: - 扩展Calendar + AxcSpaceProtocol

extension Calendar: AxcSpaceProtocol {}

// MARK: - 数据转换

public extension AxcSpace where Base == Calendar {}

// MARK: - 类方法

public extension AxcSpace where Base == Calendar {}

// MARK: - 属性 & Api

public extension AxcSpace where Base == Calendar {
    /// 根据传入时间，获取这个月有多少天
    ///
    ///        let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///        Calendar.current.numberOfDaysInMonth(for: date) -> 31
    ///
    /// - Parameter date: 时间
    /// - Returns: 这个月份的天数
    func dayCount(for date: Date) -> Int {
        return base.range(of: .day, in: .month, for: date)!.count
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base == Calendar {}
