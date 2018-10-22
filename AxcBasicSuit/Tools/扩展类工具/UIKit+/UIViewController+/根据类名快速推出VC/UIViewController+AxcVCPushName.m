//
//  UIViewController+AxcVCPushName.m
//  Axc_Practice
//
//  Created by AxcLogo on 2018/10/22.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "UIViewController+AxcVCPushName.h"

@implementation UIViewController (AxcVCPushName)

- (void)AxcTool_pushVCName:(NSString *)name{
    [self AxcTool_pushVCName:name hiddenTabbar:YES];
}
- (void)AxcTool_pushVCName:(NSString *)name hiddenTabbar:(BOOL )hiddenTabbar{
    [self AxcTool_pushVCName:name hiddenTabbar:hiddenTabbar animated:YES];
}
- (void)AxcTool_pushVCName:(NSString *)name hiddenTabbar:(BOOL )hiddenTabbar animated:(BOOL )animated{
    UIViewController *vc = [self nameGetVC:name];
    vc.hidesBottomBarWhenPushed = hiddenTabbar;
    [self.navigationController pushViewController:vc animated:animated];
}

- (void)AxcTool_pressentVCName:(NSString *)name{
    [self AxcTool_pressentVCName:name animated:YES];
}
- (void)AxcTool_pressentVCName:(NSString *)name animated:(BOOL )animated{
    UIViewController *vc = [self nameGetVC:name];
    [self presentViewController:vc animated:animated completion:nil];
}

- (UIViewController *)nameGetVC:(NSString *)name{
    Class class = NSClassFromString(name);
    UIViewController *vc = [[class alloc] init];
    return vc;
}

@end
