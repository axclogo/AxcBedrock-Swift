//
//  NSData+AxcDataConversionEx.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/2.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AxcDataConversionEx)

/**
 字典&数组转Data
 @param obj 字典或数组
 @return Data数据格式
 */
+ (NSData *)AxcTool_dataWithObj:(id )obj;

/**
 字典&数组转Data
 @param obj 字典或数组
 @param opt 转换类型
 @param error 失败锁雾指针
 @return Data数据格式
 */
+ (NSData *)AxcTool_dataWithObj:(id )obj options:(NSJSONWritingOptions)opt error:(NSError **)error;

/**
 字符串转Data
 @param str 字符串
 @return 数据
 */
+ (NSData *)AxcTool_dataWithString:(NSString *)str;

/**
 字符串转Data
 @param str 字符串
 @param encoding 编码规则
 @return 数据
 */
+ (NSData *)AxcTool_dataWithString:(NSString *)str encoding:(NSStringEncoding )encoding;




/**
 Data转字典
 @param data data
 @return dic
 */
+ (NSDictionary *)AxcTool_dicWithData:(NSData *)data;

/**
 Data转字典
 @param data 数据
 @param opt 转换类型
 @param error 失败指针
 @return dic
 */
+ (NSDictionary *)AxcTool_dicWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error;

/**
 Data转数组
 @param data data
 @return array
 */
+ (NSArray *)AxcTool_arrayWithData:(NSData *)data;

/**
 Data转数组
 @param data 数据
 @param opt 转换类型
 @param error 失败指针
 @return array
 */
+ (NSArray *)AxcTool_arrayWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error;


/**
 Data转字符串
 @param data 数据
 @return 字符
 */
+ (NSString *)AxcTool_stringWithData:(NSData *)data;

/**
 Data转字符串
 @param data 数据
 @param encoding 编码规则
 @return 字符
 */
+ (NSString *)AxcTool_stringWithData:(NSData *)data encoding:(NSStringEncoding )encoding;

@end
