//
//  AxcNSObjectEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import UIKit

// MARK: - 类方法/属性
public extension NSObject {
    /// 获取本类的类名
    static var axc_className: String {
        return AxcClassFromString(self)
    }
    /// 获取 UIApplication
    static var axc_sharedApplication: UIApplication? {
        let selector = "sharedApplication".axc_selector
        guard let application = UIApplication.perform(selector)?.takeUnretainedValue() as? UIApplication
        else { return nil }
        return application
    }
    /// 获取最顶层的当前VC
    static var axc_currentVC: UIViewController? {
        guard let currentWindows = axc_sharedApplication?.windows else { return nil }
        var rootViewController: UIViewController?
        for window in currentWindows {
            if let windowRootViewController = window.rootViewController, window.isKeyWindow {
                rootViewController = windowRootViewController
                break
            }
        }
        return axc_topMost(of: rootViewController)
    }
    
    /// 私有递归查找最顶级视图
    private static func axc_topMost(of viewController: UIViewController?) -> UIViewController? {
        if let presentedViewController = viewController?.presentedViewController {
            return axc_topMost(of: presentedViewController)// presented的VC
        }
        if let tabBarController = viewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return axc_topMost(of: selectedViewController) // UITabBarController
        }
        if let navigationController = viewController as? UINavigationController,
           let visibleViewController = navigationController.visibleViewController {
            return axc_topMost(of: visibleViewController) // UINavigationController
        }
        if let pageViewController = viewController as? UIPageViewController,
           pageViewController.viewControllers?.count == 1 { // UIPageController
            return axc_topMost(of: pageViewController.viewControllers?.first)
        }
        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                return axc_topMost(of: childViewController) // 子VC
            }
        }
        return viewController
    }
}

// MARK: - 属性 & Api
public extension NSObject {
    /// 获取本类的类名
    var axc_className: String {
        return Self.axc_className
    }
    /// 获取 UIApplication
    var axc_sharedApplication: UIApplication? {
        return Self.axc_sharedApplication
    }
    /// 获取最顶层的当前VC
    var axc_currentVC: UIViewController? {
        return Self.axc_currentVC
    }
    
    /// UserDefaults
    var axc_userDefaults: UserDefaults {
        return Axc_userDefaults
    }
    
    /// 拷贝加类型软解包
    func axc_copy() -> Self? {
        guard let copy = self.copy() as? Self else { return nil }
        return copy
    }
    
    /// 方法交换
    /// - Parameters:
    ///   - originalSel: 原方法
    ///   - newSel: 新方法
    func axc_methodInvoked(_ originalSel: Selector, newSel: Selector) {
        let identifier = "\(self.axc_className)_\(originalSel.description)_\(newSel.description)"
        AxcGCD.once(identifier) {
            AxcRuntime.methodSwizzle(_class: Self.self, originalSelector: originalSel, swizzledSelector: newSel)
        }
    }
    
    /// 弱引用代码块
    /// - Parameter block: 代码块
    func axc_makeCodeBlock(_ block: () -> Void) {
        block()
    }
}

// MARK: - 观察者模式
private var kaxc_observer = "kaxc_observer"
private var kaxc_observerCycle = "kaxc_observerCycle"
public extension NSObject {
    /// 观察桥接者
    var axc_observer: AxcObserver {
        set { AxcRuntime.setObj(self, &kaxc_observer, newValue) }
        get {
            guard let observer: AxcObserver = AxcRuntime.getObj(self, &kaxc_observer)
            else {
                let ob = AxcObserver(ob: self)
                self.axc_observer = ob
                return ob
            }
            return observer
        }
    }
    /// 观察者生命周期管理
    var axc_observerCycle: AxcObserveCycle {
        set { AxcRuntime.setObj(self, &kaxc_observerCycle, newValue) }
        get {
            guard let cycle: AxcObserveCycle  = AxcRuntime.getObj(self, &kaxc_observerCycle)
            else {
                let cycle = AxcObserveCycle()
                self.axc_observerCycle = cycle
                return cycle
            }
            return cycle
        }
    }
    
