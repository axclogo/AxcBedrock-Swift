//
//  AxcBaseSuitCalculateTool.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/26.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcCalculateTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation AxcCalculateTool

/**
 角度转弧度
 @param degrees 角度
 */
+ (CGFloat)AxcTool_degreesToRadian:(CGFloat )degrees{
    return (M_PI * (degrees) / 180.0);
}

/**
 弧度转角度
 @param radian 弧度
 */
+ (CGFloat)AxcTool_radianToDegrees:(CGFloat )radian{
    return (radian * 180.0) / M_PI;
}

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
                            operationValue:(CGFloat )operationValue{
    if (operationCount != 0) {
        switch (calculateType) {
            case AxcCalculateTypeAdd:{            // 加
                data += operationValue;
            }break;
            case AxcCalculateTypeReduction:{      // 减
                data -= operationValue;
            }break;
            case AxcCalculateTypeTake:{           // 乘
                data *= operationValue;
            }break;
            case AxcCalculateTypeAddition:{       // 除
                data /= operationValue;
            }break;
            default: break;
        }
        operationCount -= 1;
        return [self AxcTool_recursiveCalculateType:calculateType
                                               data:data
                                     operationCount:operationCount
                                     operationValue:operationValue];
    }
    return data;
}


@end

#pragma mark - 数据换算/计算 函数分层类扩展

@implementation AxcCalculateTool (AxcConversionCalculateEx)


/**
 获取字符串(或汉字)首字母
 @param string 入参字符或文字
 @return 出参首字母
 */
+ (NSString *)AxcTool_firstCharacterWithString:(NSString *)string{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pingyin = [str capitalizedString];
    return [pingyin substringToIndex:1];
}



// 千位符
@end


#pragma mark - 文件计算 函数分层类扩展

@implementation AxcCalculateTool (AxcFileCalculateEx)

/**
 获取某种类型的磁盘空间
 @param type 类型
 @return 大小
 */
+ (CGFloat )AxcTool_GetDiskSizeMBytesWithType:(AxcBasicSuitFileSystemType )type{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
        AxcErrorObjLog(error.localizedDescription);
    }else{
        switch (type) {
            case AxcBasicSuitFileSystemTypeSize:{
                NSNumber *number = [dic objectForKey:NSFileSystemSize];
                size = [self AxcTool_dataUnit:[number floatValue] ToUnitType:AxcBasicSuitStorageSizeTypeMegabyte];
            }break;
            case AxcBasicSuitFileSystemTypeFreeSize:{
                NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
                size = [self AxcTool_dataUnit:[number floatValue] ToUnitType:AxcBasicSuitStorageSizeTypeMegabyte];
            }break;
            case AxcBasicSuitFileSystemTypeUseSize:{
                NSNumber *number = [dic objectForKey:NSFileSystemSize];
                CGFloat allSize = [self AxcTool_dataUnit:[number floatValue] ToUnitType:AxcBasicSuitStorageSizeTypeMegabyte];
                number = [dic objectForKey:NSFileSystemFreeSize];
                CGFloat freeSize = [self AxcTool_dataUnit:[number floatValue] ToUnitType:AxcBasicSuitStorageSizeTypeMegabyte];
                size = allSize - freeSize;
            }break;
            default:{
                AxcErrorObjLog(@"error: Unknown type With Enum:<AxcBasicSuitFileSystemType>");
            } break;
        }
    }
    return size;
}


/**
 获取指定路径下某个文件的大小
 @param filePath 文件路径
 @return 文件大小
 */
+ (CGFloat )AxcTool_GetFileSizeMBytesWithPath:(NSString *)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) return 0;
    CGFloat size = [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
    return [self AxcTool_dataUnit:size ToUnitType:AxcBasicSuitStorageSizeTypeMegabyte];
}


/**
 获取文件夹下所有文件的大小
 @param folderPath 文件夹路径
 @return 文件大小
 */
+ (CGFloat )AxcTool_GetFolderFileSizeMBytesWithPath:(NSString *)folderPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *filesEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folerSize = 0;
    while ((fileName = [filesEnumerator nextObject]) != nil) {
        NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
        folerSize += [self AxcTool_GetFileSizeMBytesWithPath:filePath];
    }
    return folerSize;
}

/**
 数据单位转换
 @param dataUnit 初始数据值
 @param unitType 初始数据值单位
 @param toUnitType 转向/转换成哪个单位
 @return 输出单位
 */
+ (CGFloat )AxcTool_dataUnit:(CGFloat )dataUnit
                    unitType:(AxcBasicSuitStorageUnitType )unitType
                  ToUnitType:(AxcBasicSuitStorageUnitType )toUnitType{
    NSInteger between = toUnitType - unitType;
    NSInteger operationCount = labs(between); // 绝对值
    return [self AxcTool_recursiveCalculateType:between > 0 ? // 向上转换除法 // 向下转换乘法
             AxcCalculateTypeAddition : AxcCalculateTypeTake
                                           data:dataUnit
                                 operationCount:operationCount
                                 operationValue:1024];
}

