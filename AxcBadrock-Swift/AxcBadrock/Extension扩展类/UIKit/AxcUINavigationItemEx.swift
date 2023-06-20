//
//  AxcUINavigationItemEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/20.
//

import UIKit

// MARK: - 属性 & Api
public extension UINavigationItem {
    /// 设置左右按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - font: 标题字体
    ///   - attributedTitle: 标题富文本
    ///   - image: 图片
    ///   - size: 大小
    ///   - contentLayout: 布局
    ///   - contentInset: 内容边距
    ///   - direction: 方位
    ///   - actionBlock: 触发函数
    func axc_setBarItem(title: String? = nil, font: UIFont? = nil,
                        textColor: UIColor? = nil,
                        attributedTitle: NSAttributedString? = nil,
                        image: UIImage? = nil, size: CGSize? = nil,
                        contentLayout: AxcButtonStyle = .img ,
                        contentInset: UIEdgeInsets = .zero,
                        direction: AxcDirection = .left,
                        actionBlock: @escaping AxcActionBlock){
        let item = axc_makeBarButtonItem(title: title, font: font,
                                         textColor: textColor,
                                         attributedTitle: attributedTitle,
                                         image: image, size: size,
                                         contentLayout: contentLayout,
                                         contentInset: contentInset,
                                         actionBlock: actionBlock)
        axc_setBarItem(item, direction: direction)
    }
    /// 设置一个BarLabel
    /// - Parameters:
    ///   - label: label
    ///   - size: 大小
    ///   - direction: 方位
    ///   - actionBlock: 触发函数
    func axc_setBarLabel(_ label: UILabel, size: CGSize? = nil,
                         direction: AxcDirection = .left,
                         actionBlock: @escaping AxcActionBlock) {
        let item = axc_makeBarLabelItem(label, size: size,
                                        direction: direction,
                                        actionBlock: actionBlock)
        axc_setBarItem(item, direction: direction)
    }
    
    /// 设置一个BarItem
    /// - Parameters:
    ///   - item: item
    ///   - direction: 方位
    func axc_setBarItem(_ item: UIBarButtonItem,
                        direction: AxcDirection = .left) {
        guard direction.selectType([.left, .right]) else { return } // 左右可选
        if direction == .left { // 左
            self.leftBarButtonItem = item
        }else if direction == .right { // 右
            self.rightBarButtonItem = item
        }
    }
    
    /// 添加一个item按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - font: 标题字体
    ///   - attributedTitle: 标题富文本
    ///   - image: 图片
    ///   - size: 大小
    ///   - contentLayout: 布局
    ///   - contentInset: 内容边距
    ///   - animate: 添加动画
    ///   - actionBlock: 触发函数
    func axc_addBarItem(title: String? = nil, font: UIFont? = nil,
                        textColor: UIColor? = nil,
                        attributedTitle: NSAttributedString? = nil,
                        image: UIImage? = nil, size: CGSize? = nil,
                        contentLayout: AxcButtonStyle = .img ,
                        contentInset: UIEdgeInsets = .zero,
                        direction: AxcDirection = .left,
                        animate: Bool = true,
                        actionBlock: @escaping AxcActionBlock) {
        let item = axc_makeBarButtonItem(title: title, font: font,
                                         textColor: textColor,
                                         attributedTitle: attributedTitle,
                                         image: image, size: size,
                                         contentLayout: contentLayout,
                                         contentInset: contentInset,
                                         actionBlock: actionBlock)
        axc_addBarItem(item, direction: direction, animate: animate)
    }
    /// 添加一个BarLabel
    /// - Parameters:
    ///   - label: label
    ///   - size: 大小
    ///   - direction: 方位
    ///   - actionBlock: 触发函数
    func axc_addBarLabel(_ label: UILabel, size: CGSize? = nil,
                         direction: AxcDirection = .left,
                         actionBlock: @escaping AxcActionBlock) {
        let item = axc_makeBarLabelItem(label, size: size,
                                        direction: direction,
                                        actionBlock: actionBlock)
        axc_addBarItem(item, direction: direction)
    }
    
