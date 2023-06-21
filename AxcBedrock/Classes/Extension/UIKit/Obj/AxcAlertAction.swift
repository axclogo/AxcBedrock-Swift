//
//  AxcAlertAction.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/27.
//

#if canImport(UIKit)

import UIKit

public extension AxcBedrockLib {
    /// 弹窗Action结构体
    struct AlertAction {
        /// 实例化方法
        public init(title: String,
                    style: UIAlertAction.Style = .default,
                    actionBlock: AxcBlock.Action<UIAlertAction>? = nil,
                    isEnabled: Bool = true) {
            self.title = title
            self.style = style
            self.actionBlock = actionBlock
            self.isEnabled = isEnabled
        }

        /// 标题
        public var title: String
        /// 样式
        public var style: UIAlertAction.Style = .default
        /// 事件回调
        public var actionBlock: AxcBlock.Action<UIAlertAction>?
        /// 启用状态
        public var isEnabled: Bool = true

        /// 创建一个取消样式的按钮
        /// - Parameter title: 标题
        public static func CancelAction(title: String,
                                        actionBlock: AxcBlock.Action<UIAlertAction>? = nil)
            -> AlertAction {
            return .init(title: title, style: .cancel)
        }
    }
}

#endif
