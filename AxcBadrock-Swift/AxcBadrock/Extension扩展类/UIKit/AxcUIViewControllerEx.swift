//
//  AxcUIViewControllerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/23.
//

import UIKit

// MARK: - 类方法/属性
public extension UIViewController {
}

// MARK: - 属性 & Api
public extension UIViewController {
    // MARK: 推出视图
    /// pullUp拉起一个单选
    /// - Parameters:
    ///   - title: 标题
    ///   - dataList: 数据源
    ///   - selectedBlock: 选中回调block
    ///   - animation: 动画
    ///   - completion: 完成动画
    /// - Returns: AxcPickerView
    @discardableResult
    func axc_presentPickerView(_ title: String? = nil,
                               dataList: [Any],
                               selectedBlock: @escaping (_ pickerView: AxcPickerView, _ index: Int) -> Void,
                               animated: Bool = true,
                               completion: AxcEmptyBlock? = nil) -> AxcPickerView {
        let pickerView = AxcPickerView(title, dataList: dataList, selectedBlock: selectedBlock)
        let alentVC = axc_presentSheetView(pickerView, animated: animated, completion: completion)
        pickerView.axc_leftButton.axc_addEvent { (_) in alentVC.axc_dismissViewController() }
        pickerView.axc_rightButton.axc_addEvent { (_) in
            selectedBlock(pickerView,pickerView.axc_selectedIdx)
            alentVC.axc_dismissViewController()
        }
        return pickerView
    }
    /// presentSheet一个View
    /// - Parameters:
    ///   - view: 要推出的视图
    ///   - size: 视图大小
    ///   - showDirection: 支持按位与运算，支持单选
    ///     多选状态下，支持拉伸约束，单选仅支持size大小变化
    ///   - animation: 动画
    ///   - completion: 完成回调
    /// - Returns: AxcSheetVC
    @discardableResult
    func axc_presentSheetView(_ view: UIView,
                              size: CGSize? = nil,
                              showDirection: AxcDirection = .bottom,
                              animated: Bool = true,
                              completion: AxcEmptyBlock? = nil) -> AxcAlentVC {
        let alentVC = AxcAlentVC(view: view, size: size, showDirection: showDirection)
        axc_presentViewController(alentVC, animated: animated, completion: completion)
        return alentVC
    }
    
    /// 返回一个vc，无论是present还是push
    func axc_backViewController(animated: Bool = true, completion: AxcEmptyBlock? = nil) {
        dismiss(animated: animated, completion: completion)
        navigationController?.axc_popViewController(animated: animated, completion: completion)
    }
    /// 拉起一个vc，present
    func axc_presentViewController(_ vc: UIViewController, animated: Bool = true, completion: AxcEmptyBlock? = nil) {
        present(vc, animated: animated, completion: completion)
    }
    /// 返回一个present的vc
    func axc_dismissViewController(animated: Bool = true, completion: AxcEmptyBlock? = nil) {
        dismiss(animated: animated, completion: completion)
    }
    
    // MARK: 系统弹窗
    /// 弹出一个提示Alent
    /// - Parameters:
    ///   - msg: 消息
    ///   - style: 样式
    ///   - actionBlock: 触发Block
    func axc_popAlentPrompt(_ msg: String, style: UIAlertController.Style = .alert, actionBlock: AxcActionBlock? = nil) {
        axc_popAlent(title: AxcBadrockLanguage("提示"), msg: msg, actionTitles: [AxcBadrockLanguage("确定")],
                     style: style, actionBlock: actionBlock)
    }
    
    /// 弹出一个警告Alent
    /// - Parameters:
    ///   - msg: 消息
    ///   - style: 样式
    ///   - actionBlock: 触发Block
    func axc_popAlentWarning(_ msg: String, style: UIAlertController.Style = .alert, actionBlock: AxcActionBlock? = nil) {
        axc_popAlent(title: AxcBadrockLanguage("警告"), msg: msg, actionTitles: [AxcBadrockLanguage("确定")],
                     style: style, actionBlock: actionBlock)
    }
    
    /// 弹出一个alent
    /// - Parameters:
    ///   - title: 标题
    ///   - msg: 消息
    ///   - actionTitles: 触发标题组
    ///   - cancelTitle: 取消标题
    ///   - style: 样式
    ///   - actionBlock: action触发，
    ///   如果需要确定idx，则可以调用
    ///     let action = sender as? UIAlertAction;
    ///     let idx =  action.axc_intTag
    func axc_popAlent(title: String, msg: String? = nil,
                      actionTitles: [String], cancelTitle: String? = nil,
                      style: UIAlertController.Style = .alert,
                      tintColor: UIColor? = nil,
                      actionBlock: AxcActionBlock? = nil ) {
        let alentVC = UIAlertController(title: title, msg: msg,
                                        actionTitles: actionTitles, cancelTitle: cancelTitle,
                                        style: style, tintColor: tintColor,
                                        actionBlock: actionBlock)
        present(alentVC, animated: true, completion: nil)
    }
    
