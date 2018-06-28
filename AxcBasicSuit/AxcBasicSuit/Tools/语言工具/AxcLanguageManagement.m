//
//  AxcLanguageManagement.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/26.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcLanguageManagement.h"

#import "AxcBasicSuitDefine.h"          // 快速宏定义


#define LanguageFile @"appLanguage"
#define LanguageTable @"Language"
#define LanguageType @"lproj"

@implementation AxcLanguageManagement

+ (NSDictionary *)getAllCharactersAppearTranslation{
    return [[self defaults] objectForKey:kAxcLanguageManagementStatistics];
}

+ (NSString *)getLanguageString:(NSString *)key record:(BOOL )record{
    NSString *language = [[self bundle] localizedStringForKey:key
                                                        value:nil
                                                        table:LanguageTable];
    if (record) { // 添加记录
        [self addLanguageStatistics:key];
    }
    return language.length ? language : key ; // 语言如果存在 否则直接使用Key
}

+ (NSString *)getLanguageString:(NSString *)key{
    return [self getLanguageString:key record:NO];
}

+ (NSBundle *)bundle{
    return [NSBundle bundleWithPath:[[NSBundle mainBundle]
                                     pathForResource:[self Language]
                                     ofType:LanguageType]];
}

// 如果运行到则增加一个语言记录
+ (void)addLanguageStatistics:(NSString *)key{
    NSDictionary *dic = [[self defaults] objectForKey:kAxcLanguageManagementStatistics];
    NSMutableDictionary *dic_M = dic.mutableCopy;
    NSNumber *count = [dic_M objectForKey:key];
    NSInteger count_i = count.integerValue;
    count_i ++;
    [dic_M setObject:@(count_i) forKey:key];
    [[self defaults] setObject:dic_M forKey:kAxcLanguageManagementStatistics];
}

+ (NSUserDefaults *)defaults{
    return [NSUserDefaults standardUserDefaults];
}

+ (NSString *)Language{
    NSString *l =[[self defaults] objectForKey:LanguageFile];
    return l;
}

@end
