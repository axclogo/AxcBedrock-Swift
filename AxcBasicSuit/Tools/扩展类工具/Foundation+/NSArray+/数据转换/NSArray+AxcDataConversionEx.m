//
//  NSArray+AxcDataConversionEx.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "NSArray+AxcDataConversionEx.h"

@implementation NSArray (AxcDataConversionEx)

/**
 Data转数组
 @param data data
 @return array
 */
+ (NSArray *)AxcTool_arrayWithData:(NSData *)data{
    return [self AxcTool_arrayWithData:data options:NSJSONReadingAllowFragments error:nil];
}

/**
 Data转数组
 @param data 数据
 @param opt 转换类型
 @param error 失败指针
 @return array
 */
+ (NSArray *)AxcTool_arrayWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error{
    return [NSJSONSerialization JSONObjectWithData:data options:opt error:error];
}

@end
