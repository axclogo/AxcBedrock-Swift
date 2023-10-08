//
//  AxcLogInfoTarget.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/16.
//

import Foundation

// MARK: - [AxcLogInfoTarget]

/// 可以支持工具类对象使用的日志协议
public protocol AxcLogInfoTarget: NSObjectProtocol {
    /// 唯一标识符，用于区分多个日志代理
    var logIdentifier: String { get }

    /// 日志前缀
    /// 如：AxcBedrockLib
    var logPrefix: String { get }

    /// 日志类型
    /// 如 数据库日志、单例日志、模块日志等
    var logType: String { get }

    /// 日志时间戳样式
    var logDateFormat: String { get }
}

// MARK: - 默认实现

public extension AxcLogInfoTarget {
    var logIdentifier: String {
        return "\(Self.self)"
    }

    var logType: String {
        return ""
    }

    var logDateFormat: String {
        return "HH:mm:ss"
    }
}

// MARK: - 代理设置

public extension AxcLogInfoTarget {
    /// 获取日志代理
    var logDelegate: AxcLogInfoDelegate? {
        guard let weakDelegateObj = _weakDelegateObj,
              let delegate = weakDelegateObj.object as? AxcLogInfoDelegate else { return nil }
        return delegate
    }

    /// 设置代理，已做弱引用处理
    func set(logDelegate: AxcLogInfoDelegate) {
        _weakDelegateObj = .init(logDelegate)
    }
}

// MARK: - 日志输出

public extension AxcLogInfoTarget {
    /// 日志输出
    /// - Parameters:
    ///   - logLevel: 日志等级
    ///   - logType: 日志类型，如“数据库日志”、“路由日志”等
    ///   - items: 打印的元素
    /// 如：AxcBedrockLib[模块日志](2023.02.16)➡️这里是日志内容"
    func log(_ items: Any...,
             logLevel: AxcEnum.LogLevel = .info) {
        let logPerfix: String = _createLogPrefix(logLevel: logLevel)
        let logContent: String = "\(logPerfix)\(items)"
        logDelegate?.logOutput(logObj: self, logLevel: logLevel, logContent: logContent)
    }

    /// 框架内部使用的抛出致命异常
    /// debug开发环境下会崩溃提示使用不规范，线上环境可以让线程睡眠不崩溃
    /// - Parameter debugMsg:
    /// - Returns: Never
    /// 如：AxcBedrockLib[模块日志](2023.02.16)➡️❌❌❌这里是日志内容"
    func fatalLog(_ items: Any...,
                  printCount: Int = 12,
                  isNoDebugSleep: Bool = true) -> Never {
        let logPerfix: String = _createLogPrefix(logLevel: .error)
        let logContent: String = "\(logPerfix)❌❌❌\(items)"
        logDelegate?.fatalErrorEvent(logObj: self, content: logContent, isNoDebugSleep: isNoDebugSleep)
        #if DEBUG
        for _ in 0 ..< printCount {
            print(logContent)
        }
        return fatalError(logContent)
        #else
        if isNoDebugSleep {
            sleep(.max)
        }
        return fatalError(logContent)
        #endif
    }
}

// MARK: - 私有

fileprivate var k_weakDelegateObj = "k_fileprivate.AxcBedrock.weakDelegateObj"

fileprivate extension AxcLogInfoTarget {
    /// 获取统一的日志前缀
    func _createLogPrefix(logLevel: AxcEnum.LogLevel?) -> String {
        var logPrefix: String = logPrefix
        if let logLevel {
            switch logLevel {
            case .info: logPrefix.append("[\(logType)🔖]")
            case .warning: logPrefix.append("[\(logType)⚠️]")
            case .error: logPrefix.append("[\(logType)❌]")
            }
        } else {
            logPrefix.append("[\(logType)]")
        }
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = logDateFormat
        let dateContent = formatter.string(from: date)
        logPrefix.append("(\(dateContent))➡️")
        return logPrefix
    }

    /// 用于存储弱引用代理对象
    var _weakDelegateObj: AxcWeakObj<AnyObject>? {
        set { AxcRuntime.Set(object: self, key: &k_weakDelegateObj, value: newValue) }
        get { return AxcRuntime.GetObject(self, key: &k_weakDelegateObj) }
    }
}
