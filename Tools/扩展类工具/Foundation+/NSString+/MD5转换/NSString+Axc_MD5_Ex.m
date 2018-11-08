//
//  NSString+Axc_MD5_Ex.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/5.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "NSString+Axc_MD5_Ex.h"
#import <CommonCrypto/CommonDigest.h>
#import "AxcBasicSuitDefine.h"

@implementation NSString (Axc_MD5_Ex)


/**
 MD5换算
 @return MD5
 */
- (NSString *)AxcTool_get_MD5_Str{
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (int)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

/**
 MD5换算 生成文件的MD5
 @return MD5
 */
- (NSString *)AxcTool_getFile_MD5_Str{
    //生成文件的MD5   校验的是压缩包的MD5  判断下载是否正确
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:self];
    if( handle == nil ) {
        NSString *log = [NSString stringWithFormat:@"文件出错，请检查文件路径是否正确！\n文件路径：%@",self];
        AxcErrorObjLog(log);
    }
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    while(!done) {
        NSData* fileData = [handle readDataOfLength: 256 ];
        CC_MD5_Update(&md5, [fileData bytes], (int)[fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString *fileMD5 = [NSString stringWithFormat:
                         @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                         digest[0], digest[1], digest[2], digest[3],
                         digest[4], digest[5], digest[6], digest[7],
                         digest[8], digest[9], digest[10], digest[11],
                         digest[12], digest[13], digest[14], digest[15]];
    return fileMD5;
}

@end
