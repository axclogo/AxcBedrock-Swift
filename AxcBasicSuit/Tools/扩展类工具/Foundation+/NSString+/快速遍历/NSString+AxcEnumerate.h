//
//  NSString+AxcEnumerate.h
//  Enterprise_Information
//
//  Created by AxcLogo on 2018/8/13.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AxcBasicSuitBlockDefine.h"

@interface NSString (AxcEnumerate)

- (void)AxcTool_enumerateLinesUsingBlock:(AxcBasicSuitEnumerateBlock )block;

@end
