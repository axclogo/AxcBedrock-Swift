//
//  NSString+AxcRegularEx.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/28.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "NSString+AxcRegularEx.h"

@implementation NSString (AxcRegularEx)

/** 是否为纯数字 */
- (BOOL)AxcTool_isNumText{
    return [self AxcTool_isRegularExpression:AxcIsNumberTextRegular];
}
/** 是否为整数 */
- (BOOL)AxcTool_isIntegerNumber{
    return [self AxcTool_isRegularExpression:AxcIsIntegerNumberRegular];
}

/** 是否是URL */
- (BOOL )AxcTool_isURL{
    return [self AxcTool_isRegularExpression:AxcIsURLRegular];
}
/** 是否为邮箱 */
- (BOOL)AxcTool_isEmail{
    return [self AxcTool_isRegularExpression:AxcIsEmailRegular];
}
/** 是否为手机号 */
- (BOOL )AxcTool_isPhoneNum{
    return [self AxcTool_isRegularExpression:AxcIsPhoneNumberRegular];
}
/** 是否为身份证号 */
- (BOOL )AxcTool_isIdCardNumber{
    return [self AxcTool_isRegularExpression:AxcIsIdCardNumberRegular];
}
/** 是否为车牌号 */
- (BOOL )AxcTool_IsCarNumber{
    return [self AxcTool_isRegularExpression:AxcIsCarNumberRegular];
}

/** 是否为Mac地址 */
- (BOOL )AxcTool_isMacAddress{
    return [self AxcTool_isRegularExpression:AxcIsMacAddressRegular];
}

/** 是否为中文字符 */
- (BOOL )AxcTool_isValidChinese{
    return [self AxcTool_isRegularExpression:AxcIsValidChineseRegular];
}

/** 是否为邮政编码 */
- (BOOL )AxcTool_isValidPostalcode{
    return [self AxcTool_isRegularExpression:AxcIsValidPostalcodeRegular];
}

/** 是否为IP地址 */
- (BOOL )AxcTool_isIPAddress{
    BOOL isIPAddress = [self AxcTool_isRegularExpression:AxcIsIPAddressRegular];
    if (isIPAddress) {
        NSArray *componds = [self componentsSeparatedByString:@","];
        BOOL v = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                v = NO;
                break;
            }
        }
        return v;
    }
    return NO;
}




- (BOOL )AxcTool_isRegularExpression:(NSString *)regularStr{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regularStr];
    return [predicate evaluateWithObject:self];
}

@end
