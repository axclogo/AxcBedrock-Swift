//
//  AxcDateChunk.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/7.
//

import UIKit

public struct AxcDateChunk {
    /// 转换成Date
    public var axc_date: Date? {
        return Date(self)
    }
    
    /// 年
    public var years = 0
    /// 月
    public var months = 0
    /// 周
    public var weeks = 0
    /// 日
    public var days = 0
    /// 时
    public var hours = 0
    /// 分
    public var minutes = 0
    /// 秒
    public var seconds = 0
    
    public init() { }
    
    /// 实例化
    /// - Parameters:
    ///   - years: 年
    ///   - months: 月
    ///   - weeks: 周
    ///   - days: 日
    ///   - hours: 时
    ///   - minutes: 分
    ///   - seconds: 秒
    public init( years  : Int = 0,
                 months : Int = 0,
                 weeks  : Int = 0,
                 days   : Int = 0,
                 hours  : Int = 0,
                 minutes: Int = 0,
                 seconds: Int = 0) {
        self.years = years
        self.months = months
        self.weeks = weeks
        self.days = days
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
}
