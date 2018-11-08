//
//  AxcParameterObj.m
//  任务动态规划
//
//  Created by Axc on 2017/9/28.
//  Copyright © 2017年 Axc. All rights reserved.
//

#import "AxcParameterObj.h"
#import "AxcBasicSuitDefine.h"
#import <sys/utsname.h>

@implementation AxcParameterObj


- (AxcSystemVersionType )axcSystemVersionType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    if([platform isEqualToString:@"iPhone1,1"]) return AxcSystemVersionType_iPhone_2G;
    if([platform isEqualToString:@"iPhone1,2"]) return AxcSystemVersionType_iPhone_3G;
    if([platform isEqualToString:@"iPhone2,1"]) return AxcSystemVersionType_iPhone_3GS;
    if([platform isEqualToString:@"iPhone3,1"]) return AxcSystemVersionType_iPhone_4;
    if([platform isEqualToString:@"iPhone3,2"]) return AxcSystemVersionType_iPhone_4;
    if([platform isEqualToString:@"iPhone3,3"]) return AxcSystemVersionType_iPhone_4;
    if([platform isEqualToString:@"iPhone4,1"]) return AxcSystemVersionType_iPhone_4S;
    if([platform isEqualToString:@"iPhone5,1"]) return AxcSystemVersionType_iPhone_5;
    if([platform isEqualToString:@"iPhone5,2"]) return AxcSystemVersionType_iPhone_5;
    if([platform isEqualToString:@"iPhone5,3"]) return AxcSystemVersionType_iPhone_5c;
    if([platform isEqualToString:@"iPhone5,4"]) return AxcSystemVersionType_iPhone_5c;
    if([platform isEqualToString:@"iPhone6,1"]) return AxcSystemVersionType_iPhone_5s;
    if([platform isEqualToString:@"iPhone6,2"]) return AxcSystemVersionType_iPhone_5s;
    if([platform isEqualToString:@"iPhone7,1"]) return AxcSystemVersionType_iPhone_6_Plus;
    if([platform isEqualToString:@"iPhone7,2"]) return AxcSystemVersionType_iPhone_6;
    if([platform isEqualToString:@"iPhone8,1"]) return AxcSystemVersionType_iPhone_6s;
    if([platform isEqualToString:@"iPhone8,2"]) return AxcSystemVersionType_iPhone_6s_Plus;
    if([platform isEqualToString:@"iPhone8,4"]) return AxcSystemVersionType_iPhone_SE;
    if([platform isEqualToString:@"iPhone9,1"]) return AxcSystemVersionType_iPhone_7;
    if([platform isEqualToString:@"iPhone9,2"]) return AxcSystemVersionType_iPhone_7_Plus;
    if([platform isEqualToString:@"iPhone10,1"]) return AxcSystemVersionType_iPhone_8;
    if([platform isEqualToString:@"iPhone10,4"]) return AxcSystemVersionType_iPhone_8;
    if([platform isEqualToString:@"iPhone10,2"]) return AxcSystemVersionType_iPhone_8_Plus;
    if([platform isEqualToString:@"iPhone10,5"]) return AxcSystemVersionType_iPhone_8_Plus;
    if([platform isEqualToString:@"iPhone10,3"]) return AxcSystemVersionType_iPhone_X;
    if([platform isEqualToString:@"iPhone10,6"]) return AxcSystemVersionType_iPhone_X;
    if([platform isEqualToString:@"iPod1,1"]) return AxcSystemVersionType_iPod_Touch_1G;
    if([platform isEqualToString:@"iPod2,1"]) return AxcSystemVersionType_iPod_Touch_2G;
    if([platform isEqualToString:@"iPod3,1"]) return AxcSystemVersionType_iPod_Touch_3G;
    if([platform isEqualToString:@"iPod4,1"]) return AxcSystemVersionType_iPod_Touch_4G;
    if([platform isEqualToString:@"iPod5,1"]) return AxcSystemVersionType_iPod_Touch_5G;
    if([platform isEqualToString:@"iPad1,1"]) return AxcSystemVersionType_iPad_1G;
    if([platform isEqualToString:@"iPad2,1"]) return AxcSystemVersionType_iPad_2;
    if([platform isEqualToString:@"iPad2,2"]) return AxcSystemVersionType_iPad_2;
    if([platform isEqualToString:@"iPad2,3"]) return AxcSystemVersionType_iPad_2;
    if([platform isEqualToString:@"iPad2,4"]) return AxcSystemVersionType_iPad_2;
    if([platform isEqualToString:@"iPad2,5"]) return AxcSystemVersionType_iPad_Mini_1G;
    if([platform isEqualToString:@"iPad2,6"]) return AxcSystemVersionType_iPad_Mini_1G;
    if([platform isEqualToString:@"iPad2,7"]) return AxcSystemVersionType_iPad_Mini_1G;
    if([platform isEqualToString:@"iPad3,1"]) return AxcSystemVersionType_iPad_3;
    if([platform isEqualToString:@"iPad3,2"]) return AxcSystemVersionType_iPad_3;
    if([platform isEqualToString:@"iPad3,3"]) return AxcSystemVersionType_iPad_3;
    if([platform isEqualToString:@"iPad3,4"]) return AxcSystemVersionType_iPad_4;
    if([platform isEqualToString:@"iPad3,5"]) return AxcSystemVersionType_iPad_4;
    if([platform isEqualToString:@"iPad3,6"]) return AxcSystemVersionType_iPad_4;
    if([platform isEqualToString:@"iPad4,1"]) return AxcSystemVersionType_iPad_Air;
    if([platform isEqualToString:@"iPad4,2"]) return AxcSystemVersionType_iPad_Air;
    if([platform isEqualToString:@"iPad4,3"]) return AxcSystemVersionType_iPad_Air;
    if([platform isEqualToString:@"iPad4,4"]) return AxcSystemVersionType_iPad_Mini_2G;
    if([platform isEqualToString:@"iPad4,5"]) return AxcSystemVersionType_iPad_Mini_2G;
    if([platform isEqualToString:@"iPad4,6"]) return AxcSystemVersionType_iPad_Mini_2G;
    if([platform isEqualToString:@"iPad4,7"]) return AxcSystemVersionType_iPad_Mini_3;
    if([platform isEqualToString:@"iPad4,8"]) return AxcSystemVersionType_iPad_Mini_3;
    if([platform isEqualToString:@"iPad4,9"]) return AxcSystemVersionType_iPad_Mini_3;
    if([platform isEqualToString:@"iPad5,1"]) return AxcSystemVersionType_iPad_Mini_4;
    if([platform isEqualToString:@"iPad5,2"]) return AxcSystemVersionType_iPad_Mini_4;
    if([platform isEqualToString:@"iPad5,3"]) return AxcSystemVersionType_iPad_Air_2;
    if([platform isEqualToString:@"iPad5,4"]) return AxcSystemVersionType_iPad_Air_2;
    if([platform isEqualToString:@"iPad6,3"]) return AxcSystemVersionType_iPad_Pro_9_7;
    if([platform isEqualToString:@"iPad6,4"]) return AxcSystemVersionType_iPad_Pro_9_7;
    if([platform isEqualToString:@"iPad6,7"]) return AxcSystemVersionType_iPad_Pro_12_9;
    if([platform isEqualToString:@"iPad6,8"]) return AxcSystemVersionType_iPad_Pro_12_9;
    if([platform isEqualToString:@"i386"])   return AxcSystemVersionType_iPhone_Simulator;
    if([platform isEqualToString:@"x86_64"]) return AxcSystemVersionType_iPhone_Simulator;
    NSString *log = [NSString stringWithFormat:@"Error：未知的机型<此函数最后编辑日期：Created by Axc on 2017/9/28>\nSystemInfo.Machine：%@",platform];
    AxcErrorObjLog(log)
    return AxcSystemVersionType_unknown;
}

- (NSString *)LogMachineWithPlatform:(BOOL )platformbol{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    if (!platformbol) {
        if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
        if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
        if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
        if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
        if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
        if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
        if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
        if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
        if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
        if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
        if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
        if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
        if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
        if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
        if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
        if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
        if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
        if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
        if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
        if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
        if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
        if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
        if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
        if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
        if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
        if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
        if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";
        if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";
        if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";
        if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";
        if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";
        if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";
        if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";
        if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";
        if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";
        if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";
        if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";
        if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";
        if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";
        if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";
        if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";
        if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";
        if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";
        if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";
        if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";
        if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";
        if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";
        if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";
        if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";
        if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";
        if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";
        if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";
        if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";
        if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";
        if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";
        if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";
        if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";
        if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";
        if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";
        if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";
        if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";
        if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";
        if([platform isEqualToString:@"i386"])    return@"iPhone Simulator";
        if([platform isEqualToString:@"x86_64"])  return@"iPhone Simulator";
    }
    return platform;
}


@end
