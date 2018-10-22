//
//  NSDate+AxcDateArithmeticEx.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/6.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (AxcDateArithmeticEx)


/**
 从这个日期加上N年
 @param years 年
 @return NSDate
 */
- (NSDate *)AxcTool_dateByAddingYears:(NSInteger)years;

/**
 从这个日期加上N月
 @param months 月
 @return NSDate
 */
- (NSDate *)AxcTool_dateByAddingMonths:(NSInteger)months;

/**
 从这个日期加上N周
 @param weeks 周
 @return NSDate
 */
- (NSDate *)AxcTool_dateByAddingWeeks:(NSInteger)weeks;

/**
 从这个日期加上N天
 @param days 天
 @return NSDate
 */
- (NSDate *)AxcTool_dateByAddingDays:(NSInteger)days;

/**
 从这个日期加上N小时
 @param hours 小时
 @return NSDate
 */
- (NSDate *)AxcTool_dateByAddingHours:(NSInteger)hours;

/**
 从这个日期加上N分钟
 @param minutes 分钟
 @return NSDate
 */
- (NSDate *)AxcTool_dateByAddingMinutes:(NSInteger)minutes;

/**
 从这个日期加上N秒
 @param seconds 秒
 @return NSDate
 */
- (NSDate *)AxcTool_dateByAddingSeconds:(NSInteger)seconds;




@end
