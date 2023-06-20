//
//  AxcUserDefaultsEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/10.
//

import UIKit

// MARK: - 属性 & Api
public extension UserDefaults {
    /// 获取一个NSNumber类型数据
    func axc_number(for key: String) -> NSNumber? {
        return self[key] as? NSNumber
    }
    /// 获取一个String类型数据
    func axc_string(for key: String) -> String? {
        return self[key] as? String
    }
    /// 获取一个UInt类型数据
    func axc_uint(for key: String) -> UInt? {
        return self[key] as? UInt
    }
    /// 获取一个Int类型数据
    func axc_int(for key: String) -> Int? {
        return self[key] as? Int
    }
    /// 获取一个Double类型数据
    func axc_double(for key: String) -> Double? {
        return self[key] as? Double
    }
    /// 获取一个Float类型数据
    func axc_float(for key: String) -> Float? {
        return self[key] as? Float
    }
    /// 获取一个CGFloat类型数据
    func axc_cgFloat(for key: String) -> CGFloat? {
        return self[key] as? CGFloat
    }
    /// 获取一个Date类型数据
    func axc_dateValue(for key: String) -> Date? {
        return self[key] as? Date
    }
}

// MARK: - 操作符
public extension UserDefaults {
    /// 通过操作符来操作相关参数
    subscript(key: String) -> Any? {
        set { set(newValue, forKey: key) }
        get { return object(forKey: key) }
    }
}
