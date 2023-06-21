//
//  AxcNSArrayEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/15.
//

import Foundation

// MARK: - 数据转换

public extension AxcSpace where Base: NSArray { }

// MARK: - 类方法

public extension AxcSpace where Base: NSArray { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: NSArray {
    /// 根据索引安全获取元素
    /// - Parameter index: 索引，越界后返回空
    /// - Returns: 元素
    func object(at index: Int) -> Any? {
        guard index >= 0, !base.axc.isCrossing(index) else {
            AxcBedrockLib.Log("获取数组元素越界！当前数组个数：\(base.count)，获取索引：\(index)")
            return nil
        }
        return base[index]
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: NSArray {
    /// 判断索引是否越界 越界为真
    func isCrossing(_ idx: Int) -> Bool {
        return !(
            (idx >= 0) && (base.count > idx)
        )
    }
}
