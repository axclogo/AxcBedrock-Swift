//
//  ViewController.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/26.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "ViewController.h"
#import "AxcBasicSuitPrefixHeader.h"

#define NSLog(FORMAT, ...) printf("%s\n",[[NSString stringWithFormat:FORMAT,##__VA_ARGS__] UTF8String]);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor AxcTool_orangeColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"====== MD5转换 =======");
    NSString *AxcLogoString = @"AxcLogoString";
    NSLog(@"原字符串：%@",AxcLogoString);
    NSLog(@"MD5散列后：%@",AxcLogoString.AxcTool_get_MD5_Str);
    
    NSLog(@"====== Data-String转换 =======");
    NSData *strData = [NSData AxcTool_dataWithString:AxcLogoString];
    NSLog(@"Data：%@",strData);
    NSLog(@"String：%@",[NSString AxcTool_stringWithData:strData]);

    NSLog(@"====== Data-Dictionary转换 =======");
    NSData *dicData = [NSData AxcTool_dataWithObj:@{@"test_key":@"test_Value"}];
    NSLog(@"Data：%@",dicData);
    NSLog(@"Dictionary：%@",[NSDictionary AxcTool_dicWithData:dicData]);
    
    NSLog(@"====== Data-Array转换 =======");
    NSData *arrData = [NSData AxcTool_dataWithObj:@[@"1",@(2),@"3.0",@(4.1)]];
    NSLog(@"Data：%@",arrData);
    NSLog(@"Array：%@",[NSArray AxcTool_arrayWithData:arrData]);
    
    NSLog(@"====== 字符的正则表达 =======");
    NSLog(@"%@",@"13023335002".AxcTool_isPhoneNum ? @"符合手机号格式" : @"不符合手机号格式");
    NSLog(@"%@",@"123".AxcTool_isNumText ? @"符合数字格式" : @"不符合数字格式");
    NSLog(@"%@",@"12.2".AxcTool_isIntegerNumber ? @"符合整数格式" : @"不符合整数格式");
    NSLog(@"%@",@"https://www.baidu.com/".AxcTool_isURL ? @"符合URL格式" : @"不符合URL格式");
    NSLog(@"%@",@"axclogo@163.com".AxcTool_isEmail ? @"符合邮箱格式" : @"不符合邮箱格式");
    NSLog(@"%@",@"摘下耳机是种罪".AxcTool_isUserName ? @"符合用户名格式" : @"不符合用户名格式");
    NSLog(@"%@",@"AXCLOGO233333".AxcTool_isPassword ? @"符合密码格式" : @"不符合密码格式");
    NSLog(@"%@",@"674801199412031899".AxcTool_isIdCardNumber ? @"符合身份证号格式" : @"不符合身份证号格式");
    NSLog(@"%@",@"1231asd".AxcTool_isBankNumber ? @"符合银行卡号格式" : @"不符合银行卡号格式");
    NSLog(@"%@",@"浙B-13000".AxcTool_IsCarNumber ? @"符合车牌号格式" : @"不符合车牌号格式");
    NSLog(@"%@",@"00-01-6C-06-A6-29".AxcTool_isMacAddress ? @"符合Mac地址格式" : @"不符合Mac地址格式");
    NSLog(@"%@",@"哈".AxcTool_isValidChinese ? @"有效中文字符" : @"无效中文字符");
    NSLog(@"%@",@"30001".AxcTool_isValidPostalcode ? @"符合邮政编码格式" : @"不符合邮政编码格式");
    NSLog(@"%@",@"198.164.128.1".AxcTool_isIPAddress ? @"符合IP地址格式" : @"不符合IP地址格式");
    NSLog(@"%@",@"哈哈哈哈哈".AxcTool_isNumAndString ? @"符合仅有数字和字母格式" : @"不符合仅有数字和字母格式");

}



@end
