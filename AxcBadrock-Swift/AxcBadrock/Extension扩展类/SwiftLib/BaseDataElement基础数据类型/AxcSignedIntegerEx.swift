//
//  AxcSignedIntegerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/3.
//

import UIKit

// MARK: - 数据转换
public extension SignedInteger {
    // MARK: 基础转换
    /// 转换为k单位的数据字符串
    /// 1k, -2k, 100k, 1kk, -5kk..
    var axc_unit_K: String {
        var sign: String                        { return self >= 0 ? "" : "-" }
        let abs = Int(axc_abs)
        if abs == 0                             { return "0k" }
        else if abs >= 0, abs < 1000            { return "0k" }
        else if abs >= 1000, abs < 1_000_000    { return String(format: "\(sign)%ik", abs / 1000) }
        return String(format: "\(sign)%ikk", abs / 100_000)
    }
    
    /// 转换为罗马数字
    var axc_roman: String? {
        guard self > 0 else {  return nil }
        let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        var romanValue = ""
        var startingValue = self
        for (index, romanChar) in romanValues.enumerated() {
            let arabicValue = arabicValues[index]
            let div = Int(startingValue) / arabicValue
            for _ in 0..<div {
                romanValue.append(romanChar)
            }
            startingValue -= Self(arabicValue * div)
        }
        return romanValue
    }
    
    /// 秒数Int类型转换为XXh XXm时间戳
    var axc_timeStr: String {
        guard self > 0 else { return "0 sec" }
        if self < 60 { return "\(self) sec" }
        if self < 3600 {  return "\(self / 60) min" }
        let hours = self / 3600
        let mins = (self % 3600) / 60
        if hours != 0, mins == 0 { return "\(hours)h" }
        return "\(hours)h \(mins)m"
    }
    
}

// MARK: - 属性 & Api
public extension SignedInteger {
    /// 取绝对值
    var axc_abs: Self { return Swift.abs(self) }
}

// MARK: - 时间语法糖扩展
public extension SignedInteger {
    /// 年
    var axc_years: AxcDateChunk {
        return AxcDateChunk(years: Int(self))
    }
    /// 月
    var axc_months: AxcDateChunk {
        return AxcDateChunk(months: Int(self))
    }
    /// 周
    var axc_weeks: AxcDateChunk {
        return AxcDateChunk(weeks: Int(self))
    }
    /// 日
    var axc_days: AxcDateChunk {
        return AxcDateChunk(days: Int(self))
    }
    /// 时
    var axc_hours: AxcDateChunk {
        return AxcDateChunk(hours: Int(self))
    }
    /// 分
    var axc_minutes: AxcDateChunk {
        return AxcDateChunk(minutes: Int(self))
    }
    /// 秒
    var axc_seconds: AxcDateChunk {
        return AxcDateChunk(seconds: Int(self))
    }
}

// MARK: - 决策判断
public extension SignedInteger {
    /// 是否为正数
    var axc_isPositive: Bool { return self > 0 }
    /// 是否为负数
    var axc_isNegative: Bool { return self < 0 }
    /// 是否为偶数
    var axc_isEven: Bool { return (self % 2) == 0 }
    /// 是否为奇数
    var axc_isOdd: Bool { return (self % 2) != 0 }
}

// MARK: - 数学运算
public extension SignedInteger {
    /// 整数值与number的最大公约数 递归
    func axc_gcd(_ number: Self) -> Self {
        return number == 0 ? self : number.axc_gcd(self % number)
    }
    
    /// 整数与n的最小公倍数
    func axc_lcm(_ number: Self) -> Self {
        return (self * number).axc_abs / axc_gcd(number)
    }
}

