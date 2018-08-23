//
//  NSString+AxcUrlEncode.h
//  Enterprise_Information
//
//  Created by AxcLogo on 2018/8/13.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AxcUrlEncode)

/**
 *  Encode
 */
- (NSString *)AxcTool_encodedString;

/**
 *  Decode
 */
-(NSString *)AxcTool_decodedString;


@end
