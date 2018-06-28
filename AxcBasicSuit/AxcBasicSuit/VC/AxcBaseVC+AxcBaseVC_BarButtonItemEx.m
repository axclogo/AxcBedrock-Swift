//
//  AxcBaseVC+AxcBaseVC_BarButtonItemEx.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/28.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcBaseVC+AxcBaseVC_BarButtonItemEx.h"

@implementation AxcBaseVC (AxcBaseVC_BarButtonItemEx)

- (UIButton *)AxcBase_createButtonWithImage:(UIImage *)image
                                      title:(NSString *)title
                                       font:(UIFont *)font
                                     action:(SEL )action{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    CGFloat width = [title AxcTool_getWidthFont:font maxHeight:self.axcNavBarHeight];
    button.axcTool_width = width;
    [button setTitleColor:self.themeColor forState:UIControlStateNormal];
    if (image) { [button setImage:image forState:UIControlStateNormal];}
    if (title) { [button setTitle:title forState:UIControlStateNormal];}
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
