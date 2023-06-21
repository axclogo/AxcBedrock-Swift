//
//  AxcNSControlEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/4/7.
//

#if canImport(AppKit)

import AppKit

// MARK: - 数据转换

public extension AxcSpace where Base: NSControl { }

// MARK: - 类方法

public extension AxcSpace where Base: NSControl { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: NSControl {
    /// 触发事件Block
    /// - Parameters:
    ///   - event: 事件类型
    ///   - actionBlock: 回调
    func addEvent(actionBlock: @escaping AxcBlock.Action<Base>) {
        base._addEventBlock { sender in
            guard let action = sender as? Base else { return }
            actionBlock(action)
        }
    }

    /// 移除响应事件
    /// - Parameters:
    ///   - event: 事件类型
    func removeEvent() {
        base.target = nil
        base.action = nil
    }
}

extension NSControl: AxcActionBlockTarget {
    public typealias ActionType = NSControl
    /// 触发事件Block
    fileprivate func _addEventBlock(actionBlock: @escaping AxcBlock.Action<ActionType>) {
        setActionBlock(key: _eventBlockKey, actionBlock)
        target = self
        action = #selector(self._ControlAction)
    }

    @objc
    func _ControlAction() {
        guard let block = getActionBlock(_eventBlockKey) else { return }
        block(self)
    }

    var _eventBlockKey: String {
        return "com.AxcBedrock.ControlAction"
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: NSControl { }

#endif
