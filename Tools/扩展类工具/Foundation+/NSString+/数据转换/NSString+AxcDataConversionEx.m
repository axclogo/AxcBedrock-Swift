//
//  NSString+AxcDataConversionEx.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "NSString+AxcDataConversionEx.h"

@implementation NSString (AxcDataConversionEx)

/**
 Data转字符串
 @param data 数据
 @return 字符
 */
+ (NSString *)AxcTool_stringWithData:(NSData *)data{
    return [self AxcTool_stringWithData:data encoding:NSUTF8StringEncoding];
}

/**
 Data转字符串
 @param data 数据
 @param encoding 编码规则
 @return 字符
 */
+ (NSString *)AxcTool_stringWithData:(NSData *)data encoding:(NSStringEncoding )encoding{
    return [[NSString alloc]initWithData:data encoding:encoding];
}


@end
