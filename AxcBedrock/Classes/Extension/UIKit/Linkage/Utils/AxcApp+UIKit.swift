//
//  AxcApp+UIKit.swift
//  Pods-AxcBedrock_Example
//
//  Created by 赵新 on 2023/2/14.
//

#if canImport(UIKit)

import UIKit

fileprivate extension AxcBedrockLib.LazyCache.Table {
    static var uikitAppTable: AxcLazyCache.Table = .init("uikitAppTable", enableCache: true)
}

// MARK: - VC获取相关

public extension AxcApp {
    /// 屏幕大小
    /// app扩展包中无法使用
    @available(iOSApplicationExtension, unavailable)
    static var ScreenSize: CGSize {
        if #available(iOS 13.0, *) {
            return KeyWindow?.windowScene?.screen.bounds.size ?? .zero
        } else {
            return UIScreen.main.bounds.size
        }
    }

    /// 获取当前keyWindow
    /// app扩展包中无法使用
    @available(iOSApplicationExtension, unavailable)
    static var KeyWindow: UIWindow? {
        // 读缓存window
        var window: UIWindow?
        if #available(iOS 13.0, *) { // 13以上
            for windowScene: UIWindowScene in ((UIApplication.shared.connectedScenes as? Set<UIWindowScene>)!) {
                if window == nil {
                    window = _ForEachCurrentWindow(windowScene.windows)
                    if window != nil {
                        break
                    }
                }
            }
        } else { // 13以下
            window = UIApplication.shared.keyWindow
            if window?.windowLevel != .normal {
                window = _ForEachCurrentWindow(UIApplication.shared.windows)
            }
        }
        if let window {
            return window
        } else {
            return UIApplication.shared.keyWindow
        }
    }

    /// 遍历获取合适的window
    /// app扩展包中无法使用
    @available(iOSApplicationExtension, unavailable)
    static func _ForEachCurrentWindow(_ windows: [UIWindow]) -> UIWindow? {
        var window: UIWindow?
        windows.forEach {
            if $0.windowLevel == .normal,
               $0.isKeyWindow {
                window = $0
                return
            }
        }
        return window
    }

    /// 获取当前rootVC
    /// app扩展包中无法使用
    @available(iOSApplicationExtension, unavailable)
    static var RootVC: UIViewController? {
        return KeyWindow?.rootViewController
    }

    /// 获取当前显示的VC
    /// app扩展包中无法使用
    /// - Parameter filterClassName: 过滤的类名组
    /// - Returns: 当前显示的VC
    @available(iOSApplicationExtension, unavailable)
    static func CurrentVC(filterClassNames: [String]? = nil) -> UIViewController? {
        var vcHierarchy: [UIViewController?] = []
        // 私有递归查找最顶级视图
        func topMost(of vc: UIViewController?) -> UIViewController? {
            vcHierarchy.append(vc)
            if let presentedVC = vc?.presentedViewController {
                return topMost(of: presentedVC) // presented的VC
            }
            if let tabBarVC = vc as? UITabBarController,
               let selectedVC = tabBarVC.selectedViewController {
                return topMost(of: selectedVC) // UITabBarController
            }
            if let navigationVC = vc as? UINavigationController,
               let visibleVC = navigationVC.visibleViewController {
                return topMost(of: visibleVC) // UINavigationController
            }
            if let pageVC = vc as? UIPageViewController,
               pageVC.viewControllers?.count == 1 {
                return topMost(of: pageVC.viewControllers?.first) // UIPageController
            }
            for subview in vc?.view?.subviews ?? [] {
                if let childVC = subview.next as? UIViewController {
                    return topMost(of: childVC) // 子VC
                }
            }
            return vc
        }
        guard let defaultTopMost = topMost(of: RootVC) else {
            return nil // 没有找到最上级
        }
        guard let filterClassNames else {
            return defaultTopMost // 没有设置过滤选项
        }
        // 检查过滤项
        let defaultTopMostClassName = defaultTopMost.axc.className
        guard filterClassNames.contains(defaultTopMostClassName) else {
            return defaultTopMost
        }
        // 包含倒序遍历
        var resultVC: UIViewController?
        for vc in vcHierarchy.reversed() { // 倒序找到一个合理的控制器
            if let vc, !filterClassNames.contains(vc.axc.className) { // 不包含
                resultVC = vc
                break // 找到直接停止
            }
        }
        return resultVC
    }

    /// 获取当前显示的VC
    /// app扩展包中无法使用
    @available(iOSApplicationExtension, unavailable)
    static var CurrentVC: UIViewController? {
        return CurrentVC()
    }
}

#endif
