//
//  UIGestureRecognizer+AxcActionBlockEx.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/6.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AxcBasicSuitBlockDefine.h"

@interface UIGestureRecognizer (AxcActionBlockEx)

/**
 实例化时顺便添加触发事件Block
 */
- (instancetype)initWithActionBlock:(AxcBasicSuitSenderBlock )block;

/**
 添加一个触发事件
 */
- (void)AxcTool_addActionBlock:(AxcBasicSuitSenderBlock )block;

/**
 移除
 */
- (void)AxcTool_removeAllActionBlocks;

@end
