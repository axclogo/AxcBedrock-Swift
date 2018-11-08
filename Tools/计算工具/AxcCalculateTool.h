//
//  AxcBaseSuitCalculateTool.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/26.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcBasicSuitDefine.h"          // 快速宏定义
#import "AxcLanguageManagement.h"       // 语言切换
#import "AxcBasicSuitBlockDefine.h"     // Block定义

/** 运算操作类型 */
typedef NS_ENUM(NSInteger, AxcCalculateType) {
    AxcCalculateTypeAdd,           // 加
    AxcCalculateTypeReduction,     // 减
    AxcCalculateTypeTake,          // 乘
    AxcCalculateTypeAddition,      // 除
};
/**
 常用的一些计算算法、排序等
 主要是涉及到数值计算的定义函数
 */
@interface AxcCalculateTool : NSObject


/**
 角度转弧度
 @param degrees 角度
 */
+ (CGFloat)AxcTool_degreesToRadian:(CGFloat )degrees;

/**
 弧度转角度
 @param radian 弧度
 */
+ (CGFloat)AxcTool_radianToDegrees:(CGFloat )radian;

/**
 数值递归计算操作
 @param calculateType 递归计算类型
 @param data 递归数值
 @param operationCount 操作递归次数
 @param operationValue 操作数值
 @return 结果
 */
+ (CGFloat )AxcTool_recursiveCalculateType:(AxcCalculateType )calculateType
                                      data:(CGFloat )data
                            operationCount:(NSInteger )operationCount
                            operationValue:(CGFloat )operationValue;



@end

#pragma mark - 数据换算/计算 函数分层类扩展

@interface AxcCalculateTool (AxcConversionCalculateEx)


/**
 换算 字符串(或汉字)首字母
 @param string 入参字符或文字
 @return 出参首字母
 */
+ (NSString *)AxcTool_firstCharacterWithString:(NSString *)string;


@end


#pragma mark - 文件计算 函数分层类扩展

/** 获取某种类型磁盘空间的大小 */
typedef NS_ENUM(NSInteger, AxcBasicSuitFileSystemType) {
    /* 磁盘空间 */
    AxcBasicSuitFileSystemTypeSize,
    /* 磁盘剩余空间 */
    AxcBasicSuitFileSystemTypeFreeSize,
    /* 磁盘已占用空间 */
    AxcBasicSuitFileSystemTypeUseSize,
};

/** 存储大小单位 */
typedef NS_ENUM(NSInteger, AxcBasicSuitStorageUnitType) {
    AxcBasicSuitStorageSizeTypeByte = 0,        // 字节
    AxcBasicSuitStorageSizeTypeKilobyte,        // 千字节
    AxcBasicSuitStorageSizeTypeMegabyte,        // 兆字节
    AxcBasicSuitStorageSizeTypeGigabyte,        // G字节
    AxcBasicSuitStorageSizeTypeTerabyte,        // T字节
    AxcBasicSuitStorageSizeTypePetabyte,        // 帕字节
    AxcBasicSuitStorageSizeTypeExabyte,         // 艾字节
    AxcBasicSuitStorageSizeTypeZettabyte,       // Z字节
    AxcBasicSuitStorageSizeTypeYottabyte,       // Y字节
};

@interface AxcCalculateTool (AxcFileCalculateEx)
/**
 获取某种类型的磁盘空间
 @param type 类型
 @return 大小
 */
+ (CGFloat )AxcTool_GetDiskSizeMBytesWithType:(AxcBasicSuitFileSystemType )type;

/**
 获取指定路径下某个文件的大小
 @param filePath 文件路径
 @return 文件大小
 */
+ (CGFloat )AxcTool_GetFileSizeMBytesWithPath:(NSString *)filePath;

/**
 获取文件夹下所有文件的大小
 @param folderPath 文件夹路径
 @return 文件大小
 */
+ (CGFloat )AxcTool_GetFolderFileSizeMBytesWithPath:(NSString *)folderPath;

/**
 数据单位转换
 @param dataUnit 初始数据值
 @param unitType 初始数据值单位
 @param toUnitType 转向/转换成哪个单位
 @return 输出单位
 */
+ (CGFloat )AxcTool_dataUnit:(CGFloat )dataUnit
                    unitType:(AxcBasicSuitStorageUnitType )unitType
                  ToUnitType:(AxcBasicSuitStorageUnitType )toUnitType;

/**
 数据单位转换(默认字节)
 @param dataUnit 初始数据值(默认字节)
 @param toUnitType 转向/转换成哪个单位
 @return 输出单位
 */
+ (CGFloat )AxcTool_dataUnit:(CGFloat )dataUnit
                  ToUnitType:(AxcBasicSuitStorageUnitType )toUnitType;

@end


#pragma mark - 日期计算/换算 函数分层类扩展

@interface AxcCalculateTool (AxcDateCalculateEx)
/**
 毫秒计算时分秒
 @param time 毫秒数值
 @param format 格式，可传空 默认 H:M:S
 @return 时分秒字符串
 */
+ (NSString *)AxcTool_msToHours_Minutes_Seconds:(NSInteger )time
                                         format:(AxcBasicSuitFormatBlock)format;

/**
 计算上次日期距离现在多久(time,Fomant,time,Fomant)
 @param lastTime    上次日期(需要和格式对应)
 @param format1     上次日期格式
 @param currentTime 最近日期(需要和格式对应)
 @param format2     最近日期格式
 @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)AxcTool_timeIntervalFromLastTime:(NSString *)lastTime
                                lastTimeFormat:(NSString *)format1
                                 ToCurrentTime:(NSString *)currentTime
                             currentTimeFormat:(NSString *)format2;

/**
 计算上次日期距离现在多久(NSData,NSData)
 @param lastTime 上次日期(NSData)
 @param currentTime 最近日期(NSData)
 @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)AxcTool_timeIntervalFromLastTime:(NSDate *)lastTime
                                 ToCurrentTime:(NSDate *)currentTime;


@end
