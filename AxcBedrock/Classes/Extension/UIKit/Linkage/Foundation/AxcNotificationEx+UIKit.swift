//
//  AxcNotificationEx+UIKit.swift
//  FBSnapshotTestCase
//
//  Created by 赵新 on 2023/2/13.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base == Notification { }

// MARK: - 类方法

public extension AxcSpace where Base == Notification { }

// MARK: - 属性 & Api

public extension AxcSpace where Base == Notification {
    /// 键盘开始时候的位置
    var keyboardBeginFrame: CGRect? {
        return base.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect
    }

    /// 键盘结束时候的位置
    var keyboardEndFrame: CGRect? {
        return base.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    }

    /// 键盘动画时间
    var keyboardAnimationDuration: CGFloat? {
        return base.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGFloat
    }

    /// 键盘动画时间曲线
    var keyboardAnimationCurve: UIView.AnimationCurve? {
        return base.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UIView.AnimationCurve
    }

    /// 键盘动画时间曲线
    var keyboardAnimationOptions: UIView.AnimationOptions? {
        return keyboardAnimationCurve?.axc.uiViewAnimationOptions
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base == Notification { }

#endif
