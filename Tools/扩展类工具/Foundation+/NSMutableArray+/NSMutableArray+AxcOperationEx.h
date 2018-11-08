//
//  NSMutableArray+AxcOperationEx.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/6.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (AxcOperationEx)


/**
 移除第一个对象 (如果Array空，则无效果)
 */
- (void)AxcTool_removeFirstObject;


/**
 移除最后一个对象 (如果Array空，则无效果)
 */
- (void)AxcTool_removeLastObject;


/**
 移除第一个对象并返回 (如果Array空，则无效果)
 @return 对象
 */
- (id)AxcTool_popFirstObject;


/**
 移除最后一个对象并返回 (如果Array空，则无效果)
 @return 对象
 */
- (id)AxcTool_popLastObject;


/**
 反转对象顺序，例如 @[ @1, @2, @3 ] -> @[ @3, @2, @1 ].
 */
- (void)AxcTool_reverse;

@end
