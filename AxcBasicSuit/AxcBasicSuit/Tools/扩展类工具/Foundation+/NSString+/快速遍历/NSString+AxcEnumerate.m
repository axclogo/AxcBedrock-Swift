//
//  NSString+AxcEnumerate.m
//  Enterprise_Information
//
//  Created by AxcLogo on 2018/8/13.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "NSString+AxcEnumerate.h"

@implementation NSString (AxcEnumerate)

- (void)AxcTool_enumerateLinesUsingBlock:(AxcBasicSuitEnumerateBlock)block{
    NSString *temp = nil;
    BOOL stop = NO;
    for(int i = 0; i < self.length ; i++){
        temp = [self substringWithRange:NSMakeRange(i,1)];
        block(temp.copy,i,&stop);
        if (stop) { // 终止
            break;
        }
    }
}

@end
