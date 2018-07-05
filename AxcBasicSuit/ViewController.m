//
//  ViewController.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/26.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "ViewController.h"
#import "AxcBasicSuitPrefixHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor AxcTool_orangeColor];
    
    NSData *data = [NSData AxcTool_dataWithObj:@{@"123":@"45345"} options:NSJSONWritingPrettyPrinted error:nil];

    [AxcDataCache AxcTool_cacheSaveWithData:data saveKey:@"axclogo" ];
    
    NSData *data2 = [AxcDataCache AxcTool_cacheGetDataWithSaveKey:@"axclogoa" ];
    
    NSLog(@"%@",[AxcDataCache AxcTool_getCachePath]);

    NSLog(@"%@",[NSDictionary AxcTool_dicWithData:data2] );
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [AxcTouchManager AxcTool_TouchManagerWithMessage:@"123" fallbackTitle:@"asdasd" verifyBlock:^(BOOL success, AxcTouchManagerVerifyStatus status) {
//        NSLog(@"%ld",status);
//    }];
    
//    NSLog(@"%@",[[NSDate date] AxcTool_dateWithFomant:@"yyyy-MM-dd'T'HH:mm:ss"]);
//    NSLog(@"%ld",[NSDate date].years);
//    NSLog(@"%ld",[NSDate date].month);
//    NSLog(@"%ld",[NSDate date].day);
//    NSLog(@"%ld",[NSDate date].hours);
//    NSLog(@"%ld",[NSDate date].minutes);
//    NSLog(@"%ld",[NSDate date].seconds);
//    NSString *string = @"2018-7-4 09:33:22";
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *date = [format dateFromString:string];
//
//
//    NSLog(@"%d",[[NSDate date] AxcTool_compareDaysWithDate:date]);
    
    NSLog(@"%@",@"/Users/Axc/Desktop/tools-master.zip".AxcTool_get_MD5_Str);
    NSLog(@"%@",@"/Users/Axc/Desktop/tools-master.zips".AxcTool_getFile_MD5_Str);
}



@end
