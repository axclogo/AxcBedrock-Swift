//
//  AxcResponderMenuActionType.swift
//  AxcUIKit
//
//  Created by 赵新 on 2022/12/28.
//
#if canImport(UIKit)

import UIKit

/// 响应菜单事件类型
public typealias AxcResponderMenuActionType = AxcBedrockLib.ResponderMenuActionType
public extension AxcEnum {
    /// 响应菜单事件类型
    enum ResponderMenuActionType: String, CaseIterable {
        /// 通过响应者和选择器实例化枚举
        /// - Parameters:
        ///   - action: 响应者
        ///   - selector: 选择器
        public init?(action: UIResponder, selector: Selector) {
            switch selector {
            case #selector(action.cut(_:)): self = .cut
            case #selector(action.copy(_:)): self = .copy
            case #selector(action.paste(_:)): self = .paste
            case #selector(action.select(_:)): self = .select
            case #selector(action.selectAll(_:)): self = .selectAll
            case #selector(action.delete(_:)): self = .delete
            default: return nil
            }
        }

        /// 剪贴
        case cut
        /// 复制
        case copy
        /// 粘贴
        case paste
        /// 选择
        case select
        /// 全选
        case selectAll
        /// 删除
        case delete

        /// 根据响应者获取该枚举的选择器
        /// - Parameter action: 响应者
        /// - Returns: 选择器
        public func selector(action: UIResponder) -> Selector {
            switch self {
            case .cut: return #selector(action.cut(_:))
            case .copy: return #selector(action.copy(_:))
            case .paste: return #selector(action.paste(_:))
            case .select: return #selector(action.select(_:))
            case .selectAll: return #selector(action.selectAll(_:))
            case .delete: return #selector(action.delete(_:))
            }
        }
    }
}

#endif
