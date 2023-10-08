//
//  AxcSchedulerTarget.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/16.
//

import Foundation

// MARK: - [AxcSchedulerTarget]

public protocol AxcSchedulerTarget: AxcLogInfoTarget {
    // 任务携带对象的类型
    associatedtype GlobalObjType = Any

    /// 唯一标识符，用于区分多个调度器
    var identifier: String { get }

    /// 运行线程，默认主线程
    var runQueue: DispatchQueue { get }
}

// MARK: - 默认实现

public extension AxcSchedulerTarget {
    // MARK: 定义的

    /// 所有任务完成回调
    typealias AllTaskCompleteBlock = (_ validTaskList: [AxcSchedulerTask<GlobalObjType>],
                                      _ globalObj: GlobalObjType?) -> Void?

    var runQueue: DispatchQueue {
        return .main
    }

    // MARK: 日志协议

    var logIdentifier: String {
        // 将调度器的唯一标识与日志系统的标识符同步
        return identifier
    }

    var logPrefix: String? {
        return AxcBedrockLib.Shared.logPrefix
    }

    var logType: String? {
        return "调度器"
    }
}

public extension AxcSchedulerTarget {
    // MARK: 操作

    /// 开始调度
    func run(with taskObj: GlobalObjType?) {
        log("<开始调度>")
        if !_state.isRunning {
            _state = .running
            _taskObj = taskObj
            _run()
        }
    }

    /// 暂停调度
    func pause() {
        log("<暂停调度>")
        _state = .pause
    }

    /// 停止调度
    func stop() {
        log("<清空调度>")
        _state = .stop
        _taskList = []
    }

    /// 重试调度
    func retry() {
        log("<重试调度>")
        _run()
    }

    /// 跳过
    func skip() {
        log("<跳过调度>")
        _taskList.removeFirst()
    }

    /// 任务列表倒序
    func reverse() {
        _taskList = _taskList.reversed()
    }

    /// 设置所有任务执行完成后的回调
    /// 会将所有有效执行的任务全部回调
    func set(allTaskComplete block: @escaping AllTaskCompleteBlock) {
        _allTaskCompleteBlock = block
    }

    // MARK: 添加

    /// 最后追加一个任务
    func appendBackTask(_ task: AxcSchedulerTask<GlobalObjType>) {
        _taskList.append(task)
    }

    /// 最后追加一组任务
    func appendBackTasks(_ tasks: [AxcSchedulerTask<GlobalObjType>]) {
        _taskList.append(contentsOf: tasks)
    }

    /// 最前追加一个任务
    func appendFrontTask(_ task: AxcSchedulerTask<GlobalObjType>) {
        _taskList.insert(task, at: 0)
    }

    /// 最前追加一组任务
    func appendFrontTasks(_ tasks: [AxcSchedulerTask<GlobalObjType>]) {
        _taskList.insert(contentsOf: tasks, at: 0)
    }

    /// 插入一个任务，在哪个任务之后
    /// - Parameters:
    ///   - task: 任务
    ///   - identifier: 标签任务之后
    ///   - isReverse: 是否倒序查找 默认 false 正序
    func insertTaskToBack(_ task: AxcSchedulerTask<GlobalObjType>,
                          at identifier: String,
                          isReverse: Bool = false) {
        guard let index = _taskIndex(with: identifier, isReverse: isReverse) else { return } // 查找目标任务索引
        let newIndex = index + 1
        if _taskList.axc.isCrossing(index) { // 越界
            appendBackTask(task) // 追加
        } else {
            _taskList.insert(task, at: newIndex) // 插入
        }
    }

    /// 插入一个任务，在哪个任务之前
    /// - Parameters:
    ///   - task: 任务
    ///   - atLabel: 标签
    ///   - isReverse: 是否倒序查找 默认 false 正序
    func insertTaskToFront(_ task: AxcSchedulerTask<GlobalObjType>,
                           at identifier: String,
                           isReverse: Bool = false) {
        guard let index = _taskIndex(with: identifier, isReverse: isReverse) else { return } // 查找目标任务索引
        _taskList.insert(task, at: index)
    }

    // MARK: 移除

    /// 通过任务对象移除一个任务
    func removeTask(with task: AxcSchedulerTask<GlobalObjType>) {
        removeTask(with: task.identifier)
    }

