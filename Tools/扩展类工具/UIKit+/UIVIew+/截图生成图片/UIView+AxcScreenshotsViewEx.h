//
//  UIView+AxcScreenshotsViewEx.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/6.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AxcScreenshotsViewEx)

/**
 截图获取View生成图片
 */
- (UIImage *)AxcTool_screenshots;


/**
 截图在哪个坐标区间
 @param frame 坐标区间
 @return 截图图片
 */
- (UIImage *)AxcTool_screenshotsWithFrame:(CGRect)frame;


@end