    /// 添加一组观察键值对
    func axc_addObservers(_ keyPaths: [String] ) {
        keyPaths.forEach{ axc_addObserver($0) }
    }
    /// 添加自动释放观察者
    func axc_addObserver(_ keyPath: String,
                         observer: NSObject? = nil,
                         options: NSKeyValueObservingOptions = [.new],
                         context: UnsafeMutableRawPointer? = nil) {
        let obs = observer ?? self
        addObserver(obs, forKeyPath: keyPath, options: options, context: context)
    }
    
    /// 移除一组观察者
    func axc_removeObservers(_ keyPaths: [String] ) {
        keyPaths.forEach{ axc_removeObserver($0) }
    }
    /// 移除观察者
    func axc_removeObserver(_ keyPath: String,
                            observer: NSObject? = nil,
                            context: UnsafeMutableRawPointer? = nil) {
        let obs = observer ?? self
        removeObserver(obs, forKeyPath: keyPath, context: context)
    }
}
/// 第三观察者
public extension AxcObserver.Key {
    static var frame        = AxcObserver.Key("frame")
    static var subviews     = AxcObserver.Key("subviews")
    static var sublayers    = AxcObserver.Key("sublayers")
    static var bounds       = AxcObserver.Key("bounds")
    static var text         = AxcObserver.Key("text")
}
/// 自适应状态类型
public enum AxcAutoAdaptType {
    /// 不使用周期管理，不进行监听适配
    case none
    /// 自动选择一个周期管理（如果传空则设置生命周期与当前VC进行绑定）
    case auto(cycle: AxcObserveCycle? = nil)
}
open class AxcObserver: NSObject {
    public weak var ob: NSObject? // 弱引用
    init(ob: NSObject) {
        self.ob = ob
        super.init()
    }
    public typealias AxcObserverCallBackBlock = (String?,Any?,[NSKeyValueChangeKey : Any]?,UnsafeMutableRawPointer?) -> Void
    public typealias KeyPathsType = [[String: AxcObserverCallBackBlock]]
    private var keyPaths: KeyPathsType = [[:]]
    /// 键值Key
    public struct Key: Hashable, Equatable, RawRepresentable {
        public var rawValue: String
        public init(rawValue: String) { self.rawValue = rawValue }
        internal init(_ rawValue: String) { self.init(rawValue: rawValue) }
    }
    
    /// 添加一个键值观察，预设键值
    /// - Parameters:
    ///   - keyPath: 预设键值
    ///   - firstTrigger: 首次触发
    ///   - options: options
    ///   - context: context
    ///   - block: block
    /// - Returns: AxcObserver
    open func axc_setKeyPath(_ keyPath: AxcObserver.Key,
                              firstTrigger: Bool = false,
                              options: NSKeyValueObservingOptions = [.new],
                              context: UnsafeMutableRawPointer? = nil,
                              actionBlock: @escaping AxcObserverCallBackBlock) -> AxcObserver {
        axc_setKeyPath(keyPath.rawValue, firstTrigger: firstTrigger, options: options, context: context, actionBlock: actionBlock)
    }
    /// 添加一个键值观察，字符串模式
    /// - Parameters:
    ///   - keyPath: 键值
    ///   - firstTrigger: 首次触发
    ///   - options: options
    ///   - context: context
    ///   - block: block
    /// - Returns: AxcObserver
    open func axc_setKeyPath(_ keyPath: String,
                              firstTrigger: Bool = false,
                              options: NSKeyValueObservingOptions = [.new],
                              context: UnsafeMutableRawPointer? = nil,
                              actionBlock: @escaping AxcObserverCallBackBlock) -> AxcObserver {
        guard let observer = ob else { return self }
        keyPaths.append([keyPath: actionBlock])
        observer.axc_addObserver(keyPath, observer: self, options: options, context: context)
        if firstTrigger { observeValue(forKeyPath: keyPath, of: self, change: nil, context: context) }
        return self
    }
    