    /// 通过标签移除一个任务
    func removeTask(with identifier: String) {
        var newList = _taskList
        for (idx, task) in _taskList.enumerated() {
            if task.identifier == identifier { // 比较标签
                newList.remove(at: idx)
                break
            }
        }
        _taskList = newList
    }

    // MARK: 获取

    /// 通过标签获取一个任务
    func taskWithIdentifier(_ identifier: String) -> AxcSchedulerTask<GlobalObjType>? {
        for task in _taskList {
            if task.identifier == identifier {
                return task
            }
        }
        return nil
    }

    // MARK: 移动

    /// 将指定任务移动到某个目标任务之前
    /// - Parameters:
    ///   - formLabel: 指定任务
    ///   - toLabel: 目标任务
    ///   - isReverse: 是否倒序查找 默认 false 正序
    func moveTaskToFront(form formIdentifier: String,
                         to toIdentifier: String,
                         isReverse: Bool = false) {
        guard let formTask = taskWithIdentifier(formIdentifier) else { return }
        removeTask(with: formIdentifier)
        insertTaskToFront(formTask, at: toIdentifier, isReverse: isReverse)
    }

    /// 将指定任务移动到某个目标任务之后
    /// - Parameters:
    ///   - formLabel: 指定任务
    ///   - toLabel: 目标任务
    ///   - isReverse: 是否倒序查找 默认 false 正序
    func moveTaskToBack(form formIdentifier: String,
                        to toIdentifier: String,
                        isReverse: Bool = false) {
        guard let formTask = taskWithIdentifier(formIdentifier) else { return }
        removeTask(with: formIdentifier)
        insertTaskToBack(formTask, at: toIdentifier, isReverse: isReverse)
    }

    /// 交换两个任务的位置
    /// - Parameters:
    ///   - formLabel: 指定任务
    ///   - toLabel: 目标任务
    ///   - isReverse: 是否倒序查找 默认 false 正序
    func exchangeTask(form formIdentifier: String,
                      to toIdentifier: String,
                      isReverse: Bool = false) {
        guard let formIndex = _taskIndex(with: formIdentifier, isReverse: isReverse),
              let toIndex = _taskIndex(with: toIdentifier, isReverse: isReverse) else { return } // 查找目标任务索引
        let tmpTask = _taskList[formIndex]
        _taskList[formIndex] = _taskList[toIndex]
        _taskList[toIndex] = tmpTask
    }

    /// 将某个任务移动到最前执行
    func bringTaskToFront(identifier: String) {
        guard let task = taskWithIdentifier(identifier) else { return }
        removeTask(with: identifier) // 移除
        appendFrontTask(task) // 最前追加
    }

    /// 将某个任务移动到最后执行
    func bringTaskToBack(identifier: String) {
        guard let task = taskWithIdentifier(identifier) else { return }
        removeTask(with: identifier) // 移除
        appendBackTask(task) // 最后追加
    }

    // MARK: 替换

    /// 将某个任务替换
    /// - Parameters:
    ///   - task: 新任务
    ///   - replaceLabel: 替换任务的标签
    ///   - isReverse: 是否倒序查找 默认 false 正序
    func replaceTask(_ task: AxcSchedulerTask<GlobalObjType>,
                     replaceIdentifier identifier: String,
                     isReverse: Bool = false) {
        guard let index = _taskIndex(with: identifier, isReverse: isReverse) else { return } // 查找目标任务索引
        removeTask(with: identifier) // 移除
        if _taskList.axc.isCrossing(index) { // 越界
            appendBackTask(task) // 追加
        } else {
            _taskList.insert(task, at: index) // 插入
        }
    }
}

private extension AxcSchedulerTarget {
    func _run() {
        guard _state.isRunning else { return }
        runQueue.async { [weak self] in
            guard let weakSelf = self else { return }
            if let firstTask = weakSelf._firstTask { // 还有任务
                weakSelf._performTask(firstTask) { [weak self] completeTask in
                    guard let weakSelf = self else { return }
                    weakSelf.log("<==任务结束：\(completeTask)")
                    // 移除任务
                    weakSelf.removeTask(with: completeTask)
                    // 继续下一个任务
                    weakSelf._run()
                }
            } else { // 任务池空了
                weakSelf._allTaskCompleteBlock?(weakSelf._validTaskList,
                                                weakSelf._taskObj)
                weakSelf.log("<结束调度任务>有效执行:\(weakSelf._validTaskList)")
                weakSelf._validTaskList = [] // 清空执行记录
                weakSelf._taskObj = nil // 清空对象
                weakSelf._state = .stop // 状态置为停止
            }
        }
    }

