//
//  NSString+AxcUrlEncode.m
//  Enterprise_Information
//
//  Created by AxcLogo on 2018/8/13.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "NSString+AxcUrlEncode.h"

@implementation NSString (AxcUrlEncode)

/**
 *  Encode
 */
- (NSString *)AxcTool_encodedString{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *upSign = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return upSign;
}

/**
 *  Decode
 */
-(NSString *)AxcTool_decodedString{
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[outputStr length])];
    return [outputStr stringByRemovingPercentEncoding];
}


@end
