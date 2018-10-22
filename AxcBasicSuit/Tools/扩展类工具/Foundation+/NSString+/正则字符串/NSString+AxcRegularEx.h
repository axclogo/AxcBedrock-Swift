//
//  NSString+AxcRegularEx.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/28.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AxcBasicSuitDefine.h"                          // 快速宏定义

@interface NSString (AxcRegularEx)

/** 是否为纯数字 */
- (BOOL)AxcTool_isNumText;

/** 是否为整数 */
- (BOOL)AxcTool_isIntegerNumber;

//***************** 常用判断类型 *****************

/** 是否是URL */
- (BOOL )AxcTool_isURL;

/** 是否为邮箱 */
- (BOOL)AxcTool_isEmail;

/** 匹配用户姓名,20位的中文或英文 */
- (BOOL)AxcTool_isUserName;

/** 匹配用户密码6-18位数字和字母组合 */
- (BOOL)AxcTool_isPassword;

/** 是否为手机号 */
- (BOOL )AxcTool_isPhoneNum;

/** 是否为身份证号 */
- (BOOL )AxcTool_isIdCardNumber;

/** 是否为银行卡号 */
- (BOOL )AxcTool_isBankNumber;

/** 是否为车牌号 */
- (BOOL )AxcTool_IsCarNumber;

/** 是否为Mac地址 */
- (BOOL )AxcTool_isMacAddress;

/** 是否为中文字符 */
- (BOOL )AxcTool_isValidChinese;

/** 是否为邮政编码 */
- (BOOL )AxcTool_isValidPostalcode;

/** 是否为IP地址 */
- (BOOL )AxcTool_isIPAddress;

/** 是否仅为数字和字母 */
- (BOOL )AxcTool_isNumAndString;


/**
 使这个字符串与某个正则表达式进行匹配
 @param regularStr 正则表达式
 @return Bool
 */
- (BOOL )AxcTool_isRegularExpression:(NSString *)regularStr;

@end
