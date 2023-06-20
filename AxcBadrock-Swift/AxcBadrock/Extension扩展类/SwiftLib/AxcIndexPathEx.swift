//
//  AxcIndexPathEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/10.
//

import UIKit

// MARK: - 数据转换
public extension IndexPath {
    // MARK: 扩展
    /// 转换成元组 (section,row)
    var axc_tuples: (Int,Int) {
        return (section,row)
    }
}

// MARK: - 类方法/属性
extension IndexPath: AxcInitializeZero {
    // MARK: 协议
    /// 直接获取0，0
    public static var axc_zero: IndexPath {
        return IndexPath(row: 0, section: 0)
    }
    
    // MARK: 扩展
    /// 通过元组实例化
    public init(_ tuples: (Int,Int) ){
        self = IndexPath(row: tuples.0, section: tuples.1)
    }
    /// 直接实例化一个row，section = 0
    public init(row: Int) {
        self = IndexPath((row,0))
    }
    /// 直接实例化一个section，row = 0
    public init(section: Int) {
        self = IndexPath((0,section))
    }
}

// MARK: - 决策判断
extension IndexPath: AxcDecisionIsZero {
    // MARK: 协议
    /// 是否都是0
    public var axc_isZero: Bool { return self == IndexPath.axc_zero }
    
    // MARK: 扩展
    /// 是否是第一组
    public var axc_isFirstSection: Bool { return self.section == 0 }
    /// 是否是第一行
    public var axc_isFirstRow: Bool { return self.row == 0 }
}

// MARK: - 运算符
public extension IndexPath {
    
    /// IndexPath相加
    /// - Parameters:
    ///   - leftValue: IndexPath
    ///   - rightValue: tuple value.
    /// - Returns: IndexPath与IndexPath相加后的IndexPath
    static func + (leftValue: IndexPath, rightValue: IndexPath) -> IndexPath {
        return IndexPath(row: leftValue.row + rightValue.row,
                         section: leftValue.section + rightValue.section)
    }
    
    /// 使用元组相加
    /// - Parameters:
    ///   - leftValue: IndexPath
    ///   - rightValue: tuple value.
    /// - Returns: IndexPath与元组相加后的IndexPath
    static func + (leftValue: IndexPath, rightValue: (section: Int, row: Int)) -> IndexPath {
        return IndexPath(row: leftValue.row + rightValue.row,
                         section: leftValue.section + rightValue.section)
    }
    
    /// IndexPath相减
    /// - Parameters:
    ///   - leftValue: IndexPath
    ///   - rightValue: tuple value.
    /// - Returns: IndexPath与IndexPath相减的IndexPath
    static func - (leftValue: IndexPath, rightValue: IndexPath) -> IndexPath {
        return IndexPath(row: leftValue.row - rightValue.row,
                         section: leftValue.section - rightValue.section)
    }
    
    /// 使用元组相减
    /// - Parameters:
    ///   - leftValue: IndexPath
    ///   - rightValue: tuple value.
    /// - Returns: IndexPath与元组相减的IndexPath
    static func - (leftValue: IndexPath, rightValue: (section: Int, row: Int)) -> IndexPath {
        return IndexPath(row: leftValue.row - rightValue.row,
                         section: leftValue.section - rightValue.section)
    }
    
    /// IndexPath都乘以多少
    /// - Parameters:
    ///   - leftValue: IndexPath
    ///   - rightValue: 倍数、标量
    /// - Returns: 计算后的点
    static func * (leftValue: IndexPath, rightValue: Int) -> IndexPath {
        return IndexPath(row: leftValue.row * rightValue,
                         section: leftValue.section * rightValue)
    }
    
    /// IndexPath都乘以多少
    /// - Parameters:
    ///   - leftValue: 倍数、标量
    ///   - rightValue: IndexPath
    /// - Returns: 计算后的点
    static func * (leftValue: Int, rightValue: IndexPath) -> IndexPath {
        return IndexPath(row: rightValue.row * leftValue,
                         section: rightValue.section * leftValue)
    }
}