    /// 移除一个键值观察
    /// - Parameter keyPath: 预设键值
    open func axc_removeKeyPath(_ keyPath: AxcObserver.Key){
        axc_removeObserver(keyPath.rawValue)
    }
    /// 移除一个键值观察
    /// - Parameter keyPath: 字符串键值
    open func axc_removeKeyPath(_ keyPath: String){
        guard let observer = ob else { return }
        observer.axc_removeObserver(keyPath, observer: self)
        AxcLog("KVO释放！\nTarget:\(observer)\nObserver:\(self)\nKeyPath:\(keyPath)", level: .trace)
    }
    /// 移除所有键值观察
    open func axc_removeAllKeyPath() {
        keyPaths.forEach{   // 遍历所有监听
            $0.forEach { (dic) in   // 挑出键值进行移除
                axc_removeKeyPath(dic.key)
            }
        }
    }
    /// 找出所有包含这个键值的监听Block
    open func axc_containsKey(_ keyPath: String) -> KeyPathsType {
        var keysArr: KeyPathsType = []
        keyPaths.forEach{
            if $0.axc_isHasKey(keyPath){
                keysArr.append($0)
            }
        }
        return keysArr
    }
    
    /// 设置生命周期
    /// - Parameter cycle: 生命周期AxcObserveCycle
    open func axc_setCycle(_ cycle: AxcObserveCycle) {
        cycle.ob = self
    }
    
    /// 触发监听
    open override func observeValue(forKeyPath keyPath: String?,
                                    of object: Any?,
                                    change: [NSKeyValueChangeKey : Any]?,
                                    context: UnsafeMutableRawPointer?) {
        guard let key = keyPath else { return } // 取出runtime作为键值的指针
        let keysArr = axc_containsKey(key)
        keysArr.forEach{    // 遍历所有监听
            if $0.axc_isHasKey(key), let block = $0[key] {
                block(keyPath, object, change, context) // 回调指针指向的Block函数块
            }
        }
    }
}
/// 观察者周期管理
open class AxcObserveCycle: NSObject {
    public var ob: AxcObserver? = nil
    deinit { // 移除所有观察
        if let _ = ob?.ob { // 高频决策优化
            ob?.axc_removeAllKeyPath()
        }
    }
}

// MARK: - 通知中心
private var kaxc_notificationCycle = "kaxc_notificationCycle"
public extension NSObject {
    /// 通知中心NotificationCenter桥接者
    var axc_notificationCenter: NotificationCenter {
        return Axc_notificationCenter
    }
    
    /// 通知中心生命周期管理
    var axc_notificationCycle: AxcNotificationCycle {
        set { AxcRuntime.setObj(self, &kaxc_notificationCycle, newValue) }
        get {
            guard let cycle: AxcNotificationCycle  = AxcRuntime.getObj(self, &kaxc_notificationCycle)
            else {
                let cycle = AxcNotificationCycle()
                self.axc_notificationCycle = cycle
                return cycle
            }
            return cycle
        }
    }
}

// MARK: - 扩展属性
private var kaxc_any = "kaxc_any"
private var kaxc_indexPath = "kaxc_indexPath"
extension NSObject: AxcTagsProtocol { // 支持Tag协议
    /// 可以临时存储任何类型，但不建议使用，可以仅作为临时调试
    public var axc_any: Any? {
        set { AxcRuntime.setObj(self, &kaxc_any, newValue) }
        get {
            guard let any: Any = AxcRuntime.getObj(self, &kaxc_any) else { return nil }
            return any
        }
    }
    /// 用于存储索引的变量
    public var axc_indexPath: IndexPath? {
        set { AxcRuntime.setObj(self, &kaxc_indexPath, newValue) }
        get {
            guard let indexPath: IndexPath = AxcRuntime.getObj(self, &kaxc_indexPath)
            else { return nil }
            return indexPath
        }
    }
}

// MARK: - 决策判断
public extension NSObject {
}
