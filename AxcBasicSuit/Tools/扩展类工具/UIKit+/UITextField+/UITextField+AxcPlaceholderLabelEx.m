//
//  UITextField+AxcPlaceholderLabelEx.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/5.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "UITextField+AxcPlaceholderLabelEx.h"
#import <objc/runtime.h>
#import "AxcBasicSuitDefine.h"

static NSString * const ksystemPlaceholderLabel = @"_placeholderLabel";


@implementation UITextField (AxcPlaceholderLabelEx)

-(void)setAxcPlaceholderLabel:(UILabel *)axcPlaceholderLabel{
    [self willChangeValueForKey:ksystemPlaceholderLabel];
    objc_setAssociatedObject(self, &ksystemPlaceholderLabel,
                             axcPlaceholderLabel,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:ksystemPlaceholderLabel];
}


- (UILabel *)axcPlaceholderLabel{
    UILabel *label = (UILabel *)[self valueForKeyPath:ksystemPlaceholderLabel];
    if (!label) AxcErrorObjLog(@"未能获取system - placeholderLabel\n请检查是否已设置系统占位Label并且已实例化");
    return label;
}

@end
