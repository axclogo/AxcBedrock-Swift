//
//  AxcLanguageManagement.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/26.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AxcLanguageManagement : NSObject

+ (NSBundle *)bundle;
+ (NSUserDefaults *)defaults;
+ (NSString *)getLanguageString:(NSString *)key;
+ (NSString *)getLanguageString:(NSString *)key record:(BOOL )record;
+ (NSDictionary *)getAllCharactersAppearTranslation;

@end
