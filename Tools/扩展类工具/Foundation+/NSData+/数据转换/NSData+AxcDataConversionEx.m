//
//  NSData+AxcDataConversionEx.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/2.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "NSData+AxcDataConversionEx.h"

@implementation NSData (AxcDataConversionEx)

/**
 字典&数组转Data
 @param obj 字典或数组
 @return Data数据格式
 */
+ (NSData *)AxcTool_dataWithObj:(id )obj{
    return [self AxcTool_dataWithObj:obj options:NSJSONWritingPrettyPrinted error:nil];
}

/**
 字典&数组转Data
 @param obj 字典或数组
 @param opt 转换类型
 @param error 失败指针
 @return Data数据格式
 */
+ (NSData *)AxcTool_dataWithObj:(id )obj options:(NSJSONWritingOptions)opt error:(NSError **)error{
    return [NSJSONSerialization dataWithJSONObject:obj options:opt error:error];
}

/**
 字符串转Data
 @param str 字符串
 @return 数据
 */
+ (NSData *)AxcTool_dataWithString:(NSString *)str{
    return [self AxcTool_dataWithString:str encoding:NSUTF8StringEncoding];
}

/**
 字符串转Data
 @param str 字符串
 @param encoding 编码规则
 @return 数据
 */
+ (NSData *)AxcTool_dataWithString:(NSString *)str encoding:(NSStringEncoding )encoding{
    return [str dataUsingEncoding: encoding];
}

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
