//
//  AxcSchedulerTask.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/17.
//

import Foundation

/// 调度器的任务对象
public typealias AxcSchedulerTask<TaskObjType> = AxcBedrockLib.SchedulerTask<TaskObjType>

/// 闭包定义
public extension AxcSchedulerTask {
    typealias CompleteBlock = AxcBlock.OneParam<Bool>
    typealias EventBlock = (_ currentTask: AxcSchedulerTask<GlobalObjType>,
                            _ globalObj: GlobalObjType?,
                            _ completeBlock: @escaping CompleteBlock) -> Void
}

// MARK: - [AxcBedrockLib.SchedulerTask]

public extension AxcBedrockLib {
    /// 调度器任务对象
    class SchedulerTask<GlobalObjType>: NSObject {
        /// 唯一标识
        open var identifier: String

        /// 任务需要操作的代码
        open var eventBlock: EventBlock

        /// 实例化
        public init(identifier: String,
                    eventBlock: @escaping EventBlock) {
            self.identifier = identifier
            self.eventBlock = eventBlock
        }

        open override var description: String {
            return "[调度任务: - \(identifier)]"
        }
    }
}
