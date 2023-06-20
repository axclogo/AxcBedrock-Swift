//
//  AxcZeroProtocolEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/11.
//

import UIKit

// MARK: - 基础数据类型协议
// MARK: 实例化0的对象
public protocol AxcInitializeZero {
    /// 实例化一个0的对象
    static var axc_zero: Self { get }
}

// MARK: 判断等同0
public protocol AxcDecisionIsZero {
    /// 实例化一个0的对象
    var axc_isZero: Bool { get }
}


