//
//  UIView+AxcScreenshotsViewEx.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/6.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "UIView+AxcScreenshotsViewEx.h"

@implementation UIView (AxcScreenshotsViewEx)

/**
 *  1.获取屏幕图片
 */
- (UIImage *)AxcTool_screenshots{
    return [self AxcTool_screenshotsWithFrame:self.frame];
}


/**
 截图在哪个坐标区间
 @param frame 坐标区间
 @return 截图图片
 */
- (UIImage *)AxcTool_screenshotsWithFrame:(CGRect)frame{
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(frame);
    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  theImage;
}

@end
