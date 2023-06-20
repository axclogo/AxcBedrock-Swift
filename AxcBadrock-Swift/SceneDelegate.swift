//
//  SceneDelegate.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/1/30.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        configNetWorkMoudle()
        window?.rootViewController = AxcBadrockTabbar()
        window?.makeKeyAndVisible()
        
        if #available(iOS 13.0, *) {
            guard let _ = (scene as? UIWindowScene) else { return }
        } else {
            // Fallback on earlier versions
        }
    }

    /// 配置网络模块
    func configNetWorkMoudle() {
        let module =
            AxcUrlConfigModule("主模块", identifier: "Main", environment: [
                AxcEnvironmentType(environmentKey: "release",
                                   standbyUrls: [(title: "主正式站", url: "https://certapi.54xiaoshuo.com"),
                                                 (title: "主正式站备用1", url: "https://certapi.54xiaoshuo.com"),
                                                 (title: "主正式站备用2", url: "https://certapi.54xiaoshuo.com"),
                                                 (title: "主正式站备用3", url: "https://certapi.54xiaoshuo.com"),
                                                 (title: "主正式站备用4", url: "https://certapi.54xiaoshuo.com")
                                   ]),
                AxcEnvironmentType(environmentKey: "prepare",
                                   standbyUrls: [(title: "主预发布站", url: "http://app.kkbbi.com")
                                   ]),
                AxcEnvironmentType(environmentKey: "test",
                                   standbyUrls: [(title: "主测试站", url: "http://app.zhaogong.vrtbbs.com"),
                                                 (title: "测试站重构", url: "http://refactor.zhaogong.vrtbbs.com")
                                   ])
            ])
        AxcUrlConfig.shared.axc_addModule( module )
        
        let workAccountModule =
            AxcUrlConfigModule("记工记账模块", identifier: "WorkAccount", environment: [
                AxcEnvironmentType(environmentKey: "release",
                                   standbyUrls: [(title: "正式站", url: "https://app.cdmgkj.cn")]),
                
                AxcEnvironmentType(environmentKey: "prepare",
                                   standbyUrls: [(title: "预发布站", url: "http://book.release.kkbbi.com")]),
                
                AxcEnvironmentType(environmentKey: "test",
                                   standbyUrls: [(title: "测试站", url: "http://appjg.superinyang.com"),
                                                 (title: "测试站重构", url: "http://appjg.superinyang.com")])
            ])
        AxcUrlConfig.shared.axc_addModule( workAccountModule )
        
        let webModule =
            AxcUrlConfigModule("网站模块", identifier: "Web", environment: [
                AxcEnvironmentType(environmentKey: "release",
                                   standbyUrls: [(title: "网站正式站", url: "www.releaseweb.com")]),
                
                AxcEnvironmentType(environmentKey: "prepare",
                                   standbyUrls: [(title: "网站预发布站", url: "www.prepareweb.com")]),
                
                AxcEnvironmentType(environmentKey: "test",
                                   standbyUrls: [(title: "网站测试站", url: "www.testweb.com")])
            ])
        AxcUrlConfig.shared.axc_addModule( webModule )
        AxcUrlConfig.shared.axc_loadAllModule() // 加载
    }
    
    
    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

