//
//  NSDictionary+AxcDataConversionEx.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (AxcDataConversionEx)

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

@end
