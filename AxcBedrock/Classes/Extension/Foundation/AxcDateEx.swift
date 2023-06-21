//
//  AxcDateEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2021/12/16.
//

import CoreGraphics
import Foundation

// MARK: - 扩展Date + AxcSpaceProtocol

extension Date: AxcSpaceProtocol {}

// MARK: - 数据转换

public extension AxcSpace where Base == Date {
    /// 常用时间戳格式
    enum TimeStamp: String {
        // MARK: 年月日

        /// "yyyy/MM/dd"
        case ymd_semicolon = "yyyy/MM/dd"
        /// "yyyy年MM月dd日"
        case ymd_cn = "yyyy年MM月dd日"
        /// "yyyy年MM月"
        case ym_cn = "yyyy年MM月"
        /// "yyyyMMdd"
        case integerLiteral = "yyyyMMdd"

        // MARK: 时分秒

        /// "HH:mm:ss"
        case hms_colon = "HH:mm:ss"
        /// "HH时mm分ss秒"
        case hms_cn = "HH时mm分ss秒"

        // MARK: 年月日+时分秒

        /// "dd/MM/yyyy HH:mm"
        case ymd_semicolon_Hm_colon = "dd/MM/yyyy HH:mm"
        /// "yyyy-MM-dd HH:mm:ss"
        case ymd_hms_iso8601 = "yyyy-MM-dd HH:mm:ss"
        /// "yyyy年MM月dd日 HH时mm分ss秒"
        case ymd_hms_cn = "yyyy年MM月dd日 HH时mm分ss秒"

        // MARK: 标准格式

        /// "EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss zzz"
        case rfc1123 = "EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss zzz"
        /// "EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z"
        case rfc850 = "EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z"
        /// "EEE MMM d HH':'mm':'ss yyyy"
        case asctime = "EEE MMM d HH':'mm':'ss yyyy"

        // MARK: iso8601

        /// yyyy-MM-dd'T'HH:mm:ss.SSS
        case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        /// "yyyy-MM-dd"
        case iso8601Day = "yyyy-MM-dd"
        /// "yyyy-MM"
        case iso8601Month = "yyyy-MM"
        /// "yyyy-MM-dd'T'HH:mmxxxxx"
        case iso8601MinHour = "yyyy-MM-dd'T'HH:mmxxxxx"
        /// "yyyy-MM-dd'T'HH:mm:ssxxxxx"
        case iso8601MinSec = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
        /// "yyyy-MM-dd'T'HH:mm:ss.SSSxxxxx"
        case iso8601MinSecMs = "yyyy-MM-dd'T'HH:mm:ss.SSSxxxxx"
    }

    /// 转换为String
    /// - Parameter format: 格式化枚举，默认iso8601Day
    /// - Returns: String
    func string(_ format: TimeStamp,
                identifier: AxcSpace<TimeZone>.TimeZoneIdentifier? = nil) -> String
    {
        return string(format.rawValue, identifier: identifier)
    }

    /// 转换为Stringƒ
    /// - Parameter format: 格式化字符串
    /// - Returns: String
    func string(_ format: String,
                identifier: AxcSpace<TimeZone>.TimeZoneIdentifier? = nil) -> String
    {
        return DateFormatter.Axc.Create(format: format, identifier: identifier)
            .string(from: base)
    }
}

// MARK: - 类方法

public extension AxcSpace where Base == Date {
    /// 创建一个指定的日期
    /// - Parameters:
    ///   - calendar: calendar
    ///   - timeZone: timeZone
    ///   - era: 世纪
    ///   - year: 年
    ///   - month: 月
    ///   - day: 日
    ///   - hour: 时
    ///   - minute: 分
    ///   - second: 秒
    ///   - millisecond: 毫秒
    ///   - nanosecond: 纳秒
    static func Create(calendar: Calendar? = .current,
                       timeZone: TimeZone? = NSTimeZone.default,
                       era: Int? = Date().axc.era,
                       year: Int? = Date().axc.year,
                       month: Int? = Date().axc.month,
                       day: Int? = Date().axc.day,
                       hour: Int? = Date().axc.hour,
                       minute: Int? = Date().axc.minute,
                       second: Int? = Date().axc.second,
                       nanosecond: Int? = Date().axc.nanosecond) -> Date?
    {
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = timeZone
        components.era = era
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = nanosecond
        guard let date = calendar?.date(from: components) else { return nil }
        return date
    }

