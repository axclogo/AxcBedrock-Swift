//
//  AxcConstFile.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit


// MARK: - 系统单例
/// UIDevice
public let Axc_device               = UIDevice.current
/// Bundle
public let Axc_bundle               = Bundle.main
/// infoDictionary
public let Axc_infoDictionary       = Axc_bundle.infoDictionary
/// FileManager
public let Axc_fileManager          = FileManager.default
/// UserDefaults
public let Axc_userDefaults         = UserDefaults.standard
/// NotificationCenter
public let Axc_notificationCenter   = NotificationCenter.default
/// Application
public let Axc_application          = UIApplication.shared
/// AppDelegate
public let Axc_appDelegate          = Axc_application.delegate
/// UIScreen
public let Axc_screen               = UIScreen.main
/// 框架本身的Bundle
public let Axc_BadrockBundle        = AxcBadrockBundle.shared


// MARK: - 常用常量
// MARK: UI尺寸数据
/// CGFloat支持的最小正数值
public let Axc_floatMin = CGFloat.axc_min
/// CGFloat支持的最大值
public let Axc_floatMax = CGFloat.axc_max
/// CGFloat支持的无限值
public let Axc_floatInfinity = CGFloat.axc_infinity


/// 一个最大字节位数
public let Axc_ByteMax = 256

/// tag标记的起始数值
public let Axc_TagStar = 5324


/// 屏大小
public let Axc_screenSize = Axc_screen.bounds.size
/// 屏宽
public let Axc_screenWidth = Axc_screenSize.width
/// 屏高
public let Axc_screenHeight = Axc_screenSize.height
/// 状态栏高度
public var Axc_statusHeight: CGFloat {
    if #available(iOS 13.0, *) { return Axc_application.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0 }
    else { return Axc_application.statusBarFrame.size.height }
}
/// 导航条高度
public var Axc_navBarHeight: CGFloat {
    return 44
}
///底部安全距离
private var Axc_GetTabbarSafeBottomMargin: CGFloat {
    var safeBottom:CGFloat = 0
    if #available(iOS 11, *) {
        let safeArea = UIApplication.shared.keyWindow?.safeAreaInsets
        safeBottom = safeArea?.bottom ?? 0
    }
    return safeBottom
}

//状态栏和导航栏总高度
public let Axc_NavBarAndStatusBarHeight:CGFloat = Axc_navBarHeight + Axc_statusHeight

///底部安全距离
public let Axc_TabbarSafeBottomMargin:CGFloat = Axc_GetTabbarSafeBottomMargin
///TbaBar高度
public let Axc_TabBarHeight:CGFloat = 49 +  Axc_TabbarSafeBottomMargin

/// 一般工具栏视图高度，以导航条高度为准
public let Axc_toolBarHeight = Axc_navBarHeight
/// 默认navigationItem大小
public let Axc_navigationItemSize = CGSize((40,25))

// MARK: 判断
/// 判断是否是刘海屏设备
public var Axc_isLargeScreenIPhone: Bool {
    if #available(iOS 13.0, *) { return AxcAppWindow()?.safeAreaInsets != UIEdgeInsets.zero }
    return false
}


// MARK: 动画常量
/// 默认动画执行时间
public let Axc_duration = 0.4


// MARK: 普通常量
public let Axc_true: String     = "true"
public let Axc_false: String    = "false"
public let Axc_placeholderUrl   = "AxcLogo.club"


// MARK: 系统常量
/// 当前系统语言
public let Axc_systemLanguage   = NSLocale.preferredLanguages.first!
/// 当前系统版本
public let Axc_systemVersion    = UIDevice.current.systemVersion
/// 当前app版本
public let Axc_appVersion       = Axc_infoDictionary!["CFBundleShortVersionString"]! as! String
/// 当前项目名称
public let Axc_projectName      = Axc_infoDictionary!["CFBundleExecutable"]! as! String
/// 当前项目Bundle Identifier
public let Axc_bundleIdentifier = Axc_infoDictionary!["CFBundleIdentifier"]! as! String

// MARK: 文件路径常量
/// Documents路径
public let Axc_documentsPath    =  NSHomeDirectory().appending(AxcSandboxDir.documents.rawValue)
/// Library路径
public let Axc_libraryPath      =  NSHomeDirectory().appending(AxcSandboxDir.library.rawValue)
/// Caches路径
public let Axc_cachesPath       =  NSHomeDirectory().appending(AxcSandboxDir.Library.caches.rawValue)
/// Preferences路径
public let Axc_preferencesPath  =  NSHomeDirectory().appending(AxcSandboxDir.Library.preferences.rawValue)
/// Tmp路径
public let Axc_tmpPath          =  NSHomeDirectory().appending(AxcSandboxDir.tmp.rawValue)


