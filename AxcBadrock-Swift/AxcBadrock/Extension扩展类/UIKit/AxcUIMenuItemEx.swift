//
//  AxcUIMenuItemEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/17.
//

import UIKit

// MARK: - 类方法/属性
extension UIMenuItem: AxcActionBlockProtocol {
    ///一个带block回调的实例化
    /// - Parameters:
    ///   - title: 标题
    ///   - actionBlock: actionBlock
    convenience public init(title: String, _ actionBlock: @escaping AxcActionBlock) {
        self.init(title: title, action: #selector(itemAction) )
        axc_setActionBlock(actionBlock)
    }
    /// 触发的方法
    @objc private func itemAction() {
        guard let block = axc_getActionBlock() else { return }
        block(self)
    }
}

