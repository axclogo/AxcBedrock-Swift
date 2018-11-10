//
//  UISearchBar+AxcTextFIeldEx.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/10.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "UISearchBar+AxcTextFieldEx.h"
#import <objc/runtime.h>

static NSString * const ksystemTextField = @"_placeholderLabel";

@implementation UISearchBar (ksystemTextField)

- (UITextField *)axcSearchTextField{
    __block UITextField *searchBarTextField = nil;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj_1, NSUInteger idx_1, BOOL * _Nonnull stop_1) {
            if ([obj_1 isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                searchBarTextField = obj_1;
                *stop = *stop_1 = YES;
            }
        }];
    }];
    return searchBarTextField;
}




@end
