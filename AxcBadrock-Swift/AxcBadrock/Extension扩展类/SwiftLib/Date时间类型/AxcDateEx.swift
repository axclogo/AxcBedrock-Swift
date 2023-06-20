//
//  AxcDateEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/4.
//

import UIKit

// MARK: - 日期常量
/// 常用时间戳格式
public struct AxcTimeStamp {
    // MARK: 年月日
    /// "yyyy/MM/dd"
    public static var ymd_semicolon             = "yyyy/MM/dd"
    /// "yyyy年MM月dd日"
    public static var ymd_cn                    = "yyyy年MM月dd日"
    /// "yyyyMMdd"
    public static var integerLiteral            = "yyyyMMdd"
    // MARK: 时分秒
    /// "HH:mm:ss"
    public static var hms_colon                 = "HH:mm:ss"
    /// "HH时mm分ss秒"
    public static var hms_cn                    = "HH时mm分ss秒"
    // MARK: 年月日+时分秒
    /// "dd/MM/yyyy HH:mm"
    public static var ymd_semicolon_Hm_colon    = "dd/MM/yyyy HH:mm"
    /// "yyyy-MM-dd HH:mm:ss"
    public static var ymd_hms_iso8601           = "yyyy-MM-dd HH:mm:ss"
    /// "yyyy年MM月dd日 HH时mm分ss秒"
    public static var ymd_hms_cn                = "yyyy年MM月dd日 HH时mm分ss秒"
    // MARK: 标准格式
    /// "EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss zzz"
    public static var rfc1123                   = "EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss zzz"
    /// "EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z"
    public static var rfc850                    = "EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z"
    /// "EEE MMM d HH':'mm':'ss yyyy"
    public static var asctime                   = "EEE MMM d HH':'mm':'ss yyyy"
    // MARK: iso8601
    /// yyyy-MM-dd'T'HH:mm:ss.SSS
    public static var iso8601                   = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    /// "yyyy-MM-dd"
    public static var iso8601Day                = "yyyy-MM-dd"
    /// "yyyy-MM-dd'T'HH:mmxxxxx"
    public static var iso8601MinHour            = "yyyy-MM-dd'T'HH:mmxxxxx"
    /// "yyyy-MM-dd'T'HH:mm:ssxxxxx"
    public static var iso8601MinSec             = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
    /// "yyyy-MM-dd'T'HH:mm:ss.SSSxxxxx"
    public static var iso8601MinSecMs           = "yyyy-MM-dd'T'HH:mm:ss.SSSxxxxx"
}

// MARK: - 数据转换
public extension Date {
    /// 转换为String类型
    func axc_string(format: String =  AxcTimeStamp.ymd_hms_cn) -> String {
        return Date.axc_dateFormatter(format: format).string(from: self)
    }
    
    /// 转换为iso1861格式时间戳
    var axc_iso8601Str: String {
        return axc_string(format: AxcTimeStamp.iso8601)
    }
    
    /// 转换成过去时间字符串 "2 分钟前"
    var axc_passedTimeCN: String {
        return axc_passedTime { () -> String in return "刚刚"
        } suffixBlock: { (dateComponents, component) -> String in
            var str: String
            switch component{
            case .year:     str = "年"
            case .month:    str = "个月"
            case .day:      str = "天"
            case .hour:     str = "小时"
            case .minute:   str = "分钟"
            case .second:   str = "秒"
            default: str = "UnKnow" }
            return str + "前"
        }
    }
    /// 转换成过去时间字符串 "2 minute ago"
    var axc_passedTimeEN: String {
        return axc_passedTime { () -> String in return "Just now"
        } suffixBlock: { (dateComponents, component) -> String in
            var str: String
            switch component{
            case .year: dateComponents.year == 1     ? (str = " year")   : (str = " years")
            case .month: dateComponents.month == 1   ? (str = " month")  : (str = " months")
            case .day: dateComponents.day == 1       ? (str = " day")    : (str = " days")
            case .hour: dateComponents.hour == 1     ? (str = " hour")   : (str = " hour")
            case .minute: dateComponents.minute == 1 ? (str = " minute") : (str = " minutes")
            case .second: dateComponents.second == 1 ? (str = " second") : (str = " seconds")
            default: str = "" }
            return str + " ago"
        }
    }
    /// 计算并格式化获取过去多少时间的时间戳
    /// - Parameters:
    ///   - nowBlock: 当过去一小会，也就是现在，可以返回如“刚刚”
    ///   - suffixBlock: 设置前缀 可以返回“年” 如“X 年前”
    /// - Returns: 格式化后的字符串
    func axc_passedTime( nowBlock: () -> String,
                         suffixBlock: (_ dateComponents: DateComponents, _ component: Calendar.Component) -> String ) -> String {
        let components = axc_calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        if components.year! >= 1        { return "\(components.year!)"   + suffixBlock(components,.year) }
        else if components.month! >= 1  { return "\(components.month!)"  + suffixBlock(components,.month) }
        else if components.day! >= 1    { return "\(components.day!)"    + suffixBlock(components,.day) }
        else if components.hour! >= 1   { return "\(components.hour!)"   + suffixBlock(components,.hour) }
        else if components.minute! >= 1 { return "\(components.minute!)" + suffixBlock(components,.minute) }
        else if components.second! >= 1 { return "\(components.second!)" + suffixBlock(components,.second) }
        else { return nowBlock() }
    }
    
