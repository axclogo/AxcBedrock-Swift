//
//  AxcUINavigationBarEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/21.
//

import UIKit

// MARK: - 属性 & Api
public extension UINavigationBar {
    /// 设置导航栏的标题，标题颜色和字体
    /// - Parameters:
    ///   - font: 字体
    ///   - color: 标题颜色
    
    /// 设置导航栏字色
    /// - Parameter color: 颜色
    func axc_setTitleColor(_ color: UIColor) {
        var att: [NSAttributedString.Key : Any] = [:]
        if let _att = titleTextAttributes { att = _att }
        att[.foregroundColor] = color
        titleTextAttributes = att
    }
    /// 设置导航栏字体
    /// - Parameter font: 字体
    func axc_setTitleFont(_ font: UIFont) {
        var att: [NSAttributedString.Key : Any] = [:]
        if let _att = titleTextAttributes { att = _att }
        att[.font] = font
        titleTextAttributes = att
    }
    /// 让导航栏改变颜色 默认白色
    func axc_setColor(_ tintColor: UIColor = .white) {
        backgroundColor = tintColor
        barTintColor = tintColor
        setBackgroundImage(UIImage(), for: .default)
        self.tintColor = tintColor
        shadowImage = UIImage()
    }
}


// MARK: - 代理转Block
private var kaxc_navigationBarDelegate = "kaxc_navigationBarDelegate"
public extension UINavigationBar {
    /// 返回UINavigationBar,UINavigationItem的Block声明
    typealias AxcNavigationItemBlock<T> = (UINavigationBar,UINavigationItem) -> T
    
    /// 代理桥接者
    var axc_navigationBarDelegate: AxcNavigationBarDelegate {
        set { AxcRuntime.setObj(self, &kaxc_navigationBarDelegate, newValue)
            self.delegate = newValue
        }
        get {
            guard let delegate: AxcNavigationBarDelegate  = AxcRuntime.getObj(self, &kaxc_navigationBarDelegate)
            else {
                let delegate = AxcNavigationBarDelegate()
                self.axc_navigationBarDelegate = delegate
                self.delegate = delegate
                return delegate
            }
            return delegate
        }
    }
    /// 块设置代理方法
    /// - Parameter block: block
    func axc_makeNavigationBarDelegate(_ block: (AxcNavigationBarDelegate) -> Void) {
        block(axc_navigationBarDelegate)
    }
}

// MARK: 桥接者
/// 代理转Block桥接者
open class AxcNavigationBarDelegate: NSObject, UINavigationBarDelegate {
    ///  called to push. return NO not to.
    @discardableResult
    open func axc_setNavigationBarShouldPushBlock(_ block: @escaping UINavigationBar.AxcNavigationItemBlock<Bool>) -> Self {
        axc_navigationBarShouldPushBlock = block
        return self
    }
    open lazy var axc_navigationBarShouldPushBlock: UINavigationBar.AxcNavigationItemBlock<Bool>
        = { _,_ in return true }
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        return axc_navigationBarShouldPushBlock(navigationBar,item)
    }
    
    
    ///  called at end of animation of push or immediately if not animated
    @discardableResult
    open func axc_setNavigationBarDidPushBlock(_ block: @escaping UINavigationBar.AxcNavigationItemBlock<Void>) -> Self {
        axc_navigationBarDidPushBlock = block
        return self
    }
    open lazy var axc_navigationBarDidPushBlock: UINavigationBar.AxcNavigationItemBlock<Void>
        = { _,_ in  }
    public func navigationBar(_ navigationBar: UINavigationBar, didPush item: UINavigationItem) -> Void {
         axc_navigationBarDidPushBlock(navigationBar,item)
    }
    
    
    ///  same as push methods
    @discardableResult
    open func axc_setNavigationBarShouldPopBlock(_ block: @escaping UINavigationBar.AxcNavigationItemBlock<Bool>) -> Self {
        axc_navigationBarShouldPopBlock = block
        return self
    }
    open lazy var axc_navigationBarShouldPopBlock: UINavigationBar.AxcNavigationItemBlock<Bool>
        = { _,_ in return true }
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        return axc_navigationBarShouldPopBlock(navigationBar,item)
    }
    
    
    /// optional func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem)
    @discardableResult
    open func axc_setNavigationBarDidPopBlock(_ block: @escaping UINavigationBar.AxcNavigationItemBlock<Void>) -> Self {
        axc_navigationBarDidPopBlock = block
        return self
    }
    open lazy var axc_navigationBarDidPopBlock: UINavigationBar.AxcNavigationItemBlock<Void>
        = { _,_ in  }
    public func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem) -> Void {
         axc_navigationBarDidPopBlock(navigationBar,item)
    }
}
