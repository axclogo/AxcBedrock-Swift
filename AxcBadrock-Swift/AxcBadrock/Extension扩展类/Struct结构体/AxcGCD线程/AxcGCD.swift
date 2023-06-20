//
//  AxcGCD.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/19.
//

import UIKit

/// GCD结构体
public struct AxcGCD {
    /// 主线程任务Block调用
    /// - Parameter task: 主线程任务
    public static func main(_ task: @escaping AxcEmptyBlock) {
        DispatchQueue.main.async { task() }
    }
    
    /// 异步任务Block调用
    /// - Parameters:
    ///   - task: 异步任务
    ///   - mainTask: 回调主线任务
    public static func async(_ task: @escaping AxcEmptyBlock, _ mainTask: AxcEmptyBlock? = nil) {
        DispatchQueue.axc_async(task, mainTask)
    }
    
    /// 延时任务Block调用
    /// - Parameters:
    ///   - delay: 延时时间
    ///   - task: 延时任务
    ///   - mainTask: 回调主线任务
    /// - Returns: 工作元素
    @discardableResult
    public static func delay(_ delay: Double,
                             _ task: @escaping AxcEmptyBlock,
                             _ mainTask: AxcEmptyBlock? = nil) -> DispatchWorkItem {
        return DispatchQueue.axc_delay(delay, task, mainTask)
    }
    
    /// 单次执行Block，已加锁防止多线程
    /// - Parameters:
    ///   - identifier: 该单次执行的唯一标识符
    ///   - task: 任务Block
    public static func once(_ identifier: String,
                            task: AxcEmptyBlock){
        DispatchQueue.axc_once(identifier: identifier, block: task)
    }
    
    /// 计时器Block
    /// - Parameters:
    ///   - duration: 持续时间
    ///   - task: 任务
    public static func timer(_ duration: Int, _ task: @escaping AxcEmptyBlock, _ mainTask: AxcEmptyBlock? = nil) {
        DispatchQueue.axc_timer(duration, task, mainTask)
    }
    /// 计时器Block
    /// - Parameters:
    ///   - duration: 持续时间
    ///   - task: 任务
    public static func timer( _ count: Int,
                              _ timeType: DispatchTimeInterval = .seconds(1),
                              _ task: @escaping AxcEmptyBlock,
                              _ mainTask: AxcEmptyBlock? = nil) {
        DispatchQueue.axc_timer(count, timeType, task, mainTask)
    }
}
