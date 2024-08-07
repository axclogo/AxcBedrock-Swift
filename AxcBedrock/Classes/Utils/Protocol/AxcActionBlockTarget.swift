//
//  AxcActionBlockTarget.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/26.
//

import Foundation

// MARK: - [AxcActionBlockTarget]

protocol AxcActionBlockTarget {
    associatedtype ActionType
}

private var k_actionBlockMap = "k_actionBlockMap"
private var k_defaultKey = "k_defaultKey"
extension AxcActionBlockTarget where Self: NSObject {
    /// 设置触发代码块
    func setActionBlock(key: String? = nil, _ block: @escaping AxcBlock.Action<ActionType>) {
        if let key = key {
            actionBlockMap[key] = block
        } else {
            actionBlockMap[k_defaultKey] = block
        }
    }

    /// 获取触发代码块
    func getActionBlock(_ key: String? = nil) -> AxcBlock.Action<ActionType>? {
        if let key = key {
            return actionBlockMap[key]
        } else {
            return actionBlockMap[k_defaultKey]
        }
    }

    /// 存储事件的表
    var actionBlockMap: [String: AxcBlock.Action<ActionType>] {
        set { AxcRuntime.Set(object: self, key: &k_actionBlockMap, value: newValue, policy: .OBJC_ASSOCIATION_RETAIN) }
        get {
            guard let actionBlockMap: [String: AxcBlock.Action<ActionType>] = AxcRuntime.GetObject(self, key: &k_actionBlockMap) else {
                let emptyMap: [String: AxcBlock.Action<ActionType>] = [:]
                self.actionBlockMap = emptyMap
                return emptyMap
            }
            return actionBlockMap
        }
    }
}
