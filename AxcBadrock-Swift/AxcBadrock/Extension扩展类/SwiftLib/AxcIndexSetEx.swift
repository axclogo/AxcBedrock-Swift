//
//  AxcIndexSetEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/7/20.
//

import Foundation

public extension IndexSet {
    ///  实例化方法
    /// - Parameter values: Int类型数组
    init(values: [Int]) {
        let indexSet = NSMutableIndexSet()
        for i in values {
            indexSet.add(i)
        }
        self = indexSet as IndexSet
    }
}
