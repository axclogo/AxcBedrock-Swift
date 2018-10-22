//
//  NSString+Axc_MD5_Ex.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/5.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Axc_MD5_Ex)


/**
 MD5换算 生成字符的MD5
 @return MD5
 */
- (NSString *)AxcTool_get_MD5_Str;

/**
 MD5换算 生成文件的MD5
 @return MD5
 */
- (NSString *)AxcTool_getFile_MD5_Str;

@end