    // MARK: NavItem操作
    /// 添加一个富文本标题Navitem
    /// - Parameters:
    ///   - attributedTitle: 富文本
    ///   - direction: 方位
    ///   - actionBlock: 触发事件
    func axc_addAttributedTitleNavBarItem(attributedTitle: NSAttributedString,
                                          size: CGSize? = nil,
                                          direction: AxcDirection = .left,
                                          actionBlock: @escaping AxcActionBlock){
        axc_addNavBarItem(attributedTitle: attributedTitle, size: size, contentLayout: .text, direction: direction, actionBlock: actionBlock)
    }
    /// 设置一个富文本标题Navitem
    /// - Parameters:
    ///   - attributedTitle: 富文本
    ///   - direction: 方位
    ///   - actionBlock: 触发事件
    func axc_setAttributedTitleNavBarItem(attributedTitle: NSAttributedString,
                                          size: CGSize? = nil,
                                          direction: AxcDirection = .left,
                                          actionBlock: @escaping AxcActionBlock){
        axc_setNavBarItem(attributedTitle: attributedTitle, size: size, contentLayout: .text, direction: direction, actionBlock: actionBlock)
    }
    
    /// 添加一个标题Navitem
    /// - Parameters:
    ///   - title: 标题
    ///   - font: 标题字体
    ///   - direction: 方位
    ///   - actionBlock: 触发事件
    func axc_addTitleNavBarItem(title: String, font: UIFont? = nil,
                                textColor: UIColor? = nil,
                                size: CGSize? = nil,
                                direction: AxcDirection = .left,
                                actionBlock: @escaping AxcActionBlock){
        axc_addNavBarItem(title: title, font: font, textColor: textColor,
                          size: size, contentLayout: .text,
                          direction: direction, actionBlock: actionBlock)
    }
    /// 设置一个标题Navitem
    /// - Parameters:
    ///   - title: 标题
    ///   - font: 标题字体
    ///   - direction: 方位
    ///   - actionBlock: 触发事件
    func axc_setTitleNavBarItem(title: String, font: UIFont? = nil,
                                textColor: UIColor? = nil,
                                size: CGSize? = nil,
                                direction: AxcDirection = .left,
                                actionBlock: @escaping AxcActionBlock){
        axc_setNavBarItem(title: title, font: font, textColor: textColor,
                          size: size, contentLayout: .text,
                          direction: direction, actionBlock: actionBlock)
    }
    
    /// 添加一个图片Navitem
    /// - Parameters:Navitem
    ///   - image: 图片
    ///   - direction: 方位
    ///   - actionBlock: 触发事件
    func axc_addImageNavBarItem(image: UIImage, size: CGSize? = nil,direction: AxcDirection = .left,
                                actionBlock: @escaping AxcActionBlock){
        axc_addNavBarItem(image: image, size: size,
                          contentLayout: .img, direction: direction,
                          actionBlock: actionBlock)
    }
    /// 设置一个图片Navitem
    /// - Parameters:Navitem
    ///   - image: 图片
    ///   - direction: 方位
    ///   - actionBlock: 触发事件
    func axc_setImageNavBarItem(image: UIImage, size: CGSize? = nil,direction: AxcDirection = .left,
                                actionBlock: @escaping AxcActionBlock){
        axc_setNavBarItem(image: image, size: size,
                          contentLayout: .img,
                          direction: direction,
                          actionBlock: actionBlock)
    }
    
    /// 添加一个NavItem按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - font: 标题字体
    ///   - attributedTitle: 标题富文本
    ///   - image: 图片
    ///   - size: 大小
    ///   - contentLayout: 按钮布局方式
    ///   - direction: 左右
    ///   - animate: 添加动画
    ///   - actionBlock: 触发
    func axc_addNavBarItem(title: String? = nil, font: UIFont? = nil,
                           textColor: UIColor? = nil,
                           attributedTitle: NSAttributedString? = nil,
                           image: UIImage? = nil, size: CGSize? = nil,
                           contentLayout: AxcButtonStyle = .imgLeft_textRight,
                           contentInset: UIEdgeInsets = .zero,
                           direction: AxcDirection = .left,
                           animate: Bool = true,
                           actionBlock: @escaping AxcActionBlock) {
        navigationItem.axc_addBarItem(title: title, font: font,
                                      textColor: textColor,
                                      attributedTitle: attributedTitle,
                                      image: image, size: size,
                                      contentLayout: contentLayout,
                                      contentInset: contentInset,
                                      direction: direction,
                                      animate: animate,
                                      actionBlock: actionBlock)
    }
    /// 设置一个NavItem按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - font: 标题字体
    ///   - attributedTitle: 标题富文本
    ///   - image: 图片
    ///   - size: 大小
    ///   - contentLayout: 按钮布局方式
    ///   - direction: 左右
    ///   - actionBlock: 触发
    func axc_setNavBarItem(title: String? = nil, font: UIFont? = nil,
                           textColor: UIColor? = nil,
                           attributedTitle: NSAttributedString? = nil,
                           image: UIImage? = nil, size: CGSize? = nil,
                           contentLayout: AxcButtonStyle = .imgLeft_textRight,
                           contentInset: UIEdgeInsets = .zero,
                           direction: AxcDirection = .left,
                           actionBlock: @escaping AxcActionBlock) {
        navigationItem.axc_setBarItem(title: title, font: font,
                                      textColor: textColor,
                                      attributedTitle: attributedTitle,
                                      image: image, size: size,
                                      contentLayout: contentLayout,
                                      contentInset: contentInset,
                                      direction: direction,
                                      actionBlock: actionBlock)
    }
}

// MARK: - 决策判断
public extension UIViewController {
    // MARK: 协议
    // MARK: 扩展
}

// MARK: - 操作符
public extension UIViewController {
}

// MARK: - 运算符
public extension UIViewController {
}
