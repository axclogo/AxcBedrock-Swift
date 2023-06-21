//
//  AxcGCDTarget.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/11.
//

import Dispatch

// MARK: - [AxcGCDTarget]

/// Grand Central Dispatch
public protocol AxcGCDTarget { }

public extension AxcGCDTarget {
    /// 主线程任务Block调用
    /// - Parameter task: 主线程任务
    static func Main(task: @escaping AxcBlock.Empty) {
        DispatchQueue.main.async(execute: task)
    }

    /// 异步任务Block调用
    /// - Parameters:
    ///   - task: 异步任务
    ///   - mainTask: 回调主线任务
    static func Async(task: @escaping AxcBlock.Empty,
                      mainTask: AxcBlock.Empty? = nil) {
        DispatchQueue.Axc.Async(task: task, mainTask: mainTask)
    }

    /// 延时任务Block调用
    /// - Parameters:
    ///   - delay: 延时时间
    ///   - task: 延时任务
    ///   - mainTask: 回调主线任务
    /// - Returns: 工作元素
    @discardableResult
    static func Delay(delay: Double,
                      task: @escaping AxcBlock.Empty,
                      mainTask: AxcBlock.Empty? = nil) -> DispatchWorkItem {
        return DispatchQueue.Axc.Delay(delay: delay, task: task, mainTask: mainTask)
    }

    /// 计时器Block
    /// - Parameters:
    ///   - duration: 持续时间
    ///   - task: 任务
    static func Timer(count: Int,
                      timeType: DispatchTimeInterval = .seconds(1),
                      task: @escaping AxcBlock.OneParam<Int>,
                      mainTask: AxcBlock.Empty? = nil) {
        DispatchQueue.Axc.Timer(count: count, timeType: timeType, task: task, mainTask: mainTask)
    }
}
