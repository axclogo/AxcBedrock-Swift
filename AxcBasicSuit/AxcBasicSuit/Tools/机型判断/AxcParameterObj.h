//
//  AxcParameterObj.h
//  任务动态规划
//
//  Created by Axc on 2017/9/28.
//  Copyright © 2017年 Axc. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 系统版本 */
typedef NS_ENUM(NSInteger, AxcSystemVersionType) {
    AxcSystemVersionType_iPhone_2G,
    AxcSystemVersionType_iPhone_3G,
    AxcSystemVersionType_iPhone_3GS,
    AxcSystemVersionType_iPhone_4,
    AxcSystemVersionType_iPhone_4S,
    AxcSystemVersionType_iPhone_5,
    AxcSystemVersionType_iPhone_5c,
    AxcSystemVersionType_iPhone_5s,
    AxcSystemVersionType_iPhone_6,
    AxcSystemVersionType_iPhone_6_Plus,
    AxcSystemVersionType_iPhone_6s,
    AxcSystemVersionType_iPhone_6s_Plus,
    AxcSystemVersionType_iPhone_SE,
    AxcSystemVersionType_iPhone_7,
    AxcSystemVersionType_iPhone_7_Plus,
    AxcSystemVersionType_iPhone_8,
    AxcSystemVersionType_iPhone_8_Plus,
    AxcSystemVersionType_iPhone_X,
    AxcSystemVersionType_iPod_Touch_1G,
    AxcSystemVersionType_iPod_Touch_2G,
    AxcSystemVersionType_iPod_Touch_3G,
    AxcSystemVersionType_iPod_Touch_4G,
    AxcSystemVersionType_iPod_Touch_5G,
    AxcSystemVersionType_iPad_1G,
    AxcSystemVersionType_iPad_2,
    AxcSystemVersionType_iPad_Mini_1G,
    AxcSystemVersionType_iPad_3,
    AxcSystemVersionType_iPad_4,
    AxcSystemVersionType_iPad_Air,
    AxcSystemVersionType_iPad_Mini_2G,
    AxcSystemVersionType_iPad_Mini_3,
    AxcSystemVersionType_iPad_Mini_4,
    AxcSystemVersionType_iPad_Air_2,
    AxcSystemVersionType_iPad_Pro_9_7,
    AxcSystemVersionType_iPad_Pro_12_9,
    AxcSystemVersionType_iPhone_Simulator,
    
    AxcSystemVersionType_unknown = 1000
};

@interface AxcParameterObj : NSObject

/** 输出字符式的机型信息，是否打印平台参数 */
- (NSString *)LogMachineWithPlatform:(BOOL )platformbol;

/** 获取机型枚举 */
@property(nonatomic, assign ,readonly)AxcSystemVersionType axcSystemVersionType;

@end
