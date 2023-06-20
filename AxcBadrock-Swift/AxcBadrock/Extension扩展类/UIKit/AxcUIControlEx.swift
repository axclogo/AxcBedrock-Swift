//
//  AxcUIControlEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/21.
//

import UIKit

// MARK: - 属性 & Api
public extension UIControl {

}
 
// MARK: - Block触发
extension UIControl: AxcActionBlockProtocol {
    /// 通过Block方式触发
    /// - Parameters:
    ///   - event: 事件
    ///   - actionBlock: 回调
    public func axc_addEvent(_ event: UIControl.Event = .touchUpInside, actionBlock: @escaping AxcActionBlock ) {
        axc_setActionBlock(actionBlock)
        addTarget(self, action: #selector(itemAction), for: event)
    }
    /// 移除触发事件
    /// - Parameter event: 事件
    public func axc_removeEvent(_ event: UIControl.Event = .touchUpInside){
        removeTarget(self, action: #selector(itemAction), for: event)
    }
    
    /// 触发的方法
    @objc private func itemAction() {
        guard let block = axc_getActionBlock() else { return }
        block(self)
    }
}
