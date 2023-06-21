//
//  AxcAnimationGroupMaker.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/28.
//

import QuartzCore

// MARK: - [AxcMaker.AnimationGroup]

public extension AxcMaker {
    /// Layer动画Maker
    class AnimationGroup: AxcMaker.Animation<CAAnimationGroup> { }
}

public extension AxcMaker.AnimationGroup {
    /// 设置动画集合
    @discardableResult
    func set(animations: [CAAnimation]) -> Self {
        animation.animations = animations
        return self
    }

    /// 向动画组添加动画
    @discardableResult
    func append(animation: CAAnimation) -> Self {
        var _animations: [CAAnimation] = []
        if let _animationsArr = self.animation.animations {
            _animations = _animationsArr
        }
        _animations.append(animation)
        set(animations: _animations)
        return self
    }
}
