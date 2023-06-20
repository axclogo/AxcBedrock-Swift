//
//  AxcBoolEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/4.
//

import UIKit

// MARK: - 类方法/属性
public extension Bool {
    /// 返回true
    static var axc_true: Bool { return true }
    /// 返回false
    static var axc_false: Bool { return false }
}

// MARK: - 属性 & Api
public extension Bool {
    /// 取自己的非
    @discardableResult
    mutating func axc_reverse() -> Bool {
        self = !self
        return self
    }
    
    /// 取自己的非
    var axc_reversed: Bool { return !self }
}

