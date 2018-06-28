//
//  AxcBaseVC+AxcBaseVC_BarButtonItemEx.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/28.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcBaseVC.h"
#import "AxcBasicSuitPrefixHeader.h"    // 可以全局引用的头文件

@interface AxcBaseVC (AxcBaseVC_BarButtonItemEx)

- (UIButton *)AxcBase_createButtonItem:(UIImage *)image
                              OrString:(NSString *)str
                                 State:(UIControlState)state
                                Action:(SEL)action;

@end
