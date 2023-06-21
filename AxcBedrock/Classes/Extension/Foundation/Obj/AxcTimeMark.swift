//
//  AxcTimeMark.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/12.
//

import Foundation

/// 时间标度
public typealias AxcTimeMark = AxcBedrockLib.TimeMark

// MARK: - [AxcBedrockLib.TimeMark]

public extension AxcBedrockLib {
    /// 时间标度
    struct TimeMark {
        /// 实例化
        /// - Parameters:
        ///   - years: 年
        ///   - months: 月
        ///   - weeks: 周
        ///   - days: 日
        ///   - hours: 时
        ///   - minutes: 分
        ///   - seconds: 秒
        public init(year: Int = 0,
                    month: Int = 0,
                    week: Int = 0,
                    day: Int = 0,
                    hour: Int = 0,
                    minute: Int = 0,
                    second: Int = 0) {
            self.year = year
            self.month = month
            self.week = week
            self.day = day
            self.hour = hour
            self.minute = minute
            self.second = second
        }

        /// 年
        public var year = 0
        /// 月
        public var month = 0
        /// 周
        public var week = 0
        /// 日
        public var day = 0
        /// 时
        public var hour = 0
        /// 分
        public var minute = 0
        /// 秒
        public var second = 0
    }
}

public extension AxcTimeMark {
    /// 转换成Date
    var date: Date? {
        return Date.Axc.Create(self)
    }
}
