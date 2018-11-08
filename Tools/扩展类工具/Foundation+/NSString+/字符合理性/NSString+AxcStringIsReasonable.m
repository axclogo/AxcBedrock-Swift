//
//  NSString+AxcStringIsReasonable.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/5.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "NSString+AxcStringIsReasonable.h"

#define NullString @"null"

@implementation NSString (AxcStringIsReasonable)

/**
 字符串是否合理，即长度不为0且不等于null、<null>、(null)以及NSNull
 @return 是否
 */
- (BOOL )AxcTool_isReasonable{
    BOOL isReasonable = NO;
    if (self.length) { // 首先要有长度
        if (![self AxcTool_fuzzySearch:NullString] && // 其中存不能在null字符
            ![self isKindOfClass:[NSNull class]]) { // 并且不属于NSNull类
            isReasonable = YES;
        }
    }
    return isReasonable;
}


/**
 模糊查找一个字符是否包含另一个字符
 @param searchString 查找字符
 @return bool
 */
- (BOOL )AxcTool_fuzzySearch:(NSString *)searchString{
    return [self rangeOfString:searchString].location != NSNotFound;
}

@end
