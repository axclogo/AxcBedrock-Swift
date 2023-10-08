//
//  AxcSereModuleTarget.swift
//  AxcSere
//
//  Created by 赵新 on 2023/2/3.
//

import Foundation

// MARK: - [AxcLibraryTarget]

public protocol AxcLibraryTarget: AxcSharedTarget, AxcLogInfoTarget {
    /// 组件模块名称
    var moduleName: String { get }

    /// 组件emoji
    /// 一般多用于打印日志时的区分
    var moduleEmoji: String? { get }
    
    /// 设置的错误类型
    associatedtype ErrorType: Error
}

// MARK: - 默认实现

public extension AxcLibraryTarget {
    // MARK: 自己的参数

    var moduleName: String {
        return "\(Self.self)"
    }

    var moduleEmoji: String? {
        return nil
    }
    
    /// 设置默认错误类型
    typealias ErrorType = Error

    // MARK: 日志协议

    var logIdentifier: String {
        return moduleName
    }

    var logPrefix: String {
        var logPrefix: String = ""
        if let moduleEmoji = moduleEmoji {
            logPrefix.append(moduleEmoji)
        }
        logPrefix.append(moduleName)
        return logPrefix
    }
}

// MARK: - 全局临时附加值功能

public extension AxcLibraryTarget {
    /// 写入附加属性对象
    /// ⚠️不能将附加属性对象作为处理组件内部事务的参数！
    static func WriteAttached(_ value: Any?) {
        Shared._attribute = value
    }

    /// 读取附加属性对象
    /// ⚠️不能将附加属性对象作为处理组件内部事务的参数！
    static func ReadAttached<T>() -> T? {
        guard let value = Shared._attribute as? T else { return nil }
        return value
    }

    /// 移除附加对象
    /// ⚠️不能将附加属性对象作为处理组件内部事务的参数！
    static func RemoveAttached() {
        Shared._attribute = nil
    }
}

// MARK: - 日志输出

public extension AxcLibraryTarget {
    /// 日志输出
    /// - Parameters:
    ///   - logLevel: 日志等级
    ///   - logType: 日志类型，如“数据库日志”、“路由日志”等
    ///   - items: 打印的元素
    static func Log(_ items: Any...,
                    logLevel: AxcEnum.LogLevel = .info) {
        Shared.log(items, logLevel: logLevel)
    }

    /// 框架内部使用的抛出致命异常
    /// debug开发环境下会崩溃提示使用不规范，线上环境可以让线程睡眠不崩溃
    /// - Parameter debugMsg:
    /// - Returns: Never
    static func FatalLog(_ items: Any...,
                         printCount: Int = 12,
                         isNoDebugSleep: Bool = true) -> Never {
        Shared.fatalLog(items, printCount: printCount, isNoDebugSleep: isNoDebugSleep)
    }
}

// MARK: - 实例私有

fileprivate var k_attribute = "k_fileprivate.AxcBedrock.attribute"
fileprivate extension AxcLibraryTarget {
    /// 属性，用于跨代理带参处理事务
    /// ⚠️但不能将此参数作为处理组件内部事务的参数！
    /// 未直接开放的原因为通过Func收口管理，防止直接操作变量
    var _attribute: Any? {
        set { AxcRuntime.Set(object: self, key: &k_attribute, value: newValue) }
        get { return AxcRuntime.GetObject(self, key: &k_attribute) }
    }
}
