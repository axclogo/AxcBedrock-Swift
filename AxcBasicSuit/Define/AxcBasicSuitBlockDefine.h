//
//  AxcBaseSuitBlockDefine.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/26.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 设置字符格式Block
 @param strings 返回一组需要格式化的字符组
 @return 返回格式化后的字符组
 */
typedef NSString *(^AxcBasicSuitFormatBlock )(NSArray <NSString *>*strings);

/**
 导航条上的按钮被触发Block
 @param barItemBtn 返回按钮对象
 */
typedef void (^AxcBasicSuitBarBtnItemBlock )(UIButton *barItemBtn);


/**
 倒计时结束回调Block
 */
typedef void (^AxcBasicSuitBtnTimeEndBlock )(void);

/**
 sender回调Block
 */
typedef void (^AxcBasicSuitSenderBlock )(id sender);


/**
 字符遍历回调Block
 */
typedef void (^AxcBasicSuitEnumerateBlock )(NSString *str,NSInteger idx, BOOL *stop);




