//
//  AxcDispatchQueueEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2021/12/16.
//

import Dispatch
import Foundation

// MARK: - 数据转换

public extension AxcSpace where Base: DispatchQueue { }

// MARK: - 类方法

public extension AxcSpace where Base: DispatchQueue {
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
        let item = DispatchWorkItem(block: task)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: item)
        if let main = mainTask { item.notify(queue: .main, execute: main) }
        return item
    }

    /// 异步任务Block调用
    /// - Parameters:
    ///   - task: 异步任务
    ///   - mainTask: 回调主线任务
    static func Async(task: @escaping AxcBlock.Empty,
                      mainTask: AxcBlock.Empty? = nil) {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask { item.notify(queue: .main, execute: main) }
    }

    /// 记时器调用
    /// - Parameters:
    ///   - duration: 持续时间，单位秒
    ///   - task: 任务
    static func Timer(count: Int,
                      timeType: DispatchTimeInterval = .seconds(1),
                      task: @escaping AxcBlock.OneParam<Int>,
                      mainTask: AxcBlock.Empty? = nil) {
        var countdown = count
        let codeTimer = DispatchSource.makeTimerSource()
        codeTimer.schedule(wallDeadline: .now(), repeating: timeType)
        codeTimer.setEventHandler {
            if countdown > 0 {
                DispatchQueue.main.async {
                    task(countdown)
                }
            } else {
                codeTimer.cancel()
                if let mainBlock = mainTask {
                    DispatchQueue.main.async {
                        mainBlock()
                    }
                }
            }
            countdown -= 1
        }
        codeTimer.resume()
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: DispatchQueue { }

// MARK: - 决策判断

public extension AxcSpace where Base: DispatchQueue {
    /// 是否是主线程队列
    static var IsMainQueue: Bool {
        let key = DispatchSpecificKey<Void>()
        DispatchQueue.main.setSpecific(key: key, value: ())
        return DispatchQueue.getSpecific(key: key) != nil
    }

    /// 是否是当前某个线程
    /// - Parameter queue: 比较线程
    /// - Returns: Bool
    static func isCurrent(_ queue: DispatchQueue) -> Bool {
        let key = DispatchSpecificKey<Void>()
        queue.setSpecific(key: key, value: ())
        defer {
            queue.setSpecific(key: key, value: nil)
        }
        return DispatchQueue.getSpecific(key: key) != nil
    }
}

// MARK: - 实例化方法

public extension DispatchQueue { }

// MARK: - 运算符/操作符

public extension DispatchQueue { }
