//
//  AxcNSObjectEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2021/12/21.
//

import Foundation

// MARK: - NSObject + AxcSpaceProtocol

extension NSObject: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base: NSObject { }

// MARK: - 类方法

public extension AxcSpace where Base: NSObject {
    /// 获取本类的类名
    static var ClassName: String {
        return StringFromClass
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: NSObject {
    /// 获取对象的类名
    var className: String {
        return stringFromClass
    }
}

// MARK: - 延时执行

public extension AxcSpace where Base: NSObject {
    /// 延时执行一个操作
    /// 当该操作在延时内被频繁执行时，会不断更新延时时间
    /// 直到最后一次操作结束，且延时结束，才会执行ActionBlock
    func delayLast(_ delay: TimeInterval,
                   actionBlock: @escaping AxcBlock.Empty) {
        base._performSelectorBlock = actionBlock
        let sel = #selector(base._performSelector)
        Base.cancelPreviousPerformRequests(withTarget: base, selector: sel, object: nil)
        base.perform(sel,
                     with: nil,
                     afterDelay: delay)
    }
}

private var kyp_performSelectorBlock = "kyp_performSelectorBlock"
fileprivate extension NSObject {
    /// 调用的方法
    @objc
    func _performSelector() {
        _performSelectorBlock()
    }

    /// Runtime扩展回调Block
    var _performSelectorBlock: AxcBlock.Empty {
        set { AxcRuntime.Set(object: self, key: &kyp_performSelectorBlock, value: newValue, policy: .OBJC_ASSOCIATION_COPY) }
        get {
            guard let block: AxcBlock.Empty = AxcRuntime.GetObject(self, key: &kyp_performSelectorBlock) else {
                let block: AxcBlock.Empty = { }
                self._performSelectorBlock = block
                return { }
            }
            return block
        }
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: NSObject { }

// MARK: - 实例化方法

public extension NSObject { }

// MARK: - 运算符/操作符

public extension NSObject { }
