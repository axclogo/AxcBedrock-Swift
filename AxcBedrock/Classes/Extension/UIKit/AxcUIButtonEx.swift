//
//  AxcUIButtonEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2022/10/24.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base: UIButton { }

// MARK: - 类方法

public extension AxcSpace where Base: UIButton { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: UIButton {
    /// 根据状态设置背景色
    /// - Parameters:
    ///   - color: 颜色
    ///   - forState: 状态
    func set(backgroundColor: UIColor, state: UIControl.State) {
        base.clipsToBounds = true
        guard let image = backgroundColor.axc.uiImage else { return }
        base.setBackgroundImage(image, for: state)
    }

    /// 设置字体
    var uiFont: UIFont? {
        set { base.titleLabel?.font = newValue }
        get { base.titleLabel?.font }
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: UIButton { }

#endif
