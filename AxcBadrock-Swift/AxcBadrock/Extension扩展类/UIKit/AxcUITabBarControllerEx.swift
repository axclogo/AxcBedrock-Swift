//
//  AxcUITabBarControllerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

// MARK: - 属性 & Api
/// item结构体
public struct AxcTabItem {
    var className:          String = "AxcBaseVC"                    // 页面类名
    var navClassName:       String = "AxcBaseNavVC"         // 页面对应的导航控制器类名
    var title:              String = ""                             // 上标题
    var itemTitle:          String = ""                             // item标题
    // 未选中
    var normalImg:          UIImage                 = AxcBadrockBundle.placeholderImage // 正常图片
    var normalImgSize:      CGSize                  = CGSize((25,25))                   // 正常图片大小
    var normalImgMode:      UIImage.RenderingMode   = .alwaysOriginal                   // 正常图片模式
    var normalImgColor:     UIColor?                                                    // 图片颜色
    // 选中
    var selectedImg:        UIImage                 = AxcBadrockBundle.placeholderImage // 选中图片
    var selectedImgSize:    CGSize                  = CGSize((25,25))                   // 选中图片大小
    var selectedImgMode:    UIImage.RenderingMode   = .alwaysOriginal                   // 选中图片模式
    var selectedImgColor:   UIColor?                                                    // 图片颜色
    /// 实例化
    public init(className:          String? = nil,
                navClassName:       String? = nil,
                title:              String? = nil,
                itemTitle:          String? = nil,
                
                normalImg:          UIImage?                = nil,
                normalImgSize:      CGSize?                 = nil,
                normalImgMode:      UIImage.RenderingMode?  = nil,
                normalImgColor:     UIColor?                = nil,
                
                selectedImg:        UIImage?                = nil,
                selectedImgSize:    CGSize?                 = nil,
                selectedImgMode:    UIImage.RenderingMode?  = nil,
                selectedImgColor:   UIColor?                = nil ) {
        if let _className = className           { self.className    = _className }
        if let _navClassName = navClassName     { self.navClassName = _navClassName }
        if let _title = title                   { self.title        = _title }
        if let _itemTitle = itemTitle           { self.itemTitle    = _itemTitle }
        else { self.itemTitle = self.title }
        // 未选中
        if let _normalImg = normalImg           { self.normalImg        = _normalImg }
        if let _normalImgSize = normalImgSize   { self.normalImgSize    = _normalImgSize }
        if let _normalImgMode = normalImgMode   { self.normalImgMode    = _normalImgMode }
        if let _normalImgColor = normalImgColor { self.normalImgColor   = _normalImgColor }
        //  选中图片
        if let _selectedImg = selectedImg           { self.selectedImg      = _selectedImg }
        if let _selectedImgSize = selectedImgSize   { self.selectedImgSize  = _selectedImgSize }
        if let _selectedImgMode = selectedImgMode   { self.selectedImgMode  = _selectedImgMode }
        if let _selectedImgColor = selectedImgColor { self.selectedImgColor = _selectedImgColor }
    }
}

public extension UITabBarController {
    /// 创建tab栏
    /// - Parameter item: item
    func axc_addTabItem(_ item: AxcTabItem) {   // 不能设置vc的backgroundColor，否则会执行viewDidLoad，造成性能损失
        guard let _vcClass = item.className.axc_class     as? UIViewController.Type else { return }
        guard let _navClass = item.navClassName.axc_class as? UINavigationController.Type else { return }
        let vc = _vcClass.init()
        let currentIdx = (viewControllers?.count ?? 0) + 1
        let title = "[ \(currentIdx) ]"
        if item.title.count == 0 { vc.title = title }
        else { vc.title = item.title }
        let navVC = _navClass.init(rootViewController: vc)  // 包装nav
        // item
        var itemTitle = item.itemTitle
        if item.itemTitle.count == 0 { itemTitle = title }
        var tabNormalImg = (item.normalImg.size == item.normalImgSize) ? item.normalImg : item.normalImg.axc_setScale(size: item.normalImgSize)
        if let normalImgColor = item.normalImgColor {   // 如果有设置颜色
            tabNormalImg = tabNormalImg?.axc_setTintColor( normalImgColor )
        }
        tabNormalImg = tabNormalImg?.withRenderingMode( item.normalImgMode )
        var tabSelectedImg = (item.selectedImg.size == item.selectedImgSize) ? item.selectedImg : item.selectedImg.axc_setScale(size: item.selectedImgSize)
        if let selectedImgColor = item.selectedImgColor {   // 如果有设置颜色
            tabSelectedImg = tabSelectedImg?.axc_setTintColor( selectedImgColor )
        }
        tabSelectedImg = tabSelectedImg?.withRenderingMode( item.selectedImgMode )
        let _tabbarItem = UITabBarItem(title: itemTitle, image: tabNormalImg, selectedImage: tabSelectedImg)
        navVC.tabBarItem = _tabbarItem;
        addChild(navVC)
    }
}