    /// 转换成星期几的英文字符串 "Sunday"
    var axc_weekNameEN: String {
        return axc_dayName(style: .full)
    }
    /// 转换成星期几的中文字符串 "星期一"
    var axc_weekNameCN: String {
        return axc_weekNameCN {  return "星期" }
    }
    /// 转换成周几的中文字符串    "周一"
    var axc_cycleNameCN: String {
        return axc_weekNameCN {  return "周" }
    }
    /// 转换成周几的中文字符串
    func axc_weekNameCN(prefixBlock: () -> String ) -> String {
        let weekSuffix = ["日","一","二","三","四","五","六"][axc_weekOfDay-1]
        return prefixBlock() + weekSuffix
    }
    
    
    // MARK: 时间就近转换
    private var _components: DateComponents {
        return axc_calendar.dateComponents( [.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self)
    }
    /// 将分钟数转换为最近的5分钟
    ///
    ///     var date = Date() // "5:54 PM"
    ///     date.axc_minute = 32 // "5:32 PM"
    ///     date.axc_nearestFiveMinutes // "5:30 PM"
    ///
    var axc_nearestFiveMinutes: Date {
        var components = _components
        let min = components.minute!
        components.minute = min % 5 < 3 ? min - min % 5 : min + 5 - (min % 5)
        components.second = 0
        components.nanosecond = 0
        return axc_calendar.date(from: components)!
    }
    /// 将分钟数转换为最近的10分钟
    ///
    ///     var date = Date() // "5:54 PM"
    ///     date.axc_minute = 32 // "5:32 PM"
    ///     date.axc_nearestFiveMinutes // "5:30 PM"
    ///
    var axc_nearestTenMinutes: Date {
        var components = _components
        let min = components.minute!
        components.minute = min % 10 < 6 ? min - min % 10 : min + 10 - (min % 10)
        components.second = 0
        components.nanosecond = 0
        return axc_calendar.date(from: components)!
    }
    /// 将分钟数转换为最近的15分钟
    ///
    ///     var date = Date() // "5:54 PM"
    ///     date.axc_minute = 32 // "5:32 PM"
    ///     date.axc_nearestFiveMinutes // "5:30 PM"
    ///
    var axc_nearestQuarterHour: Date {
        var components = _components
        let min = components.minute!
        components.minute = min % 15 < 8 ? min - min % 15 : min + 15 - (min % 15)
        components.second = 0
        components.nanosecond = 0
        return axc_calendar.date(from: components)!
    }
    /// 将分钟数转换为最近的30分钟
    ///
    ///     var date = Date() // "5:54 PM"
    ///     date.axc_minute = 32 // "5:32 PM"
    ///     date.axc_nearestFiveMinutes // "5:30 PM"
    ///
    var axc_nearestHalfHour: Date {
        var components = _components
        let min = components.minute!
        components.minute = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
        components.second = 0
        components.nanosecond = 0
        return axc_calendar.date(from: components)!
    }
    /// 将分钟数转换为最近的1小时
    ///
    ///     var date = Date() // "5:54 PM"
    ///     date.axc_minute = 32 // "5:32 PM"
    ///     date.axc_nearestFiveMinutes // "5:00 PM"
    ///
    var axc_nearestHour: Date {
        let min = axc_calendar.component(.minute, from: self)
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour]
        let date = axc_calendar.date(from: axc_calendar.dateComponents(components, from: self))!
        if min < 30 { return date }
        return axc_calendar.date(byAdding: .hour, value: 1, to: date)!
    }
}

