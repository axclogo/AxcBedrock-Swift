//
//  UIView+AxcGetSuperVC.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/5.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AxcGetSuperVC)


/** 获取当前View所在的ViewController */
- (UIViewController *)AxcTool_getSuperVC;

/** 获取当前的根VC */
 - (UIViewController *)AxcTool_getCurrentRootVC;

/** 获取当前屏幕显示的VC */
 - (UIViewController *)AxcTool_getCurrentShowVC;


@end
