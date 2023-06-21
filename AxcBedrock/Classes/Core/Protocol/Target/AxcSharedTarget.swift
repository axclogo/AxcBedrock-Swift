//
//  AxcSharedTarget.swift
//  Axc
//
//  Created by 赵新 on 2022/10/21.
//

import Foundation

// MARK: - [AxcSharedTarget]

/// 单例协议
public protocol AxcSharedTarget: NSObject {
    /// 配置写在这里，会在第一次初始化后紧跟执行
    func config()
}

fileprivate var k_shared = "k_fileprivate.Axc.shared"
public extension AxcSharedTarget {
    /// 单例实例化
    static var Shared: Self {
        guard let shared: Self = AxcRuntime.GetObject(self, key: &k_shared) else {
            let shared = Self()
            shared.config()
            AxcRuntime.Set(object: self, key: &k_shared, value: shared)
            return shared
        }
        return shared
    }

    func config() { }
}

// MARK: - 线程

fileprivate var k_queue = "k_fileprivate.Axc.queue"
public extension AxcSharedTarget {
    /// 子线程对象
    var dispatchQueue: DispatchQueue {
        guard let shared: DispatchQueue = AxcRuntime.GetObject(self, key: &k_queue) else {
            let shared = DispatchQueue(label: queueIdentifier)
            AxcRuntime.Set(object: self, key: &k_queue, value: shared)
            return shared
        }
        return shared
    }

    /// 子线程唯一标识符
    var queueIdentifier: String {
        return "com.AxcBedrock.\(Self.self).queue"
    }
}
