//
//  UIView+AxcGetSuperVC.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/5.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "UIView+AxcGetSuperVC.h"

@implementation UIView (AxcGetSuperVC)

//MARK: 获取当前View所在的ViewController
- (UIViewController *)AxcTool_getSuperVC{
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    return nil;
}

//MARK: 获取当前的根VC
- (UIViewController *)AxcTool_getCurrentRootVC{
    UIViewController *rootViewController = self.window.rootViewController;
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {  // 在主页
        UITabBarController *tabBarVC = (UITabBarController *)rootViewController;
        // 获取当前页面的根导航页
        UIViewController *rootNavVC = [tabBarVC.childViewControllers objectAtIndex:tabBarVC.selectedIndex];
        return rootNavVC;
    }else if([rootViewController isKindOfClass:[UIViewController class]]){ // VC
        return rootViewController;
    }
    return nil;
}

//MARK: 获取当前屏幕显示的VC
- (UIViewController *)AxcTool_getCurrentShowVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

@end
