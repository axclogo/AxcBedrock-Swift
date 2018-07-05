//
//  UIView+AxcViewAppearanceEx.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/29.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AxcViewAppearanceEx)

/**
 快速设置圆角
 @param cornerRadius  圆角值
 */
- (void)AxcTool_cornerWithRadius:(CGFloat )cornerRadius;

/**
 快速设置边框
 @param borderWidth 边框线宽
 @param borderColor 边框颜色
 */
- (void)AxcTool_borderWithWidth:(CGFloat )borderWidth
                          color:(UIColor *)borderColor;

/**
 快速设置阴影
 @param shadowColor 阴影颜色
 @param shadowOffset 阴影偏移方向
 @param shadowOpacity 阴影透明度
 @param shadowRadius 阴影圆角
 */
- (void)AxcTool_shadowWithColor:(UIColor *)shadowColor
                   shadowOffset:(CGSize )shadowOffset
                  shadowOpacity:(CGFloat )shadowOpacity
                   shadowRadius:(CGFloat )shadowRadius;

@end
