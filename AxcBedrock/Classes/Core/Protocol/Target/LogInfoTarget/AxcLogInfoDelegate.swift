//
//  AxcLogInfoDelegate.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/13.
//

import Foundation

// MARK: - [AxcBedrockLib.LogLevel]

public extension AxcBedrockLib {
    /// 日志等级
    @objc
    enum LogLevel: Int {
        /// 信息
        case info
        /// 警告
        case warning
        /// 错误
        case error
    }
}

// MARK: - [AxcLogInfoDelegate]

public protocol AxcLogInfoDelegate: NSObjectProtocol {
    /// 日志输出
    /// - Parameters:
    ///   - logLevel: 日志等级
    ///   - logContent: 日志内容
    func logOutput(logObj: AxcLogInfoTarget, logLevel: AxcBedrockLib.LogLevel, logContent: String)

    /// 致命错误事件
    /// - Parameters:
    ///   - content: 内容
    ///   - isNoDebugSleep: 非Debug环境是否休眠线程？
    func fatalErrorEvent(logObj: AxcLogInfoTarget, content: String, isNoDebugSleep: Bool)
}

// MARK: - 默认实现

public extension AxcLogInfoDelegate {
    func logOutput(logObj: AxcLogInfoTarget, logLevel: AxcBedrockLib.LogLevel, logContent: String) {
        print(logContent)
    }

    func fatalErrorEvent(logObj: AxcLogInfoTarget, content: String, isNoDebugSleep: Bool) { }
}
