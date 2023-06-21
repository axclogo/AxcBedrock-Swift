//
//  AxcRunStatus.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/17.
//

import Foundation

/// 运行状态
public typealias AxcRunStatus = AxcEnum.RunStatus

// MARK: - [AxcBedrockLib.RunningStatus]

public extension AxcEnum {
    /// 运行状态
    enum RunStatus: Int, CaseIterable {
        /// 运行中
        case running
        /// 暂停
        case pause
        /// 停止
        case stop

        /// 是否是运行状态
        var isRunning: Bool {
            return self == .running
        }

        /// 是否是暂停状态
        var isPause: Bool {
            return self == .pause
        }

        /// 是否是停止状态
        var isStop: Bool {
            return self == .stop
        }
    }
}
