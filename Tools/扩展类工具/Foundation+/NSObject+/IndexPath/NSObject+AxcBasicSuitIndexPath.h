//
//  NSObject+AxcBasicSuitIndexPath.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/26.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AxcBasicSuitIndexPath)

/**
 标记索引
 */
@property(nonatomic , strong)NSIndexPath *axcIndexPath;

/**
 字符标签
 */
@property(nonatomic , strong)NSString *axcStringTag;

/**
 数值类型标签
 */
@property(nonatomic , assign)NSInteger axcIntTag;

/**
 存值性属性
 */
@property(nonatomic , strong)NSObject *saveValueObj;


@end
