//
//  UIView+AxcViewAppearanceEx.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/29.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "UIView+AxcViewAppearanceEx.h"

/*
 clipsToBounds(UIView)
 是指视图上的子视图,如果超出父视图的部分就截取掉,
 masksToBounds(CALayer)
 却是指视图的图层上的子图层,如果超出父图层的部分就截取掉
 clipsToBounds执行的时候,调用了自己涂层的maskToBounds方法
 */

@implementation UIView (AxcViewAppearanceEx)

/**
 快速设置圆角
 @param cornerRadius  圆角值
 */
- (void)AxcTool_cornerWithRadius:(CGFloat )cornerRadius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

/**
 快速设置边框
 @param borderWidth 边框线宽
 @param borderColor 边框颜色
 */
- (void)AxcTool_borderWithWidth:(CGFloat )borderWidth
                          color:(UIColor *)borderColor{
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}

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
                   shadowRadius:(CGFloat )shadowRadius{
    self.clipsToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
}

@end
