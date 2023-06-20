//
//  AxcCAAnimationGroupEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/28.
//

import UIKit

// MARK: - 链式语法
public extension CAAnimationGroup {
    /// 向动画组添加动画
    /// - Parameter animation: 动画对象
    @discardableResult
    func axc_addAnimation(_ animation: CAAnimation ) -> Self {
        var _animations: [CAAnimation] = []
        if let _animationsArr = animations { _animations = _animationsArr }
        _animations.append(animation)
        animations = _animations
        return self
    }
}
