//
//  NSDate+AxcDateArithmeticEx.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/6.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "NSDate+AxcDateArithmeticEx.h"

@implementation NSDate (AxcDateArithmeticEx)


/**
 从这个日期加上N年
 @param years 年
 @return NSDate
 */
- (NSDate *)AxcTool_dateByAddingYears:(NSInteger)years{
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 从这个日期加上N月
 @param months 月
 @return NSDate
 */
- (NSDate *)AxcTool_dateByAddingMonths:(NSInteger)months{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 从这个日期加上N日
 @param weeks 日
 @return NSDate
 */
- (NSDate *)AxcTool_dateByAddingWeeks:(NSInteger)weeks{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 从这个日期加上N天
 @param days 天
 @return NSDate
 */
- (NSDate *)AxcTool_dateByAddingDays:(NSInteger)days{
    return [self AxcTool_dateByAddingSeconds:86400 * days];
}

/**
 从这个日期加上N小时
 @param hours 小时
 @return NSDate
 */
- (NSDate *)AxcTool_dateByAddingHours:(NSInteger)hours{
    return [self AxcTool_dateByAddingSeconds:3600 * hours];
}

/**
 从这个日期加上N分钟
 @param minutes 分钟
 @return NSDate
 */
- (NSDate *)AxcTool_dateByAddingMinutes:(NSInteger)minutes{
    return [self AxcTool_dateByAddingSeconds:60 * minutes];
}

/**
 从这个日期加上N秒
 @param seconds 秒
 @return NSDate
 */
- (NSDate *)AxcTool_dateByAddingSeconds:(NSInteger)seconds{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + seconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

@end