// MARK: - item操作相关
private var k_items = "k_items"
public extension UITabBarController {
    /// 私有保存items
    private var _items: [UITabBarItem] {
        set { AxcRuntime.setObj(self, &k_items, newValue) }
        get {
            guard let items: [UITabBarItem] = AxcRuntime.getObj(self, &k_items) else {
                var itemArray = [UITabBarItem]()
                viewControllers?.forEach{ itemArray.append($0.tabBarItem) }
                AxcRuntime.setObj(self, &k_items, itemArray)
                return itemArray
            }
            return items
        }
    }
    /// 通过index获取item
    func axc_item(_ idx: Int) -> UITabBarItem? {
        guard idx < _items.count  else { AxcLog("设置UITabBarItem的索引越界！index: %@",idx , level: .fatal); return nil }
        return _items[idx]
    }
    
    // MARK: 文字状态
    /// 设置item的文字未选中颜色
    /// - Parameters:
    ///   - color: 颜色
    func axc_itemNormalTextColor(_ color: UIColor ) {
        UITabBarItem.appearance().axc_normalTextColor(color)
    }
    /// 设置item的文字选中颜色
    /// - Parameters:
    ///   - color: 颜色
    func axc_itemSelectedTextColor(_ color: UIColor ) {
        UITabBarItem.appearance().axc_selectedTextColor(color)
    }
    
    // MARK: 图片状态
    /// 设置item的图片未选中颜色
    /// - Parameters:
    ///   - color: 颜色
    func axc_itemNormalImageColor(_ color: UIColor ) {
        tabBar.unselectedItemTintColor = color
    }
    /// 设置item的图片选中颜色
    /// - Parameters:
    ///   - color: 颜色
    func axc_itemSelectedImageColor(_ color: UIColor, _ idx: Int? = nil ) {
        tabBar.tintColor = color
    }
    
    // MARK: 徽标状态
    /// 设置item的徽标值
    /// - Parameters:
    ///   - text: 值
    ///   - idx: 索引
    func axc_setItemBadgeText(_ text: String, _ idx: Int ) {
        guard let item = axc_item(idx) else { return }
        item.badgeValue = text
    }
    /// 设置item的徽标偏移量
    /// - Parameters:
    ///   - offset: 偏移量
    ///   - idx: 索引
    func axc_setItemBadgeOffset(_ offset: CGSize, _ idx: Int ) {
        guard let item = axc_item(idx) else { return }
        item.titlePositionAdjustment = UIOffset(horizontal: offset.width, vertical: offset.height)
    }
    /// 设置item的徽标颜色
    /// - Parameters:
    ///   - color: 颜色
    ///   - idx: 索引
    func axc_setItemBadgeColor(_ color: UIColor, _ idx: Int ) {
        guard let item = axc_item(idx) else { return }
        item.badgeColor = color
    }
    /// 设置item的徽标富文本
    /// - Parameters:
    ///   - textAttributes: 富文本
    ///   - idx: 索引
    func axc_setItemBadgeTextAttributes(_ textAttributes: [NSAttributedString.Key : Any], state: UIControl.State, _ idx: Int ) {
        guard let item = axc_item(idx) else { return }
        item.setBadgeTextAttributes(textAttributes, for: state)
    }
    
}

// MARK: - 决策判断
public extension UITabBarController {
    
}

