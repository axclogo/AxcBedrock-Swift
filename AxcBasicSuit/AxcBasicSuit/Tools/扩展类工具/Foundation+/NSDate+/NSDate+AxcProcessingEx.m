//
//  NSDate+AxcProcessingEx.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/5.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "NSDate+AxcProcessingEx.h"

#import "AxcBasicSuitDefine.h"

@implementation NSDate (AxcProcessingEx)

/** 年 */
- (NSInteger)years{
    return [self AxcTool_getDateWithFomant:AxcYearsFomat].integerValue;
}
/** 月 */
- (NSInteger)month{
    return [self AxcTool_getDateWithFomant:AxcMonthFomat].integerValue;
}
/** 日 */
- (NSInteger)day{
    return [self AxcTool_getDateWithFomant:AxcDayFomat].integerValue;
}

/** 时 默认24小时制 */
- (NSInteger)hours{
    return [self AxcTool_getDateWithFomant:AxcHoursFomat].integerValue;
}
/** 分 */
- (NSInteger)minutes{
    return [self AxcTool_getDateWithFomant:AxcMinutesFomat].integerValue;
}
/** 秒 */
- (NSInteger)seconds{
    return [self AxcTool_getDateWithFomant:AxcSecondsFomat].integerValue;
}


/**
 传入Fomant获取日期格式
 @param fomant fomant
 @return 日期格式
 */
- (NSString *)AxcTool_getDateWithFomant:(NSString *)fomant{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = fomant;
    return [formatter stringFromDate:self];
}

/** 是否是昨天 */
- (BOOL )AxcTool_isYesterday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    // 生成只有年月日的字符串对象
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    // 生成只有年月日的日期对象
    NSDate *selfDate = [fmt dateFromString:selfString];
    NSDate *nowDate = [fmt dateFromString:nowString];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}
/** 是否是明天 */
- (BOOL )AxcTool_isTomorrow{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    // 生成只有年月日的字符串对象
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    // 生成只有年月日的日期对象
    NSDate *selfDate = [fmt dateFromString:selfString];
    NSDate *nowDate = [fmt dateFromString:nowString];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == -1;
}

/** 是否是今天 */
- (BOOL )AxcTool_isToday{
    return [self AxcTool_compareDaysWithDate:[NSDate date]];
}
/** 是否是这个月 */
- (BOOL )AxcTool_isThisMonth{
    return [self AxcTool_compareMonthWithDate:[NSDate date]];
}
/** 是否是今年 */
- (BOOL )AxcTool_isThisYear{
    return [self AxcTool_compareYearsWithDate:[NSDate date]];
}


/** 比较两个日期的天，是否是同一天 */
- (BOOL )AxcTool_compareDaysWithDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger selfDay = [calendar components:NSCalendarUnitDay fromDate:self].day;
    NSInteger nowDay = [calendar components:NSCalendarUnitDay fromDate:date].day;
    return selfDay == nowDay;
}
/** 比较两个日期的月，是否是同一月 */
- (BOOL )AxcTool_compareMonthWithDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger selfMonth = [calendar components:NSCalendarUnitMonth fromDate:self].month;
    NSInteger nowMonth = [calendar components:NSCalendarUnitMonth fromDate:date].month;
    return selfMonth == nowMonth;
}
/** 比较两个日期的年，是否是同一年 */
- (BOOL )AxcTool_compareYearsWithDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger selfYears = [calendar components:NSCalendarUnitYear fromDate:self].year;
    NSInteger nowYears = [calendar components:NSCalendarUnitYear fromDate:date].year;
    return selfYears == nowYears;
}

@end
