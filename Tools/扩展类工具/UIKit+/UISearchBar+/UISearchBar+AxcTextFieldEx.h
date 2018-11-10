//
//  UISearchBar+AxcTextFIeldEx.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/10.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "UITextField+AxcPlaceholderLabelEx.h"

NS_ASSUME_NONNULL_BEGIN

@interface UISearchBar (ksystemTextField)

/**
 搜索栏的输入框
 */
@property(nonatomic ,readonly, strong)UITextField *axcSearchTextField;

@end

NS_ASSUME_NONNULL_END
