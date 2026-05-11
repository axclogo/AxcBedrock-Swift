//
//  AxcBedrock.swift
//  AxcBedrock
//
//  Created by 赵新 on 2022/2/11.
//

#if os(macOS)
import AppKit.NSGestureRecognizer

@available(OSX 10.10, *)
public typealias AxcBedrockGestureRecognizer = NSGestureRecognizer
@available(OSX 10.10, *)
public typealias AxcBedrockTapGestureRecognizer = NSClickGestureRecognizer

#elseif os(iOS) || os(tvOS)

import UIKit.UIGestureRecognizer

public typealias AxcBedrockGestureRecognizer = UIGestureRecognizer
public typealias AxcBedrockTapGestureRecognizer = UITapGestureRecognizer

#endif

// MARK: - 数据转换

public extension AxcSpace where Base: AxcBedrockGestureRecognizer { }

// MARK: - 类方法

public extension AxcSpace where Base: AxcBedrockGestureRecognizer {
    /// （💈跨平台标识）创建方法
    static func Create(_ actionBlock: @escaping AxcBlock.Action<Base>) -> Base {
        let ges = Base()
        ges.axc.addAction(actionBlock)
        return ges
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: AxcBedrockGestureRecognizer {
    /// （💈跨平台标识）触发事件Block
    func addAction(_ actionBlock: @escaping AxcBlock.Action<Base>) {
        base._addActionBlock() { sender in
            guard let action = sender as? Base else { return }
            actionBlock(action)
        }
    }
}

// MARK: - AxcBedrockGestureRecognizer + AxcActionBlockTarget

extension AxcBedrockGestureRecognizer: AxcActionBlockTarget {
    public typealias ActionType = AxcBedrockGestureRecognizer
    /// 触发事件Block
    fileprivate func _addActionBlock(_ actionBlock: @escaping AxcBlock.Action<ActionType>) {
        setActionBlock(actionBlock)
        #if os(macOS)
        target = self
        action = #selector(blockAction)
        
        #elseif os(iOS) || os(tvOS)
        
        addTarget(self, action: #selector(blockAction))
        #endif
    }

    /// 触发的方法
    @objc
    fileprivate func blockAction() {
        guard let block = getActionBlock() else { return }
        block(self)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: AxcBedrockGestureRecognizer { }
