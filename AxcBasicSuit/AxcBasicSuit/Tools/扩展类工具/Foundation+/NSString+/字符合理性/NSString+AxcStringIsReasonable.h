//
//  NSString+AxcStringIsReasonable.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/5.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AxcStringIsReasonable)


/**
 字符串是否合理，即长度不为0且不等于null、<null>、(null)以及NSNull
 @return 是否
 */
- (BOOL )AxcTool_isReasonable;

/**
 模糊查找一个字符是否包含另一个字符
 @param searchString 查找字符
 @return bool
 */
- (BOOL )AxcTool_fuzzySearch:(NSString *)searchString;


@end
