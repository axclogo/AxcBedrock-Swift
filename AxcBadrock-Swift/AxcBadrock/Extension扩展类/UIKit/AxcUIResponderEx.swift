//
//  AxcUIResponderEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/4/21.
//

import UIKit

// MARK: - 数据转换
public extension UIResponder {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 类方法/属性
public extension UIResponder {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 属性 & Api
public extension UIResponder {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 通知监听
public extension UIResponder {
    typealias AxcKeyboardBlock = (CGFloat,TimeInterval) -> Void
    /// 键盘即将出现
    /// - Parameter block: 回调
    func axc_setKeyboardWillShowBlock(_ block: @escaping AxcKeyboardBlock) {
        axc_notificationCenter.axc_addNotification(Self.keyboardWillShowNotification)
        { [weak self] notification in
            guard let weakSelf = self,
                  let tuples = weakSelf.axc_getKeyboardHeightDuration(notification)
            else { return }
            block(tuples.0,tuples.1)
        }.axc_setCycle(axc_notificationCycle)
    }
    /// 键盘已经出现
    /// - Parameter block: 回调
    func axc_setKeyboardDidShowBlock(_ block: @escaping AxcKeyboardBlock) {
        axc_notificationCenter.axc_addNotification(Self.keyboardDidShowNotification)
        { [weak self] notification in
            guard let weakSelf = self,
                  let tuples = weakSelf.axc_getKeyboardHeightDuration(notification)
            else { return }
            block(tuples.0,tuples.1)
        }.axc_setCycle(axc_notificationCycle)
    }
    /// 键盘即将消失
    /// - Parameter block: 回调
    func axc_setKeyboardWillHideBlock(_ block: @escaping AxcKeyboardBlock) {
        axc_notificationCenter.axc_addNotification(Self.keyboardWillHideNotification)
        { [weak self] notification in
            guard let weakSelf = self,
                  let tuples = weakSelf.axc_getKeyboardHeightDuration(notification)
            else { return }
            block(tuples.0,tuples.1)
        }.axc_setCycle(axc_notificationCycle)
    }
    /// 键盘已经消失
    /// - Parameter block: 回调
    func axc_setKeyboardDidHideBlock(_ block: @escaping AxcKeyboardBlock) {
        axc_notificationCenter.axc_addNotification(Self.keyboardDidHideNotification)
        { [weak self] notification in
            guard let weakSelf = self,
                  let tuples = weakSelf.axc_getKeyboardHeightDuration(notification)
            else { return }
            block(tuples.0,tuples.1)
        }.axc_setCycle(axc_notificationCycle)
    }
    
    /// 通过通知获取键盘的高度和动画时间
    /// - Parameter notification: 通知信息
    /// - Returns: 元组: 1 高度 2 时间
    func axc_getKeyboardHeightDuration(_ notification: Notification) -> (CGFloat,TimeInterval)? {
        guard let userInfo = notification.userInfo as? [String:Any],
              let value = userInfo[Self.keyboardFrameEndUserInfoKey] as? NSValue,
              let duration = userInfo[Self.keyboardAnimationDurationUserInfoKey] as? NSNumber // 键盘弹出动画时间
        else { return nil }
        let keyBoardRect = value.cgRectValue
        let keyBoardHeight = keyBoardRect.axc_height // 得到键盘高度
        return (keyBoardHeight,duration.doubleValue)
    }
}

// MARK: - 决策判断
public extension UIResponder {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 操作符
public extension UIResponder {
}

// MARK: - 运算符
public extension UIResponder {
}
