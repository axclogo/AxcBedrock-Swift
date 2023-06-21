//
//  AxcTimeCheckerTarget.swift
//  FBSnapshotTestCase
//
//  Created by 赵新 on 2023/2/13.
//

import QuartzCore

// MARK: - [AxcTimeCheckerTarget]

public protocol AxcTimeCheckerTarget: AxcSharedTarget, AxcLogInfoTarget {
    associatedtype MarkType: Hashable, Equatable, RawRepresentable
}

// MARK: - 默认实现

public extension AxcTimeCheckerTarget {
    // MARK: 日志协议

    var logType: String? {
        return "时间检测器日志"
    }
}

public extension AxcTimeCheckerTarget {
    /// 开始计时
    /// - Parameter markType: 类型
    static func Start(forMark markType: MarkType) {
        #if DEBUG
        Shared._timeIntervalMap[markType] = CACurrentMediaTime()
        #endif
    }

    /// 结束计时
    /// - Parameters:
    ///   - markType: 标记类型
    ///   - extra: 附加字段
    static func End(forMark markType: MarkType,
                    extra: String = "") {
        #if DEBUG
        if let startTime = Shared._timeIntervalMap[markType] {
            let endTime = CACurrentMediaTime()
            Shared.log("\(extra)-\(endTime - startTime)")
        } else {
            Shared.log("\(extra)-没有获取到\(markType)的起始时间点！")
        }
        Shared._timeIntervalMap.removeValue(forKey: markType)
        #endif
    }

    /// 作用域内
    /// - Parameters:
    ///   - markType: 标记类型
    ///   - extra: 附加字段
    ///   - scopeBlock: 作用域闭包
    static func Scope(forMark markType: MarkType,
                      extra: String = "",
                      scopeBlock: AxcBlock.Empty) {
        Start(forMark: markType)
        scopeBlock()
        End(forMark: markType, extra: extra)
    }
}

fileprivate var k_timeIntervalMap = "k_fileprivate.AxcBedrock.timeIntervalMap"
extension AxcTimeCheckerTarget {
    /// 时间存储表
    var _timeIntervalMap: [MarkType: CFTimeInterval] {
        set { AxcRuntime.Set(object: self, key: &k_timeIntervalMap, value: newValue) }
        get {
            guard let value: [MarkType: CFTimeInterval] = AxcRuntime.GetObject(self, key: &k_timeIntervalMap) else {
                let value: [MarkType: CFTimeInterval] = [:]
                self._timeIntervalMap = value
                return value
            }
            return value
        }
    }
}