// MARK: - 代理转Block
private var kaxc_tabBarControllerDelegate = "kaxc_tabBarControllerDelegate"
public extension UITabBarController {
    /// 返回UITabBarController,[UIViewController]的Block声明
    typealias AxcViewControllersBlock<T> = (UITabBarController,[UIViewController]) -> T
    /// 返回UITabBarController,UIViewControllerAnimatedTransitioning的Block声明
    typealias AxcViewControllerAnimatedTransitioningBlock<T> = (UITabBarController,UIViewControllerAnimatedTransitioning) -> T
    /// 返回UITabBarController,UIViewController,UIViewController的Block声明
    typealias AxcViewControllerViewControllerBlock<T> = (UITabBarController,UIViewController,UIViewController) -> T
    /// 返回UITabBarController,UIViewController的Block声明
    typealias AxcViewControllerBlock<T> = (UITabBarController,UIViewController) -> T
    /// 返回UITabBarController的Block声明
    typealias AxcBlock<T> = (UITabBarController) -> T
    /// 返回UITabBarController,[UIViewController],Bool的Block声明
    typealias AxcViewControllerBoolBlock<T> = (UITabBarController,[UIViewController],Bool) -> T
    
    /// 代理桥接者
    var axc_tabBarControllerDelegate: AxcTabBarControllerDelegate {
        set { AxcRuntime.setObj(self, &kaxc_tabBarControllerDelegate, newValue)
            self.delegate = newValue
        }
        get {
            guard let delegate: AxcTabBarControllerDelegate  = AxcRuntime.getObj(self, &kaxc_tabBarControllerDelegate)
            else {
                let delegate = AxcTabBarControllerDelegate()
                self.axc_tabBarControllerDelegate = delegate
                self.delegate = delegate
                return delegate
            }
            return delegate
        }
    }
    /// 块设置代理方法
    /// - Parameter block: block
    func axc_makeTabBarControllerDelegate(_ block: (AxcTabBarControllerDelegate) -> Void) {
        block(axc_tabBarControllerDelegate)
    }
}


