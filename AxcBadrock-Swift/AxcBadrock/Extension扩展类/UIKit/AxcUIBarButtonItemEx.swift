//
//  UIBarButtonItem.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/22.
//

import UIKit

extension UIBarButtonItem: AxcActionBlockProtocol {
    /// 快速添加响应事件
    /// - Parameter block: 响应Block
    public func axc_addAction(_ block: @escaping AxcActionBlock) {
        axc_setActionBlock(block)
        target = self
        action = #selector(itemAction)
    }
    /// 触发的方法
    @objc private func itemAction() {
        guard let block = axc_getActionBlock() else { return }
        block(self)
    }
}
