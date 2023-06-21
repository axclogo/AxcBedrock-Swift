//
//  AxcUIMenuItemEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/26.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base: UIMenuItem {}

// MARK: - 类方法

public extension AxcSpace where Base: UIMenuItem {}

// MARK: - 属性 & Api

public extension AxcSpace where Base: UIMenuItem {
    /// 触发事件Block
    func addAction(_ actionBlock: @escaping AxcBlock.Action<Base>) {
        base._addActionBlock() { sender in
            guard let action = sender as? Base else { return }
            actionBlock(action)
        }
    }
}

// MARK: - 扩展UIMenuItem + AxcActionBlockProtocol

extension UIMenuItem: AxcActionBlockTarget {
    public typealias ActionType = UIMenuItem
    /// 触发事件Block
    fileprivate func _addActionBlock(_ actionBlock: @escaping AxcBlock.Action<ActionType>) {
        setActionBlock(actionBlock)
        action = #selector(blockAction)
    }

    /// 触发的方法
    @objc
    fileprivate func blockAction() {
        guard let block = getActionBlock() else { return }
        block(self)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: UIMenuItem {}

#endif
