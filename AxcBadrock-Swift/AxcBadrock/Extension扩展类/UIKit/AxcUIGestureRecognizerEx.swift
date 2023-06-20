//
//  AxcUIGestureRecognizerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

// MARK: - 类方法/属性
public extension UIGestureRecognizer {
    ///一个带block回调的实例化
    /// - Parameter actionBlock: actionBlock
    convenience init(_ actionBlock: @escaping AxcGestureActionBlock) {
        self.init()
        axc_actionBlock = actionBlock
    }
}

// MARK: - 属性 & Api
public extension UIGestureRecognizer {
    /// 从view中移除
    func axc_removeFromView() {
        view?.removeGestureRecognizer(self)
    }
}

// MARK: - 添加回调Block
public typealias AxcGestureActionBlock = (UIGestureRecognizer) -> Void
/// actionBlock的键
private var kaxc_actionBlock = "kaxc_actionBlock"
public extension UIGestureRecognizer {
    /// 手势触发的Block
    var axc_actionBlock: AxcGestureActionBlock? {
        set {
            AxcRuntime.setObj(self, &kaxc_actionBlock, newValue, .OBJC_ASSOCIATION_COPY)
            addTarget(self, action: #selector(gestureAction(_:)))
        }
        get { guard let block: AxcGestureActionBlock = AxcRuntime.getObj(self, &kaxc_actionBlock) else { return nil }
            return block }
    }
    /// 手势触发的方法
    @objc private func gestureAction(_ sender: UIGestureRecognizer) {
        guard let block = axc_actionBlock else { return }
        block(sender)
    }
}
