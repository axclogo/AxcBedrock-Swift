//
//  AppDelegate.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/1/30.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        BaiduMobStat.default().setUserProperty(["name": "AxcLogo"]) // 用户信息
//        BaiduMobStat.default().userId = "001"           // 用户id
//        BaiduMobStat.default().shortAppVersion = "1.0.0"    // 版本
//        BaiduMobStat.default().channelId = "AppStore"   // 来源
//        BaiduMobStat.default().enableExceptionLog = true
//        BaiduMobStat.default().logSendWifiOnly = false
//        BaiduMobStat.default().sessionResumeInterval = 30
//        BaiduMobStat.default().enableDebugOn = false
//        BaiduMobStat.default().enableGps = true
//        BaiduMobStat.default().feedTrackStrategy = BaiduMobStatFeedTrackStrategyAll
//
//        BaiduMobStat.default().start(withAppId: "648f65be91")

        AxcBadrock.shared.logLevel = .none
        
        AxcUrlConfig.shared
        
        window?.rootViewController = AxcBadrockTabbar()
        window?.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