    /// 创建一个指定的日期
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    ///   - day: 日
    static func Create(year: Int,
                       month: Int,
                       day: Int) -> Date?
    {
        return Create(year: year,
                      month: month,
                      day: day,
                      hour: 0,
                      minute: 0,
                      second: 0)
    }

    /// 根据时间标度来创建一个指定的日期
    static func Create(_ time: AxcTimeMark) -> Date? {
        return Create(year: time.year,
                      month: time.month,
                      day: time.day,
                      hour: time.hour,
                      minute: time.minute,
                      second: time.second)
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base == Date {
    // MARK: 允许get&set属性

    /// 日历对象
    fileprivate var calendar: Calendar {
        var calendar = Calendar(identifier: Calendar.current.identifier)
        calendar.timeZone = TimeZone.Axc.CreateOptional(identifier: .gmt(.GMT))!
        return calendar
    }

    /// 计算新日期方法
    fileprivate func calculateNewDate(newValue: Int,
                                      component: Calendar.Component) -> Date?
    {
        guard newValue > 0 else { return nil }
        var allowedRange: Range<Int>?
        switch component {
        case .year:
            allowedRange = calendar.range(of: .year, in: .era, for: base)
        case .month:
            allowedRange = calendar.range(of: .month, in: .year, for: base)
        case .day:
            allowedRange = calendar.range(of: .day, in: .month, for: base)
        case .hour:
            allowedRange = calendar.range(of: .hour, in: .day, for: base)
        case .minute:
            allowedRange = calendar.range(of: .minute, in: .hour, for: base)
        case .second:
            allowedRange = calendar.range(of: .second, in: .minute, for: base)
        case .nanosecond:
            #if targetEnvironment(macCatalyst)
                allowedRange = 0 ..< 1000000000
            #else
                allowedRange = calendar.range(of: .nanosecond, in: .second, for: base)
            #endif
        default: break
        }
        if component != .era { // 不是世纪
            guard let _allowedRange = allowedRange,
                  _allowedRange.contains(newValue) else { return nil }
        }
        let current = calendar.component(component, from: base)
        let toAdd = newValue - current
        let date = calendar.date(byAdding: component, value: toAdd, to: base)
        return date
    }

    /// 世纪
    var era: Int {
        get { return calendar.component(.era, from: base) }
        set {
            if let date = calculateNewDate(newValue: newValue, component: .era) {
                base = date
            }
        }
    }

    /// 年份
    var year: Int {
        get { return calendar.component(.year, from: base) }
        set {
            if let date = calculateNewDate(newValue: newValue, component: .year) {
                base = date
            }
        }
    }

    /// 月份
    var month: Int {
        get { return calendar.component(.month, from: base) }
        set {
            if let date = calculateNewDate(newValue: newValue, component: .month) {
                base = date
            }
        }
    }

    /// 天
    var day: Int {
        get { return calendar.component(.day, from: base) }
        set {
            if let date = calculateNewDate(newValue: newValue, component: .day) {
                base = date
            }
        }
    }

    /// 小时
    var hour: Int {
        get { return calendar.component(.hour, from: base) }
        set {
            if let date = calculateNewDate(newValue: newValue, component: .hour) {
                base = date
            }
        }
    }

    /// 分钟
    var minute: Int {
        get { return calendar.component(.minute, from: base) }
        set {
            if let date = calculateNewDate(newValue: newValue, component: .minute) {
                base = date
            }
        }
    }

    /// 秒
    var second: Int {
        get { return calendar.component(.second, from: base) }
        set {
            if let date = calculateNewDate(newValue: newValue, component: .second) {
                base = date
            }
        }
    }

    /// 纳秒
    var nanosecond: Int {
        get { return calendar.component(.nanosecond, from: base) }
        set {
            if let date = calculateNewDate(newValue: newValue, component: .nanosecond) {
                base = date
            }
        }
    }

    // MARK: 日期计算

    /// 获取昨天的时间，当前时间减一天
    var yesterday: Date {
        return change(.day, value: -1)
    }

    /// 获取明天的时间，当前时间加一天
    var tomorrow: Date {
        return change(.day, value: 1)
    }

    /// 日期增减修改
    func change(_ component: Calendar.Component, value: Int) -> Date {
        guard let newDate = calendar.date(byAdding: component, value: value, to: base) else { return base }
        return newDate
    }

    /// 计算相差天数
    func intervalDays(_ date: Date) -> Double {
        return intervalHours(date) / 24
    }

    /// 计算相差小时
    func intervalHours(_ date: Date) -> Double {
        return intervalMinutes(date) / 60
    }

    /// 计算相差分钟
    func intervalMinutes(_ date: Date) -> Double {
        return intervalSeconds(date) / 60
    }

    /// 计算相差秒数
    func intervalSeconds(_ date: Date) -> Double {
        return base.timeIntervalSince(date).axc.abs.axc.double // 取绝对值
    }

    /// 日期增减 依赖于AxcDateChunk
    func addTimeMark(_ chunk: AxcTimeMark, isAdd: Bool = true) -> Date {
        var components = DateComponents()
        let symbol = isAdd ? 1 : -1
        components.year = symbol * chunk.year
        components.month = symbol * chunk.month
        components.day = symbol * chunk.day + (chunk.week * 7)
        components.hour = symbol * chunk.hour
        components.minute = symbol * chunk.minute
        components.second = symbol * chunk.second
        return Calendar.autoupdatingCurrent.date(byAdding: components, to: base)!
    }

    /// 这个月有多少天
    var monthDayNum: Int { return calendar.range(of: .day, in: .month, for: base)!.count }

    // MARK: 星期

    /// 转换成星期几的中文字符串 "星期一"
    var weekNameCN: String {
        return weekNameCN { return "星期" }
    }

    /// 转换成周几的中文字符串    "周一"
    var cycleNameCN: String {
        return weekNameCN { return "周" }
    }

    /// 转换成周几的中文字符串
    func weekNameCN(prefixBlock: () -> String) -> String {
        let weekSuffix = ["日", "一", "二", "三", "四", "五", "六"][weekOfDay - 1]
        return prefixBlock() + weekSuffix
    }

    /// 这是本周的第几天 1=周日 2=周一 ... 7=周六
    var weekOfDay: Int { return calendar.component(.weekday, from: base) }
}

// MARK: - 决策判断

public extension AxcSpace where Base == Date {
    /// 是否大于当前时间？也就是是否是在未来
    var isFuture: Bool { return base > Date() }

    /// 是否小于当前时间？也就是是否是在过去
    var isPast: Bool { return base < Date() }

    /// 是否是今天
    var isToday: Bool { return calendar.isDateInToday(base) }

    /// 是否是昨天
    var isYesterday: Bool { return calendar.isDateInYesterday(base) }

    /// 是否是明天
    var isTomorrow: Bool { return calendar.isDateInTomorrow(base) }

    /// 是否是周末
    var isWeekend: Bool { return calendar.isDateInWeekend(base) }

    /// 是否是工作日
    var isWorkday: Bool { return !calendar.isDateInWeekend(base) }

    /// 是否是本周
    var isCurrentWeek: Bool { return calendar.isDate(base, equalTo: Date(), toGranularity: .weekOfYear) }
}

// MARK: - 实例化方法

public extension Date {}

// MARK: - 运算符/操作符

public extension Date {
    /// 日期选择加
    ///
    ///     Date() + 2.axc.days -> yp.date.day + 2
    ///
    /// - Parameters:
    ///   - ld: date
    ///   - rd: AxcDateChunk
    /// - Returns: date
    static func + (leftValue: Date, rightValue: AxcTimeMark) -> Date {
        return leftValue.axc.addTimeMark(rightValue, isAdd: true)
    }

    /// 日期选择减
    ///
    ///     Date() - 2.axc.days -> date.axc.day - 2
    ///
    /// - Parameters:
    ///   - ld: date
    ///   - rd: AxcDateChunk
    /// - Returns: date
    static func - (leftValue: Date, rightValue: AxcTimeMark) -> Date {
        return leftValue.axc.addTimeMark(rightValue, isAdd: false)
    }
}
