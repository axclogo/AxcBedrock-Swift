//
//  NSMutableArray+AxcOperationEx.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/6.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "NSMutableArray+AxcOperationEx.h"

#import "AxcBasicSuitDefine.h"

@implementation NSMutableArray (AxcOperationEx)

/**
 移除第一个对象 (如果Array空，则无效果)
 */
- (void)AxcTool_removeFirstObject{
    if (self.count) {
        [self removeObjectAtIndex:0];
    }else{
        AxcErrorObjLog(@"数组操作错误！发生越界");
    }
}


/**
 移除最后一个对象 (如果Array空，则无效果)
 */
- (void)AxcTool_removeLastObject{
    if (self.count) {
        [self removeLastObject];
    }else{
        AxcErrorObjLog(@"数组操作错误！发生越界");
    }
}


/**
 移除第一个对象并返回 (如果Array空，则无效果)
 @return 对象
 */
- (id)AxcTool_popFirstObject{
    id obj = nil;
    if (self.count) {
        obj = self.firstObject;
        [self AxcTool_removeFirstObject];
    }else{
        AxcErrorObjLog(@"数组操作错误！发生越界");
    }
    return obj;
}


/**
 移除最后一个对象并返回 (如果Array空，则无效果)
 @return 对象
 */
- (id)AxcTool_popLastObject{
    id obj = nil;
    if (self.count) {
        obj = self.lastObject;
        [self removeLastObject];
    }else{
        AxcErrorObjLog(@"数组操作错误！发生越界");
    }
    return obj;
}

/**
 反转对象顺序，例如 @[ @1, @2, @3 ] -> @[ @3, @2, @1 ].
 */
- (void)AxcTool_reverse{
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}



@end
