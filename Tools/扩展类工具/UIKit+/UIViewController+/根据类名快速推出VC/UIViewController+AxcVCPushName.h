//
//  UIViewController+AxcVCPushName.h
//  Axc_Practice
//
//  Created by AxcLogo on 2018/10/22.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AxcVCPushName)

/**
 根据类名推出VC
 @param name 类名
 */
- (void)AxcTool_pushVCName:(NSString *)name;
/**
 根据类名推出VC
 @param name 类名
 @param hiddenTabbar 隐藏tabbar
 */
- (void)AxcTool_pushVCName:(NSString *)name hiddenTabbar:(BOOL )hiddenTabbar;
/**
 根据类名推出VC
 @param name 类名
 @param hiddenTabbar 隐藏tabbar
 @param animated 动画
 */
- (void)AxcTool_pushVCName:(NSString *)name hiddenTabbar:(BOOL )hiddenTabbar animated:(BOOL )animated;


/**
 根据类名模态推出VC
 @param name 类名
 */
- (void)AxcTool_pressentVCName:(NSString *)name;
/**
 根据类名模态推出VC
 @param name 类名
 @param animated 动画
 */
- (void)AxcTool_pressentVCName:(NSString *)name animated:(BOOL )animated;


/**
 根据类名获取VC
 @param name 类名
 @return UIViewController
 */
- (UIViewController *)nameGetVC:(NSString *)name;


@end

NS_ASSUME_NONNULL_END
