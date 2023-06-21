//
//  AxcUIStackViewEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/3/3.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base: UIStackView { }

// MARK: - 类方法

public extension AxcSpace where Base: UIStackView { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: UIStackView {
    /// 添加视图
    /// - Parameter arrangedSubviews: 视图组
    func add(arrangedSubviews: [UIView]) {
        arrangedSubviews.forEach { base.addArrangedSubview($0) }
    }

    /// 移除全部的arrangedSubview视图
    func removeAllArrangedSubviews() {
        base.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }

    /// 获取arrangedSubview视图
    @available(*, deprecated, message: "此api已经废弃，请使用set(arrangedSubviews: [UIView])；xxxx.arrangedSubviews")
    var arrangedSubviews: [UIView] {
        set {
            set(arrangedSubviews: newValue)
        }
        get { return base.arrangedSubviews }
    }

    /// 设置arrangedSubview视图
    /// - Parameter arrangedSubviews: 视图组
    func set(arrangedSubviews: [UIView]) {
        removeAllArrangedSubviews()
        arrangedSubviews.forEach { base.addArrangedSubview($0)
        }
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: UIStackView { }

#endif
