//
//  Axc.Register.swift
//  AxcBadrock
//
//  Created by 赵新 on 2021/12/21.
//

#if canImport(UIKit)

import UIKit

/// 注册结构体
public typealias AxcRegister = AxcBedrockLib.Register

// MARK: - [AxcBedrockLib.Register]

public extension AxcBedrockLib {
    /// 注册结构体
    struct Register {
        public init(_ classType: UIView.Type = UIView.self,
                    identifier: String? = nil,
                    style: Style = .cell,
                    useNib: Bool = false) {
            self.classType = classType
            self.identifier = identifier ?? NSStringFromClass(classType)
            self.style = style
            self.useNib = useNib
        }

        /// 注册位置
        public enum Style {
            /// cell
            case cell
            /// 头部
            case header
            /// 尾部
            case footer
        }

        /// 类
        public var classType = UIView.self
        /// id
        public var identifier = ""
        /// 注册位置
        public var style: Style = .cell
        /// 是否使用nib加载
        public var useNib = false
    }
}

#endif
