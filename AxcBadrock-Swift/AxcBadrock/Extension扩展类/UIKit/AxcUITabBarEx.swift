//
//  AxcUITabBarEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

public extension UITabBar {
    /// 设置背景色
    func axc_backgroundColor(_ color: UIColor? = nil) {
        let isColor = color != nil
        backgroundImage = isColor ? UIImage() : nil
        backgroundColor = isColor ? color : nil
    }
    
}

// MARK: - 代理转Block
private var kaxc_tabBarDelegate = "kaxc_tabBarDelegate"
public extension UITabBar {
    /// 返回UITabBar,[UITabBarItem]的Block声明
    typealias AxcItemsBlock<T> = (UITabBar,[UITabBarItem]) -> T
    /// 返回UITabBar,[UITabBarItem],Bool的Block声明
    typealias AxcItemsBoolBlock<T> = (UITabBar,[UITabBarItem],Bool) -> T
    /// 返回UITabBar,UITabBarItem的Block声明
    typealias AxcItemBlock<T> = (UITabBar,UITabBarItem) -> T
    
    /// 代理桥接者
    var axc_tabBarDelegate: AxcTabBarDelegate {
        set { AxcRuntime.setObj(self, &kaxc_tabBarDelegate, newValue)
            self.delegate = newValue
        }
        get {
            guard let delegate: AxcTabBarDelegate  = AxcRuntime.getObj(self, &kaxc_tabBarDelegate)
            else {
                let delegate = AxcTabBarDelegate()
                self.axc_tabBarDelegate = delegate
                self.delegate = delegate
                return delegate
            }
            return delegate
        }
    }
    /// 块设置代理方法
    /// - Parameter block: block
    func axc_makeTabBarDelegate(_ block: (AxcTabBarDelegate) -> Void) {
        block(axc_tabBarDelegate)
    }
}


// MARK: 桥接者
/// 代理转Block桥接者
open class AxcTabBarDelegate: NSObject, UITabBarDelegate {
    ///  called when a new view is selected by the user (but not programatically)
    @discardableResult
    open func axc_setTabBarDidSelectBlock(_ block: @escaping UITabBar.AxcItemBlock<Void>) -> Self {
        axc_tabBarDidSelectBlock = block
        return self
    }
    open lazy var axc_tabBarDidSelectBlock: UITabBar.AxcItemBlock<Void>
        = { _,_ in  }
    public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) -> Void {
         axc_tabBarDidSelectBlock(tabBar,item)
    }
    
    
    ///  called before customize sheet is shown. items is current item list
    @discardableResult
    open func axc_setTabBarWillBeginCustomizingBlock(_ block: @escaping UITabBar.AxcItemsBlock<Void>) -> Self {
        axc_tabBarWillBeginCustomizingBlock = block
        return self
    }
    open lazy var axc_tabBarWillBeginCustomizingBlock: UITabBar.AxcItemsBlock<Void>
        = { _,_ in  }
    public func tabBar(_ tabBar: UITabBar, willBeginCustomizing items: [UITabBarItem]) -> Void {
         axc_tabBarWillBeginCustomizingBlock(tabBar,items)
    }
    
    
    ///  called after customize sheet is shown. items is current item list
    @discardableResult
    open func axc_setTabBarDidBeginCustomizingBlock(_ block: @escaping UITabBar.AxcItemsBlock<Void>) -> Self {
        axc_tabBarDidBeginCustomizingBlock = block
        return self
    }
    open lazy var axc_tabBarDidBeginCustomizingBlock: UITabBar.AxcItemsBlock<Void>
        = { _,_ in  }
    public func tabBar(_ tabBar: UITabBar, didBeginCustomizing items: [UITabBarItem]) -> Void {
         axc_tabBarDidBeginCustomizingBlock(tabBar,items)
    }
    
    
    ///  called before customize sheet is hidden. items is new item list
    @discardableResult
    open func axc_setTabBarWillEndCustomizingChangedBlock(_ block: @escaping UITabBar.AxcItemsBoolBlock<Void>) -> Self {
        axc_tabBarWillEndCustomizingChangedBlock = block
        return self
    }
    open lazy var axc_tabBarWillEndCustomizingChangedBlock: UITabBar.AxcItemsBoolBlock<Void>
        = { _,_,_ in  }
    public func tabBar(_ tabBar: UITabBar, willEndCustomizing items: [UITabBarItem], changed: Bool) -> Void {
         axc_tabBarWillEndCustomizingChangedBlock(tabBar,items,changed)
    }
    
    
    ///  called after customize sheet is hidden. items is new item list
    @discardableResult
    open func axc_setTabBarDidEndCustomizingChangedBlock(_ block: @escaping UITabBar.AxcItemsBoolBlock<Void>) -> Self {
        axc_tabBarDidEndCustomizingChangedBlock = block
        return self
    }
    open lazy var axc_tabBarDidEndCustomizingChangedBlock: UITabBar.AxcItemsBoolBlock<Void>
        = { _,_,_ in  }
    public func tabBar(_ tabBar: UITabBar, didEndCustomizing items: [UITabBarItem], changed: Bool) -> Void {
         axc_tabBarDidEndCustomizingChangedBlock(tabBar,items,changed)
    }
}