// MARK: - 类方法/属性
public extension Date {
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
    init?( calendar: Calendar,
           timeZone: TimeZone? = NSTimeZone.default,
           era: Int?        = Date().axc_era,
           year: Int?       = Date().axc_year,
           month: Int?      = Date().axc_month,
           day: Int?        = Date().axc_day,
           hour: Int?       = Date().axc_hour,
           minute: Int?     = Date().axc_minute,
           second: Int?     = Date().axc_second,
           nanosecond: Int? = Date().axc_nanosecond) {
        var components      = DateComponents()
        components.calendar = calendar
        components.timeZone = timeZone
        components.era      = era
        components.year     = year
        components.month    = month
        components.day      = day
        components.hour     = hour
        components.minute   = minute
        components.second   = second
        components.nanosecond = nanosecond
        guard let date = calendar.date(from: components) else { return nil }
        self = date
    }
    /// 创建一个指定的日期
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    ///   - day: 日
    init?(year: Int, month: Int, day: Int) {
        self.init(calendar: .current, year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
    }
    /// 创建一个指定的日期
    init?(_ chunk: AxcDateChunk) {
        self.init(calendar: .current,
                  year: chunk.years,
                  month: chunk.months,
                  day: chunk.days,
                  hour: chunk.hours,
                  minute: chunk.minutes,
                  second: chunk.seconds)
    }
    /// 使用字符串和格式实例化一个日期
    /// - Parameters:
    ///   - dateString: 字符串时间
    ///   - format: 时间的格式
    init?(dateString: String, format: String) {
        let dateFormatter = Date.axc_dateFormatter(format: format)
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        self = date
    }
    
    /// 使用iso8601Str实力化一个Date
    init?(iso8601Str: String) {
        let dateFormatter = Date.axc_dateFormatter(format: AxcTimeStamp.iso8601)
        guard let date = dateFormatter.date(from: iso8601Str) else { return nil }
        self = date
    }
    /// 通过UNIX时间戳实力化一个Date 但在2038年可能会出问题
    init(unixTimestamp: Double) {
        self.init(timeIntervalSince1970: unixTimestamp)
    }
    /// 通过长整型时间，如20210207 -> "2021-02-07 00:00:00 +0000"
    init?(integerLiteral value: Int) {
        guard let date = Date.axc_dateFormatter(format: AxcTimeStamp.integerLiteral).date(from: String(value)) else { return nil }
        self = date
    }
    
    /// 格式对象
    static var axc_dateFormatter: DateFormatter {
        return axc_dateFormatter()
    }
    /// 格式对象 identifier: 中国zh_CN
    static func axc_dateFormatter(format: String = AxcTimeStamp.ymd_hms_cn, identifier: String? = nil) -> DateFormatter {
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "zh_CN")\UTC
        if let identifier = identifier{
            dateFormatter.timeZone = TimeZone(identifier: identifier)
        }
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}

// MARK: - 属性 & Api
public extension Date {
    /// 日历对象
    var axc_calendar: Calendar {
        var calendar = Calendar(identifier: Calendar.current.identifier)
        calendar.timeZone = TimeZone(identifier: "UTC") ?? .current
        return calendar
    }
    
