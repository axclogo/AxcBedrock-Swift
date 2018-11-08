//
//  NSObject+AxcBasicSuitObjectEx.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/28.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"                 // 单例app代理

@interface NSObject (AxcBasicSuitObjectEx)

/** 任意对象都会拥有自带一个通知中心 */
@property(nonatomic , readonly)NSNotificationCenter *notificationCenter;
/** 单例管理 */
@property(nonatomic , readonly)NSUserDefaults *userDefaults;
/** app代理 */
@property(nonatomic , readonly)AppDelegate *appDelegate;


@end