    /// 获取当前任务
    private var _firstTask: AxcSchedulerTask<GlobalObjType>? {
        return _taskList.first
    }

    /// 执行某一个任务
    private func _performTask(_ task: AxcSchedulerTask<GlobalObjType>,
                              completeBlock: @escaping (AxcSchedulerTask<GlobalObjType>) -> Void) {
        // 结果回调
        let completeBlock: AxcSchedulerTask<GlobalObjType>.CompleteBlock = { [weak self] result in
            guard let weakSelf = self else { return }
            if result { // 任务执行完成
                weakSelf.log("++>执行成功：\(task)")
                weakSelf._validTaskList.append(task) // 记录有效执行的任务
            } else { // 任务跳过或失败
                weakSelf.log("-->执行失败：\(task)")
            }
            completeBlock(task)
        }
        log("==>开始任务：\(task)")
        task.eventBlock(task,
                        _taskObj,
                        completeBlock)
    }

    /// 查找某个任务的索引
    private func _taskIndex(with identifier: String, isReverse: Bool = false) -> Int? {
        var list = _taskList.enumerated()
        if isReverse {
            list = _taskList.reversed().enumerated()
        }
        for (idx, task) in list {
            if task.identifier == identifier {
                return idx
            }
        }
        return nil
    }
}

fileprivate var k_isPause = "k_fileprivate.AxcBedrock.isPause"
fileprivate var k_taskList = "k_fileprivate.AxcBedrock.taskList"
fileprivate var k_validTaskList = "k_fileprivate.AxcBedrock.validTaskList"
fileprivate var k_allTaskCompleteBlock = "k_fileprivate.AxcBedrock.allTaskCompleteBlock"
fileprivate var k_taskObj = "k_fileprivate.AxcBedrock.taskObj"
fileprivate extension AxcSchedulerTarget {
    /// 是否暂停
    var _state: AxcRunStatus {
        set { AxcRuntime.Set(object: self, key: &k_isPause, value: newValue) }
        get {
            guard let state: AxcRunStatus = AxcRuntime.GetObject(self, key: &k_isPause) else {
                let state: AxcRunStatus = .stop
                self._state = state
                return state
            }
            return state
        }
    }

    /// 部署的任务列表
    var _taskList: [AxcSchedulerTask<GlobalObjType>] {
        set { AxcRuntime.Set(object: self, key: &k_taskList, value: newValue) }
        get {
            guard let taskList: [AxcSchedulerTask<GlobalObjType>] = AxcRuntime.GetObject(self, key: &k_taskList) else {
                let taskList: [AxcSchedulerTask<GlobalObjType>] = []
                self._taskList = taskList
                return taskList
            }
            return taskList
        }
    }

    /// 有效执行的任务列表
    var _validTaskList: [AxcSchedulerTask<GlobalObjType>] {
        set { AxcRuntime.Set(object: self, key: &k_validTaskList, value: newValue) }
        get {
            guard let validTaskList: [AxcSchedulerTask<GlobalObjType>] = AxcRuntime.GetObject(self, key: &k_validTaskList) else {
                let validTaskList: [AxcSchedulerTask<GlobalObjType>] = []
                self._validTaskList = validTaskList
                return validTaskList
            }
            return validTaskList
        }
    }

    /// 所有任务完成回调
    var _allTaskCompleteBlock: AllTaskCompleteBlock? {
        set { AxcRuntime.Set(object: self, key: &k_allTaskCompleteBlock, value: newValue) }
        get { return AxcRuntime.GetObject(self, key: &k_allTaskCompleteBlock) }
    }

    /// 全局存储对象
    var _taskObj: GlobalObjType? {
        set { AxcRuntime.Set(object: self, key: &k_taskObj, value: newValue) }
        get { return AxcRuntime.GetObject(self, key: &k_taskObj) }
    }
}
