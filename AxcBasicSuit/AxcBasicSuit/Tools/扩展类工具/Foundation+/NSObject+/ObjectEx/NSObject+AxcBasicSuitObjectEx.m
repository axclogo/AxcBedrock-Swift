//
//  NSObject+AxcBasicSuitObjectEx.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/28.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "NSObject+AxcBasicSuitObjectEx.h"

@implementation NSObject (AxcBasicSuitObjectEx)

- (NSNotificationCenter *)notificationCenter{
    return [NSNotificationCenter defaultCenter];
}
- (NSUserDefaults *)userDefaults{
    return [NSUserDefaults standardUserDefaults];;
}
- (AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];;
}

@end
