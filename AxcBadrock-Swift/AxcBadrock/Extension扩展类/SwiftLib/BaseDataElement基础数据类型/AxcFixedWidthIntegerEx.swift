//
//  AxcFixedWidthIntegerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/19.
//

import UIKit

/**
 Swift4.0 新特性:
                +-------------+   +-------------+
        +------>+   Numeric   |   | Comparable  |
        |       |   (+,-,*)   |   | (==,<,>,...)|
        |       +------------++   +---+---------+
        |                     ^       ^
+-------+------------+        |       |
|    SignedNumeric   |      +-+-------+-----------+
|     (unary -)      |      |    BinaryInteger    |
+------+-------------+      |(words,%,bitwise,...)|
       ^                    ++---+-----+----------+
       |         +-----------^   ^     ^---------------+
       |         |               |                     |
+------+---------++    +---------+---------------+  +--+----------------+
|  SignedInteger  |    |  FixedWidthInteger      |  |  UnsignedInteger  |
|                 |    |(endianness,overflow,...)|  |                   |
+---------------+-+    +-+--------------------+--+  +-+-----------------+
                ^        ^                    ^       ^
                |        |                    |       |
                |        |                    |       |
                 ++--------+-+                +-+-------+-+
                 |Int family |-+              |UInt family|-+
                 +-----------+ |              +-----------+ |
                   +-----------+                +-----------+
 */


// MARK: - 类方法/属性
public extension FixedWidthInteger {
    /// 最大值
    static var axc_max: Self { return max }
    /// 最小值
    static var axc_min: Self { return min }
    
    /// 秒级-当前时间
    static var axc_secondsTime: Self { return Self(Date().axc_second) }
    
    /// 毫秒级-当前时间
    static var axc_milliTime: Self { return Self(Date().axc_millisecond) }
}
// MARK: - 数据转换
public extension FixedWidthInteger {
    /// 转换成row
    var axc_row: IndexPath { return IndexPath(row: Int(self)) }
    /// 转换成section
    var axc_section: IndexPath { return IndexPath(section: Int(self)) }
}

// MARK: - 决策判断
public extension FixedWidthInteger {
    /// 是否为素数
    /// 警告：使用大数在计算上可能会很费时
    var axc_isPrime: Bool {
        if self == 2 { return true }
        guard self > 1, self % 2 != 0 else { return false }
        let base = Int(sqrt(Double(self)))
        for int in Swift.stride(from: 3, through: base, by: 2) where Int(self) % int == 0 { return false }
        return true
    }
}

// MARK: - 操作符
public extension FixedWidthInteger {
    /// 获取固定长度整数的第几位，个十百千万
    ///
    ///     let value = 123456789[3] -> value = 6
    ///
    subscript(axc_idx: Int) -> Self {
        var decimalBase: Self = 1
        for _ in 1...axc_idx {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

// MARK: - 运算符
public extension FixedWidthInteger {
    /// 前+递进
    /// - Parameter num: 数值
    static prefix func ++(num: inout Self) { num += 1 }
    
    /// 后缀+递进
    /// - Parameter num: 数值
    static postfix func ++(num: inout Self) { num += 1 }
    
    /// 前 -递减
    /// - Parameter num: 数值
    static prefix func --(num: inout Self) { num -= 1 }
    
    /// 后-递减
    /// - Parameter num: 数值
    static postfix func --(num: inout Self) { num -= 1 }
}