// MARK: 桥接者
/// 代理转Block桥接者
open class AxcTabBarControllerDelegate: NSObject, UITabBarControllerDelegate {
    /// optional func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool
    @discardableResult
    open func axc_setTabBarControllerShouldSelectBlock(_ block: @escaping UITabBarController.AxcViewControllerBlock<Bool>) -> Self {
        axc_tabBarControllerShouldSelectBlock = block
        return self
    }
    open lazy var axc_tabBarControllerShouldSelectBlock: UITabBarController.AxcViewControllerBlock<Bool>
        = { _,_ in return true }
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return axc_tabBarControllerShouldSelectBlock(tabBarController,viewController)
    }
    
    
    /// optional func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
    @discardableResult
    open func axc_setTabBarControllerDidSelectBlock(_ block: @escaping UITabBarController.AxcViewControllerBlock<Void>) -> Self {
        axc_tabBarControllerDidSelectBlock = block
        return self
    }
    open lazy var axc_tabBarControllerDidSelectBlock: UITabBarController.AxcViewControllerBlock<Void>
        = { _,_ in  }
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) -> Void {
         axc_tabBarControllerDidSelectBlock(tabBarController,viewController)
    }
    
    
    /// optional func tabBarController(_ tabBarController: UITabBarController, willBeginCustomizing viewControllers: [UIViewController])
    @discardableResult
    open func axc_setTabBarControllerWillBeginCustomizingBlock(_ block: @escaping UITabBarController.AxcViewControllersBlock<Void>) -> Self {
        axc_tabBarControllerWillBeginCustomizingBlock = block
        return self
    }
    open lazy var axc_tabBarControllerWillBeginCustomizingBlock: UITabBarController.AxcViewControllersBlock<Void>
        = { _,_ in  }
    public func tabBarController(_ tabBarController: UITabBarController, willBeginCustomizing viewControllers: [UIViewController]) -> Void {
         axc_tabBarControllerWillBeginCustomizingBlock(tabBarController,viewControllers)
    }
    
    
    /// optional func tabBarController(_ tabBarController: UITabBarController, willEndCustomizing viewControllers: [UIViewController], changed: Bool)
    @discardableResult
    open func axc_setTabBarControllerWillEndCustomizingChangedBlock(_ block: @escaping UITabBarController.AxcViewControllerBoolBlock<Void>) -> Self {
        axc_tabBarControllerWillEndCustomizingChangedBlock = block
        return self
    }
    open lazy var axc_tabBarControllerWillEndCustomizingChangedBlock: UITabBarController.AxcViewControllerBoolBlock<Void>
        = { _,_,_ in  }
    public func tabBarController(_ tabBarController: UITabBarController, willEndCustomizing viewControllers: [UIViewController], changed: Bool) -> Void {
         axc_tabBarControllerWillEndCustomizingChangedBlock(tabBarController,viewControllers,changed)
    }
    
    
    /// optional func tabBarController(_ tabBarController: UITabBarController, didEndCustomizing viewControllers: [UIViewController], changed: Bool)
    @discardableResult
    open func axc_setTabBarControllerDidEndCustomizingChangedBlock(_ block: @escaping UITabBarController.AxcViewControllerBoolBlock<Void>) -> Self {
        axc_tabBarControllerDidEndCustomizingChangedBlock = block
        return self
    }
    open lazy var axc_tabBarControllerDidEndCustomizingChangedBlock: UITabBarController.AxcViewControllerBoolBlock<Void>
        = { _,_,_ in  }
    public func tabBarController(_ tabBarController: UITabBarController, didEndCustomizing viewControllers: [UIViewController], changed: Bool) -> Void {
         axc_tabBarControllerDidEndCustomizingChangedBlock(tabBarController,viewControllers,changed)
    }
    
    
    /// optional func tabBarControllerSupportedInterfaceOrientations(_ tabBarController: UITabBarController) -> UIInterfaceOrientationMask
    @discardableResult
    open func axc_setTabBarControllerSupportedInterfaceOrientationsBlock(_ block: @escaping UITabBarController.AxcBlock<UIInterfaceOrientationMask>) -> Self {
        axc_tabBarControllerSupportedInterfaceOrientationsBlock = block
        return self
    }
    open lazy var axc_tabBarControllerSupportedInterfaceOrientationsBlock: UITabBarController.AxcBlock<UIInterfaceOrientationMask>
        = { _ in return UIInterfaceOrientationMask() }
    public func tabBarControllerSupportedInterfaceOrientations(_ tabBarController: UITabBarController) -> UIInterfaceOrientationMask {
        return axc_tabBarControllerSupportedInterfaceOrientationsBlock(tabBarController)
    }
    
    
    /// optional func tabBarControllerPreferredInterfaceOrientationForPresentation(_ tabBarController: UITabBarController) -> UIInterfaceOrientation
    @discardableResult
    open func axc_setTabBarControllerPreferredInterfaceOrientationForPresentationBlock(_ block: @escaping UITabBarController.AxcBlock<UIInterfaceOrientation>) -> Self {
        axc_tabBarControllerPreferredInterfaceOrientationForPresentationBlock = block
        return self
    }
    open lazy var axc_tabBarControllerPreferredInterfaceOrientationForPresentationBlock: UITabBarController.AxcBlock<UIInterfaceOrientation>
        = { _ in return .portrait }
    public func tabBarControllerPreferredInterfaceOrientationForPresentation(_ tabBarController: UITabBarController) -> UIInterfaceOrientation {
        return axc_tabBarControllerPreferredInterfaceOrientationForPresentationBlock(tabBarController)
    }
    
    
    /// optional func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
    @discardableResult
    open func axc_setTabBarControllerInteractionControllerForBlock(_ block: @escaping UITabBarController.AxcViewControllerAnimatedTransitioningBlock<UIViewControllerInteractiveTransitioning?>) -> Self {
        axc_tabBarControllerInteractionControllerForBlock = block
        return self
    }
    open lazy var axc_tabBarControllerInteractionControllerForBlock: UITabBarController.AxcViewControllerAnimatedTransitioningBlock<UIViewControllerInteractiveTransitioning?>
        = { _,_ in return nil }
    public func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return axc_tabBarControllerInteractionControllerForBlock(tabBarController,animationController)
    }
    
    
    /// optional func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    @discardableResult
    open func axc_setTabBarControllerAnimationControllerForTransitionFromToBlock(_ block: @escaping UITabBarController.AxcViewControllerViewControllerBlock<UIViewControllerAnimatedTransitioning?>) -> Self {
        axc_tabBarControllerAnimationControllerForTransitionFromToBlock = block
        return self
    }
    open lazy var axc_tabBarControllerAnimationControllerForTransitionFromToBlock: UITabBarController.AxcViewControllerViewControllerBlock<UIViewControllerAnimatedTransitioning?>
        = { _,_,_ in return nil }
    public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return axc_tabBarControllerAnimationControllerForTransitionFromToBlock(tabBarController,fromVC,toVC)
    }
}
