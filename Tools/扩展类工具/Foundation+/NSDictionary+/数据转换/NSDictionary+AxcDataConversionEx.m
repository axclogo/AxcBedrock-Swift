//
//  NSDictionary+AxcDataConversionEx.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "NSDictionary+AxcDataConversionEx.h"

@implementation NSDictionary (AxcDataConversionEx)

/**
 Data转字典
 @param data data
 @return dic
 */
+ (NSDictionary *)AxcTool_dicWithData:(NSData *)data{
    return [self AxcTool_dicWithData:data options:NSJSONReadingMutableLeaves error:nil];
}

/**
 Data转字典
 @param data 数据
 @param opt 转换类型
 @param error 失败指针
 @return dic
 */
+ (NSDictionary *)AxcTool_dicWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error{
    return [NSJSONSerialization JSONObjectWithData:data options:opt error:error];
}

@end
