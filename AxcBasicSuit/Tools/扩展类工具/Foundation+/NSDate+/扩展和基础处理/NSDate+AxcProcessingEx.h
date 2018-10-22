//
//  NSDate+AxcProcessingEx.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/5.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (AxcProcessingEx)


/** 年 */
@property(nonatomic , assign ,readonly)NSInteger years;
/** 月 */
@property(nonatomic , assign ,readonly)NSInteger month;
/** 日 */
@property(nonatomic , assign ,readonly)NSInteger day;

/** 时 默认24小时制 */
@property(nonatomic , assign ,readonly)NSInteger hours;
/** 分 */
@property(nonatomic , assign ,readonly)NSInteger minutes;
/** 秒 */
@property(nonatomic , assign ,readonly)NSInteger seconds;


/**
 传入Fomant获取日期格式
 @param fomant fomant
 @return 日期格式
 */
- (NSString *)AxcTool_getDateWithFomant:(NSString *)fomant;


/** 是否是昨天 */
- (BOOL )AxcTool_isYesterday;
/** 是否是今天 */
- (BOOL )AxcTool_isToday;
/** 是否是明天 */
- (BOOL )AxcTool_isTomorrow;
/** 是否是这个月 */
- (BOOL )AxcTool_isThisMonth;
/** 是否是今年 */
- (BOOL )AxcTool_isThisYear;

/** 比较两个日期的天，是否是同一天 */
- (BOOL )AxcTool_compareDaysWithDate:(NSDate *)date;
/** 比较两个日期的月，是否是同一月 */
- (BOOL )AxcTool_compareMonthWithDate:(NSDate *)date;
/** 比较两个日期的年，是否是同一年 */
- (BOOL )AxcTool_compareYearsWithDate:(NSDate *)date;




@end
