//
//  AxcArrayEx+Iteration.swift
//  Pods
//
//  Created by 赵新 on 2023/3/29.
//

import Foundation

public extension AxcArraySpace {
    /// 多线程异步遍历，迭代顺序是无序且不可控的
    /// - Parameter body: 遍历结果
    func queueForEach(_ body: (Element) -> Void) {
        DispatchQueue.concurrentPerform(iterations: base.count) { index in
            body(base[index])
        }
    }
}
