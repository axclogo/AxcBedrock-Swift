//
//  AxcDataCache.h
//  xiezhi-iOS
//
//  Created by Axc on 2017/12/6.
//  Copyright © 2017年 Axc. All rights reserved.
//

#import "AxcCalculateTool.h"

#import "NSData+AxcDataConversionEx.h"                  // 快速Data转换数据 - NSData
#import "NSArray+AxcDataConversionEx.h"                 // 快速Data转换数据 - NSArray
#import "NSString+AxcDataConversionEx.h"                // 快速Data转换数据 - NSString
#import "NSDictionary+AxcDataConversionEx.h"            // 快速Data转换数据 - NSDictionary

#import "NSString+Axc_MD5_Ex.h"                         // MD5转换


#define AxcDataCachePath            @"/Documents/AxcDataCache"
#define kAxcDataCache               @"AxcDataCache"
#define kAxcDefaultCacheFolder      @"AxcDefaultCacheFolder"


@interface AxcDataCache : NSObject

/** 获取缓存路径 */
+ (NSString *)AxcTool_getCachePath;

/**
 将数据存入缓存器，默认文件夹名称
 @param data 数据对象
 @param saveKey 存的文件名/或者唯一标识
 */
+ (void)AxcTool_cacheSaveWithData:(NSData *)data
                          saveKey:(NSString *)saveKey;

/**
 将数据存入缓存器，自定文件夹名称
 @param data 数据对象
 @param folderName 文件夹名称-自动创建
 @param saveKey 存的文件名/或者唯一标识
 */
+ (void)AxcTool_cacheSaveWithData:(NSData *)data
                          saveKey:(NSString *)saveKey
                       folderName:(NSString *)folderName;

/**
 将数据取出缓存器，默认文件夹名称
 @param saveKey 存的文件名/或者唯一标识
 @return 数据对象
 */
+ (NSData *)AxcTool_cacheGetDataWithSaveKey:(NSString *)saveKey;

/**
 将数据取出缓存器，自定文件夹名称
 @param folderName 文件夹名称
 @param saveKey 存的文件名/或者唯一标识
 @return 数据对象
 */
+ (NSData *)AxcTool_cacheGetDataWithSaveKey:(NSString *)saveKey
                                 folderName:(NSString *)folderName;



/** 清除全部缓存 */
+ (void)AxcTool_clearAllDataCache;

/** 清除默认文件夹下的缓存 */
+ (void)AxcTool_clearDefaultCacheFolderCache;

/**
 清除某个文件夹下的数据缓存
 @param folderName 文件夹名称
 */
+ (void)AxcTool_clearCacheWithFolderName:(NSString *)folderName;

/** 清除saveKey的缓存 */
+ (void)AxcTool_clearCacheWithFolderName:(NSString *)folderName saveKey:(NSString *)saveKey;

/**
 清除某个路径下的数据缓存
 */
+ (void)AxcTool_clearCacheWithDataFilePath:(NSString *)dataFilePath;


@end
