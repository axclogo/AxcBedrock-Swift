//
//  AxcResponderMenuActionTarget.swift
//  AxcUIKit
//
//  Created by 赵新 on 2022/12/28.
//

#if canImport(UIKit)

import UIKit

// MARK: - [AxcResponderMenuActionTarget]

public protocol AxcResponderMenuActionTarget where Self: UIResponder { }

public extension AxcResponderMenuActionSpace {
    /// 根据选择器获取菜单事件类型
    /// - Parameter selector: 选择器
    /// - Returns: 菜单事件类型
    func menuActionType(selector: Selector) -> AxcResponderMenuActionType? {
        let actionType = AxcResponderMenuActionType(action: base, selector: selector)
        return actionType
    }

    /// 过滤菜单事件类型
    ///
    ///     主要配合方法：
    ///     canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool
    ///     组合使用
    ///
    /// - Parameter selector: 选择器
    /// - Returns: 是否使用
    func filterMenuActionType(allowResponderMenuActionTypes: [AxcResponderMenuActionType]?,
                              selector: Selector) -> Bool? {
        guard let allowResponderMenuActionTypes = allowResponderMenuActionTypes,
              let menuActionType = menuActionType(selector: selector) else { return nil }
        return allowResponderMenuActionTypes.contains(menuActionType)
    }
}

// MARK: - [AxcResponderMenuActionSpace]

public struct AxcResponderMenuActionSpace<Base> where Base: AxcResponderMenuActionTarget {
    init(_ base: AxcResponderMenuActionTarget) {
        self.base = base
    }

    var base: AxcResponderMenuActionTarget
}

public extension AxcResponderMenuActionTarget {
    /// 命名空间
    var axc: AxcResponderMenuActionSpace<Self> {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcResponderMenuActionSpace<Self>.Type {
        return AxcResponderMenuActionSpace<Self>.self
    }
}

#endif
