//
//  AxcCalculator.swift
//  Kanna
//
//  Created by 赵新 on 2023/3/29.
//

/// Runtime结构体
public typealias AxcCalculator = AxcBedrockLib.Calculator

// MARK: - [AxcBedrockLib.Calculator]

public extension AxcBedrockLib {
    /// 一个计算器
    struct Calculator {
        /// 超大数相加
        public static func LargeNumber(_ num1: String, add num2: String) -> String {
            // 将两个字符串翻转，方便从最低位开始相加
            let str1 = String(num1.reversed())
            let str2 = String(num2.reversed())

            var result = ""
            var carry = 0 // 进位值

            // 从最低位开始逐位相加
            for i in 0 ..< max(str1.count, str2.count) {
                let digit1 = i < str1.count ? Int(String(str1[str1.index(str1.startIndex, offsetBy: i)]))! : 0
                let digit2 = i < str2.count ? Int(String(str2[str2.index(str2.startIndex, offsetBy: i)]))! : 0
                let sum = digit1 + digit2 + carry
                let digit = sum % 10
                carry = sum / 10
                result.append(String(digit))
            }

            // 处理最高位的进位
            if carry > 0 {
                result.append(String(carry))
            }

            // 将结果翻转，得到正确的结果
            return String(result.reversed())
        }
    }

    /// 超大数相减
    static func LargeNumber(_ num1: String, subtract num2: String) -> String? {
        // 检查 num1 是否小于 num2
        if num1.count < num2.count || (num1.count == num2.count && num1 < num2) {
            return nil
        }

        // 将两个字符串翻转，方便从最低位开始相减
        let str1 = String(num1.reversed())
        let str2 = String(num2.reversed())

        var result = ""
        var borrow = 0 // 借位值

        // 从最低位开始逐位相减
        for i in 0 ..< str1.count {
            let digit1 = Int(String(str1[str1.index(str1.startIndex, offsetBy: i)]))!
            let digit2 = i < str2.count ? Int(String(str2[str2.index(str2.startIndex, offsetBy: i)]))! : 0
            var diff = digit1 - digit2 - borrow
            if diff < 0 {
                diff += 10
                borrow = 1
            } else {
                borrow = 0
            }
            result.append(String(diff))
        }

        // 去除结果字符串末尾的零
        while result.last == "0", result.count > 1 {
            result.removeLast()
        }

        // 将结果翻转，得到正确的结果
        return String(result.reversed())
    }

    /// 超大数相乘
    static func LargeNumber(_ num1: String, multiply num2: String) -> String {
        // 将两个字符串翻转，方便从最低位开始相乘
        let str1 = String(num1.reversed())
        let str2 = String(num2.reversed())

        var result = Array(repeating: 0, count: str1.count + str2.count) // 存储结果的数组

        // 从最低位开始逐位相乘
        for i in 0 ..< str1.count {
            for j in 0 ..< str2.count {
                let digit1 = Int(String(str1[str1.index(str1.startIndex, offsetBy: i)]))!
                let digit2 = Int(String(str2[str2.index(str2.startIndex, offsetBy: j)]))!
                result[i + j] += digit1 * digit2
            }
        }

        // 处理进位
        var carry = 0
        for i in 0 ..< result.count {
            let sum = result[i] + carry
            result[i] = sum % 10
            carry = sum / 10
        }

        // 去除结果数组前导零
        while result.last == 0, result.count > 1 {
            result.removeLast()
        }

        // 将结果数组翻转，得到正确的结果
        return String(result.reversed().map(String.init).joined())
    }

    /// 超大数相除
    static func LargeNumber(_ num1: String, divide num2: String) -> String? {
        // 将被除数和除数字符串翻转，方便从最低位开始逐位相除
        let str1 = String(num1.reversed())
        let str2 = String(num2.reversed())

        // 检查除数是否为零
        if str2 == "0" {
            return nil
        }

        // 初始化商和余数字符串
        var quotient = ""
        var remainder = ""

        // 从最高位到最低位逐位相除
        for i in 0 ..< str1.count {
            remainder.append(str1[str1.index(str1.startIndex, offsetBy: i)])

            // 当余数小于除数时，补零
            while remainder.count > 0, remainder.last! == "0" {
                quotient.append("0")
                remainder.removeLast()
            }

            // 如果当前余数大于等于除数，则进行一次相除操作
            if remainder.count >= str2.count, remainder >= str2 {
                var count = 0
                while remainder >= str2 {
                    remainder = LargeNumber(remainder, subtract: str2)!
                    count += 1
                }
                quotient.append(String(count))
            } else {
                quotient.append("0")
            }
        }

        // 去除商字符串前导零
        while quotient.last == "0", quotient.count > 1 {
            quotient.removeLast()
        }

        // 将商字符串翻转，得到正确的结果
        return String(quotient.reversed())
    }
}