    /// 添加一个BarItem
    /// - Parameters:
    ///   - item: item
    ///   - direction: 方位
    ///   - animate: 添加动画
    func axc_addBarItem(_ item: UIBarButtonItem,
                        direction: AxcDirection = .left,
                        animate: Bool = true) {
        guard direction.selectType([.left, .right]) else { return } // 左右可选
        if direction == .left { // 左
            var items: [UIBarButtonItem] = []
            if let _items = self.leftBarButtonItems { items = _items }
            items.append(item)
            self.setLeftBarButtonItems(items, animated: animate)
        }else if direction == .right { // 右
            var items: [UIBarButtonItem] = []
            if let _items = self.rightBarButtonItems { items = _items }
            items.append(item)
            self.setRightBarButtonItems(items, animated: animate)
        }
    }
    
    /// 创建一个BarButtonItem
    /// - Parameters:
    ///   - title: 标题
    ///   - font: 标题字体
    ///   - textColor: 字色
    ///   - attributedTitle: 标题富文本
    ///   - image: 图片
    ///   - size: 大小
    ///   - contentLayout: 布局
    ///   - contentInset: 内容边距
    ///   - actionBlock: 触发方法
    /// - Returns: 返回UIBarButtonItem
    func axc_makeBarButtonItem(title: String? = nil, font: UIFont? = nil,
                               textColor: UIColor? = nil,
                               attributedTitle: NSAttributedString? = nil,
                               image: UIImage? = nil, size: CGSize? = nil,
                               contentLayout: AxcButtonStyle = .img ,
                               contentInset: UIEdgeInsets = .zero,
                               actionBlock: @escaping AxcActionBlock) -> UIBarButtonItem {
        var buttonView: UIView = UIView()
        let titleColor = textColor ?? .black
        if #available(iOS 13.0, *) {    // 做一个版本兼容
            let btn = AxcButton(title: title, image: image)
            btn.axc_titleLabel.font = font
            btn.axc_titleLabel.textColor = titleColor
            if attributedTitle != nil {
                btn.axc_titleLabel.attributedText = attributedTitle
            }
            btn.axc_contentInset = contentInset
            btn.axc_style = contentLayout
            btn.axc_addEvent(actionBlock: actionBlock)
            buttonView = btn
        }else{
            let btn = UIButton(title: title, image: image)
            btn.axc_font = font
            btn.setTitleColor(titleColor, for: .normal)
            if attributedTitle != nil {
                btn.setAttributedTitle(attributedTitle, for: .normal)
            }
            btn.axc_contentInset = contentInset
            btn.axc_addEvent(actionBlock: actionBlock)
            buttonView = btn
        }
        let itemSize = size ?? Axc_navigationItemSize
        let view = AxcBaseView(CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height))
        buttonView.frame = view.bounds
        view.addSubview(buttonView)
        let item = UIBarButtonItem(customView: view)
        item.width = itemSize.width
        return item
    }
    /// 封装一个label
    /// - Parameters:
    ///   - label: label
    ///   - size: 大小
    ///   - direction: 方位
    ///   - actionBlock: 触发
    func axc_makeBarLabelItem(_ label: UILabel, size: CGSize? = nil,
                              direction: AxcDirection = .left,
                              actionBlock: @escaping AxcActionBlock) -> UIBarButtonItem {
        label.axc_addTapGesture { (tap) in
            guard let _label = tap.view else { return }
            actionBlock(_label)
        }
        let itemSize = size ?? Axc_navigationItemSize
        let item = UIBarButtonItem(customView: label)
        item.width = itemSize.width
        return item
    }
    
    /// 移除按钮
    /// - Parameters:
    ///   - direction: 方位
    ///   - idx: 索引
    func axc_removeBarItem(direction: AxcDirection = .left, idx: Int? = nil) {
        guard direction.selectType([.left, .right]) else { return } // 左右可选
        if direction == .left { // 左
            if let _idx = idx {
                self.leftBarButtonItems?.axc_remove(_idx)
            }else{
                self.leftBarButtonItems = nil
            }
        }else if direction == .right { // 右
            if let _idx = idx {
                self.rightBarButtonItems?.axc_remove(_idx)
            }else{
                self.rightBarButtonItems = nil
            }
        }
    }
}


// MARK: - 决策判断
public extension UINavigationItem {
}

