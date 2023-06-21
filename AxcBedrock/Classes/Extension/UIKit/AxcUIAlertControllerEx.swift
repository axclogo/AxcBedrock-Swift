//
//  AxcUIAlertControllerEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/27.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base: UIAlertController {}

// MARK: - 扩展AxcSpaceStruct + AxcAssertionsTransformProtocol

public extension AxcSpace where Base: UIAlertController {
    /// 配合协议用创建方法
    static func Create(title: String? = nil,
                       message: String? = nil,
                       actions: [AxcBedrockLib.AlertAction],
                       style: UIAlertController.Style = .alert,
                       tintColor: AxcUnifiedColor? = nil) -> UIAlertController
    {
        let alertVC: UIAlertController = .init(title: title,
                                               message: message,
                                               preferredStyle: style)
        if let tintColor = tintColor {
            let color = AssertTransformColor(tintColor) // 颜色
            alertVC.view.tintColor = color
        }
        actions.forEach { alertVC.axc.addAlertAction($0) }
        return alertVC
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: UIAlertController {
    /// 添加一个按钮
    @discardableResult
    func addAlertAction(_ action: AxcBedrockLib.AlertAction) -> UIAlertAction {
        return addAlertAction(title: action.title,
                              style: action.style,
                              isEnabled: action.isEnabled,
                              actionBlock: action.actionBlock)
    }

    /// 添加一个按钮
    @discardableResult
    func addAlertAction(title: String,
                        style: UIAlertAction.Style = .default,
                        isEnabled: Bool = true,
                        actionBlock: AxcBlock.Action<UIAlertAction>? = nil) -> UIAlertAction
    {
        let action = UIAlertAction(title: title, style: style, handler: actionBlock)
        action.isEnabled = isEnabled
        /**
         如果崩溃信息为
         Thread 1: "UIAlertController can only have one action with a style of UIAlertActionStyleCancel"
         请检查是否传入了两个取消AlertAction，因为取消按钮只可存在一个
         */
        base.addAction(action)
        return action
    }

    /// 显示这个弹窗在当前VC上
    /// app扩展包中无法使用
    @available(iOSApplicationExtension, unavailable) 
    func show(viewController: UIViewController? = nil,
              animated: Bool = true,
              vibrate: Bool = false,
              completion: AxcBlock.Empty? = nil)
    {
        let currentVC: UIViewController? = viewController ?? AxcBedrockLib.App.CurrentVC
        currentVC?.present(base, animated: animated, completion: completion)
    }
}

private let kattributedTitle = "attributedTitle"
private let kattributedMessage = "attributedMessage"
public extension AxcSpace where Base: UIAlertController {
    /// 标题的富文本
    var attributedTitle: NSAttributedString? {
        set { base.setValue(newValue, forKey: kattributedTitle) }
        get {
            guard let att = base.value(forKey: kattributedTitle) as? NSAttributedString else { return nil }
            return att
        }
    }

    /// 获取消息内容的富文本
    var attributedMessage: NSAttributedString? {
        set { base.setValue(newValue, forKey: kattributedMessage) }
        get {
            guard let att = base.value(forKey: kattributedMessage) as? NSAttributedString else { return nil }
            return att
        }
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: UIAlertController {}

#endif
