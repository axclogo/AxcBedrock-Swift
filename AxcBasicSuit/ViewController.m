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
    [AxcTouchManager AxcTool_TouchManagerWithMessage:@"123" fallbackTitle:@"asdasd" verifyBlock:^(BOOL success, AxcTouchManagerVerifyStatus status) {
        NSLog(@"%ld",status);
    }];
}



@end