    // MARK: 允许get&set属性
    /// 年份
    var axc_year: Int {
        get { return axc_calendar.component(.year, from: self) }
        set { guard newValue > 0 else { return }
            let currentYear = axc_calendar.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = axc_calendar.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }
    /// 月份
    var axc_month: Int {
        get {  return axc_calendar.component(.month, from: self) }
        set { let allowedRange = axc_calendar.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentMonth = axc_calendar.component(.month, from: self)
            let monthsToAdd = newValue - currentMonth
            if let date = axc_calendar.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }
    /// 天
    var axc_day: Int {
        get { return axc_calendar.component(.day, from: self) }
        set { let allowedRange = axc_calendar.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentDay = axc_calendar.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = axc_calendar.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }
    /// 小时
    var axc_hour: Int {
        get { return axc_calendar.component(.hour, from: self) }
        set { let allowedRange = axc_calendar.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentHour = axc_calendar.component(.hour, from: self)
            let hoursToAdd = newValue - currentHour
            if let date = axc_calendar.date(byAdding: .hour, value: hoursToAdd, to: self) {
                self = date
            }
        }
    }
    /// 分钟
    var axc_minute: Int {
        get { return axc_calendar.component(.minute, from: self) }
        set { let allowedRange = axc_calendar.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentMinutes = axc_calendar.component(.minute, from: self)
            let minutesToAdd = newValue - currentMinutes
            if let date = axc_calendar.date(byAdding: .minute, value: minutesToAdd, to: self) {
                self = date
            }
        }
    }
    /// 秒
    var axc_second: Int {
        get { return axc_calendar.component(.second, from: self) }
        set { let allowedRange = axc_calendar.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentSeconds = axc_calendar.component(.second, from: self)
            let secondsToAdd = newValue - currentSeconds
            if let date = axc_calendar.date(byAdding: .second, value: secondsToAdd, to: self) {
                self = date
            }
        }
    }
    /// 从1970至今的秒数
    var axc_second1970: Int {
        return timeIntervalSince1970.axc_int
    }
    
    /// 毫秒
    var axc_millisecond: Int {
        get { return axc_calendar.component(.nanosecond, from: self) / 1_000_000 }
        set { let nanoSeconds = newValue * 1_000_000
            #if targetEnvironment(macCatalyst)
            let allowedRange = 0..<1_000_000_000
            #else
            let allowedRange = axc_calendar.range(of: .nanosecond, in: .second, for: self)!
            #endif
            guard allowedRange.contains(nanoSeconds) else { return }
            if let date = axc_calendar.date(bySetting: .nanosecond, value: nanoSeconds, of: self) {
                self = date
            }
        }
    }
    /// 纳秒
    var axc_nanosecond: Int {
        get { return axc_calendar.component(.nanosecond, from: self) }
        set {
            #if targetEnvironment(macCatalyst)
            let allowedRange = 0..<1_000_000_000
            #else
            let allowedRange = axc_calendar.range(of: .nanosecond, in: .second, for: self)!
            #endif
            guard allowedRange.contains(newValue) else { return }
            let currentNanoseconds = axc_calendar.component(.nanosecond, from: self)
            let nanosecondsToAdd = newValue - currentNanoseconds
            if let date = axc_calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// 零点
    var axc_zero: Date? {
        let calendar:Calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>.init(arrayLiteral: .year,.month,.day,.hour,.minute,.second)
        var components = calendar.dateComponents(unitFlags, from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        return calendar.date(from: components)
    }
}

// MARK: - 获取换算
public extension Date {
    // MARK: 名称获取
    /// 时间名字样式
    enum AxcTimeNameStyle {
        /// 只显示一个单词
        case oneLetter
        /// 显示三个单词
        case threeLetters
        /// 全部显示
        case full
    }
    /// 获取天的名称
    ///
    ///     Date().axc_dayName(style: .oneLetter) -> "T"
    ///     Date().axc_dayName(style: .threeLetters) -> "Thu"
    ///     Date().axc_dayName(style: .full) -> "Thursday"
    ///
    func axc_dayName(style: AxcTimeNameStyle = .full) -> String {
        let dateFormatter = Date.axc_dateFormatter
        var format: String {
            switch style {
            case .oneLetter:    return "EEEEE"
            case .threeLetters: return "EEE"
            case .full:         return "EEEE"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
    
    /// 获取月的名称
    ///
    ///     Date().axc_monthName(style: .oneLetter) -> "J"
    ///     Date().axc_monthName(style: .threeLetters) -> "Jan"
    ///     Date().axc_monthName(style: .full) -> "January"
    ///
    func axc_monthName(ofStyle style: AxcTimeNameStyle = .full) -> String {
        let dateFormatter = Date.axc_dateFormatter
        var format: String {
            switch style {
            case .oneLetter:    return "MMMMM"
            case .threeLetters: return "MMM"
            case .full:         return "MMMM"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
    
    // MARK: 与年相关的跨度
    /// 世纪
    var axc_era: Int { return axc_calendar.component(.era, from: self) }
    
    /// 第几季度
    var axc_quarter: Int {
        let month = Double(axc_calendar.component(.month, from: self))
        let numberOfMonths = Double(axc_calendar.monthSymbols.count)
        let numberOfMonthsInQuarter = numberOfMonths / 4
        return Int(ceil(month / numberOfMonthsInQuarter))
    }
    
    /// 本年的第几周
    var axc_weekOfYear: Int { return axc_calendar.component(.weekOfYear, from: self) }
    
    /// 本月的第几周
    var axc_weekOfMonth: Int { return axc_calendar.component(.weekOfMonth, from: self) }
    
    /// 这是本周的第几天 1=周日 2=周一 ... 7=周六
    var axc_weekOfDay: Int { return axc_calendar.component(.weekday, from: self) }
    
    /// 这个月有多少天
    var axc_monthDayNum: Int { return axc_calendar.range(of: .day, in: .month, for: self)!.count }
    
    
    // MARK: 日期计算
    /// 获取昨天的时间，当前时间减一天
    var axc_yesterday: Date {
        return axc_add(.day, value: -1)
    }

    /// 获取明天的时间，当前时间加一天
    var axc_tomorrow: Date {
        return axc_add(.day, value: 1)
    }
    
    /// 日期增减
    func axc_add(_ component: Calendar.Component, value: Int) -> Date {
        return axc_calendar.date(byAdding: component, value: value, to: self)!
    }
    /// 日期增减 依赖于AxcDateChunk
    func axc_addDateChunk(_ chunk: AxcDateChunk, isAdd: Bool = true) -> Date {
        var components = DateComponents()
        let symbol = isAdd ? 1 : -1
        components.year      = symbol * chunk.years
        components.month     = symbol * chunk.months
        components.day       = symbol * chunk.days + (chunk.weeks*7)
        components.hour      = symbol * chunk.hours
        components.minute    = symbol * chunk.minutes
        components.second    = symbol * chunk.seconds
        return Calendar.autoupdatingCurrent.date(byAdding: components, to: self)!
    }
    
    /// 日期修改
    func axc_change(_ component: Calendar.Component, value: Int) -> Date? {
        var date = self
        switch component {
        case .nanosecond:   date.axc_nanosecond = value
        case .second:       date.axc_second = value
        case .minute:       date.axc_minute = value
        case .hour:         date.axc_hour = value
        case .day:          date.axc_day = value
        case .month:        date.axc_month = value
        case .year:         date.axc_year = value
        default: return axc_calendar.date(bySetting: component, value: value, of: self)
        }
        return date
    }
    
    /// 计算相差天数
    func axc_intervalDays(_ date: Date) -> Double {
        return axc_intervalHours(date) / 24
    }
    /// 计算相差小时
    func axc_intervalHours(_ date: Date) -> Double {
        return axc_intervalMinutes(date) / 60
    }
    /// 计算相差分钟
    func axc_intervalMinutes(_ date: Date) -> Double {
        return axc_intervalSeconds(date) / 60
    }
    /// 计算相差秒数
    func axc_intervalSeconds(_ date: Date) -> Double {
        return timeIntervalSince(date).axc_abs.axc_double  // 取绝对值
    }
    
    /// 是否是同一天
    /// - Parameter day: 天的时间
    /// - Returns: Bool
    func axc_isSame(day: Date) -> Bool{
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = .init(arrayLiteral: .year, .month,.day)
        let comp1 = calendar.dateComponents(components, from: self)
        let comp2 = calendar.dateComponents(components, from: day)
        return comp1.year == comp2.year && comp1.month == comp2.month && comp1.day == comp2.day
    }
    
    /// 是否是同一天
    /// - Parameter day: 天的时间
    /// - Returns: Bool
    func axc_isSame(mouth: Date) -> Bool{
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = .init(arrayLiteral: .year, .month)
        let comp1 = calendar.dateComponents(components, from: self)
        let comp2 = calendar.dateComponents(components, from: mouth)
        return comp1.year == comp2.year && comp1.month == comp2.month
    }
    
    /// 是否是同一天
    /// - Parameter day: 天的时间
    /// - Returns: Bool
    func axc_isSame(year: Date) -> Bool{
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = .init(arrayLiteral: .year)
        let comp1 = calendar.dateComponents(components, from: self)
        let comp2 = calendar.dateComponents(components, from: year)
        return comp1.year == comp2.year
    }
    
    /// 返回date相对于self的时间差距，正数就是 date的时间大于self
    /// - Parameters:
    ///   - date: 比对的时间
    ///   - components: 比对类型
    /// - Returns: 相差数组
    func axc_dateOffest(by date: Date, for components: Set<Calendar.Component>) -> [Calendar.Component:Int] {
        let calendar = Calendar.current
        let comp1 = calendar.dateComponents(components, from: self)
        let comp2 = calendar.dateComponents(components, from: date)
        var dict: [Calendar.Component:Int] = [:]
        components.forEach { component in
            var offest: Int = 0
            if let first = comp1.value(for: component),
               let last =  comp2.value(for: component){
                offest = last - first
            }
            dict[component] = offest
        }
        return dict
    }
    
    func axc_dayOffest(by date: Date) -> Int?{
        return axc_dateOffest(by: date, for: .init(arrayLiteral: .year,.month,.day))[.day] ?? 0
    }
}

// MARK: - 决策判断
public extension Date {
    /// 是否大于当前时间？也就是是否是在未来
    var axc_isFuture: Bool { return self > Date() }
    
    /// 是否小于当前时间？也就是是否是在过去
    var axc_isPast: Bool { return self < Date() }
    
    /// 是否是今天
    var axc_isToday: Bool { return axc_calendar.isDateInToday(self) }
    
    /// 是否是昨天
    var axc_isYesterday: Bool { return axc_calendar.isDateInYesterday(self) }
    
    /// 是否是明天
    var axc_isTomorrow: Bool { return axc_calendar.isDateInTomorrow(self) }
    
    /// 是否是周末
    var axc_isWeekend: Bool { return axc_calendar.isDateInWeekend(self) }
    
    /// 是否是工作日
    var axc_isWorkday: Bool { return !axc_calendar.isDateInWeekend(self) }
    
    /// 是否是本周
    var axc_isCurrentWeek: Bool { return axc_calendar.isDate(self, equalTo: Date(), toGranularity: .weekOfYear) }
    
    /// 是否是周日
    var axc_isSunday: Bool { return axc_weekOfDay == 1 }
    
    /// 是否是周六
    var axc_isSaturday: Bool { return axc_weekOfDay == 7 }
    
    /// 是否是本月
    var axc_isCurrentMonth: Bool { return axc_calendar.isDate(self, equalTo: Date(), toGranularity: .month) }

    /// 是否是今年
    var axc_isCurrentYear: Bool {  return axc_calendar.isDate(self, equalTo: Date(), toGranularity: .year) }
    
    /// 是否是闰年
    var axc_isLeapYear: Bool {
        let yearComponent = axc_calendar.component(.year, from: self)
        if yearComponent % 400 == 0 { return true  }
        if yearComponent % 100 == 0 { return false }
        if yearComponent % 4   == 0 { return true  }
        return false
    }
    
    /// 校验一个日期是否在两个日期之间
    /// - Parameters:
    ///   - startDate: 起始日期
    ///   - endDate: 结束日期
    ///   - includeBounds: 是否包含
    func axc_isBetween(_ startDate: Date, _ endDate: Date, includeBounds: Bool = false) -> Bool {
        if includeBounds { return startDate.compare(self).rawValue * compare(endDate).rawValue >= 0 }
        return startDate.compare(self).rawValue * compare(endDate).rawValue > 0
    }
    
}

// MARK: - 运算符
public extension Date {
    /// 日期选择加
    ///
    ///     Date() + 2.axc_days -> axc_date.day + 2
    ///
    /// - Parameters:
    ///   - ld: date
    ///   - rd: AxcDateChunk
    /// - Returns: date
    static func + (leftValue: Date, rightValue: AxcDateChunk) -> Date {
        return leftValue.axc_addDateChunk(rightValue)
    }
    
    /// 日期选择减
    ///
    ///     Date() - 2.axc_days -> date.axc_day - 2
    ///
    /// - Parameters:
    ///   - ld: date
    ///   - rd: AxcDateChunk
    /// - Returns: date
    static func - (leftValue: Date, rightValue: AxcDateChunk) -> Date {
        return leftValue.axc_addDateChunk(rightValue, isAdd: false)
    }
}