/**
 数据单位转换
 @param dataUnit 初始数据值(默认字节)
 @param toUnitType 转向/转换成哪个单位
 @return 输出单位
 */
+ (CGFloat )AxcTool_dataUnit:(CGFloat )dataUnit
                  ToUnitType:(AxcBasicSuitStorageUnitType )toUnitType{
    return [self AxcTool_dataUnit:dataUnit unitType:AxcBasicSuitStorageSizeTypeByte ToUnitType:toUnitType];
}


@end

#pragma mark - 日期计算 函数分层类扩展

@implementation AxcCalculateTool (AxcDateCalculateEx)

/**
 毫秒转时分秒
 @param time 毫秒数值
 @return 时分秒字符串
 */
+ (NSString *)AxcTool_msToHours_Minutes_Seconds:(NSInteger )time format:(AxcBasicSuitFormatBlock)format{
    NSInteger hour = 0;
    NSInteger minute = 0;
    NSInteger second = 0;
    second = time / 1000;
    if (second > 60) {
        minute = second / 60;
        second = second % 60;
    }
    if (minute > 60) {
        hour = minute / 60;
        minute = minute % 60;
    }
    if (format) {
        return format(@[[self zeroPadding:hour],[self zeroPadding:minute],[self zeroPadding:second]]);
    }
    return [NSString stringWithFormat:@"%@:%@:%@",[self zeroPadding:hour],[self zeroPadding:minute],[self zeroPadding:second]];
}
+ (NSString *)zeroPadding:(NSInteger )i{
    NSString *iStr = [NSString stringWithFormat:@"%ld",i];
    if (iStr.length<2) {
        iStr = [NSString stringWithFormat:@"0%@",iStr];
    }
    return iStr;
}

/**
 计算上次日期距离现在多久
 @param lastTime    上次日期(需要和格式对应)
 @param format1     上次日期格式
 @param currentTime 最近日期(需要和格式对应)
 @param format2     最近日期格式
 @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)AxcTool_timeIntervalFromLastTime:(NSString *)lastTime
                                lastTimeFormat:(NSString *)format1
                                 ToCurrentTime:(NSString *)currentTime
                             currentTimeFormat:(NSString *)format2{
    //上次时间
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    dateFormatter1.dateFormat = format1;
    NSDate *lastDate = [dateFormatter1 dateFromString:lastTime];
    //当前时间
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    dateFormatter2.dateFormat = format2;
    NSDate *currentDate = [dateFormatter2 dateFromString:currentTime];
    return [AxcCalculateTool AxcTool_timeIntervalFromLastTime:lastDate ToCurrentTime:currentDate];
}

/**
 计算上次日期距离现在多久
 @param lastTime 上次日期(NSData)
 @param currentTime 最近日期(NSData)
 @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)AxcTool_timeIntervalFromLastTime:(NSDate *)lastTime
                                 ToCurrentTime:(NSDate *)currentTime{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //上次时间
    NSDate *lastDate = [lastTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:lastTime]];
    //当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    //秒、分、小时、天、月、年
    NSInteger minutes = intevalTime / 60;
    NSInteger hours = intevalTime / 60 / 60;
    NSInteger day = intevalTime / 60 / 60 / 24;
    NSInteger month = intevalTime / 60 / 60 / 24 / 30;
    NSInteger yers = intevalTime / 60 / 60 / 24 / 365;
    if (minutes <= 10) {
        return AxcLS(AxcBasicSuitJustNowText);
    }else if (minutes < 60){
        return [NSString stringWithFormat: @"%ld%@%@",(long)minutes,AxcLS(AxcBasicSuitMinutesText)
                ,AxcLS(AxcBasicSuitBeforeText)];
    }else if (hours < 24){
        return [NSString stringWithFormat: @"%ld%@%@",(long)hours,AxcLS(AxcBasicSuitHoursText)
                ,AxcLS(AxcBasicSuitBeforeText)];
    }else if (day < 30){
        return [NSString stringWithFormat: @"%ld%@%@",(long)day,AxcLS(AxcBasicSuitDayText)
                ,AxcLS(AxcBasicSuitBeforeText)];
    }else if (month < 12){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = [NSString stringWithFormat:@"M%@d%@",AxcLS(AxcBasicSuitMonthText)
                         ,AxcLS(AxcBasicSuitDateText)];
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }else if (yers >= 1){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = [NSString stringWithFormat:@"yyyy%@M%@d%@",AxcLS(AxcBasicSuitYearsText),
                         AxcLS(AxcBasicSuitMonthText),
                         AxcLS(AxcBasicSuitDateText)];
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }
    return AxcLS(AxcBasicSuitUnknownText);
}




@end
