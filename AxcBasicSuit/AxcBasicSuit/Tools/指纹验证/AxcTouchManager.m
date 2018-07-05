//
//  AxcTouchManager.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcTouchManager.h"

#import "AxcBasicSuitDefine.h"

// 兼容需要，消除警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

@implementation AxcTouchManager

+ (id )sharedManager{
    static id instance;
    kDISPATCH_ONCE_BLOCK(^{
        instance = [self new];
    })
    return instance;
}

+ (void)AxcTool_TouchManagerWithMessage:(NSString *)message
                            verifyBlock:(AxcTouchManagerVerifyBlock )verifyBlock{
    [self AxcTool_TouchManagerWithMessage:message fallbackTitle:nil verifyBlock:verifyBlock];
}

+ (void)AxcTool_TouchManagerWithVerifyBlock:(AxcTouchManagerVerifyBlock )verifyBlock{
    [self AxcTool_TouchManagerWithMessage:nil fallbackTitle:nil verifyBlock:verifyBlock];
}

+ (void)AxcTool_TouchManagerWithMessage:(NSString *)message
                          fallbackTitle:(NSString *)fallbackTitle
                                  verifyBlock:(AxcTouchManagerVerifyBlock )verifyBlock{
    LAContext *context = [[LAContext alloc]init];
    context.localizedFallbackTitle = fallbackTitle.length ? fallbackTitle : AxcInputPasswordText ;
    message = message.length ? message : AxcAuthenticationText ;
    // 检测是否支持指纹识别
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:message reply:^(BOOL success, NSError * _Nullable error) {
                    AxcTouchManagerVerifyStatus status = AxcTouchManagerVerifyStatusSuccess;
                    if (!success && error) {
                        switch (error.code) {
                            case LAErrorAuthenticationFailed:{
                                status = AxcTouchManagerVerifyStatusFailure;
                            }break;
                            case LAErrorUserCancel: {
                                status = AxcTouchManagerVerifyStatusErrorUserCancel;
                            }break;
                            case LAErrorUserFallback: {
                                status = AxcTouchManagerVerifyStatusErrorUserFallback;
                            }break;
                            case LAErrorSystemCancel:{
                                status = AxcTouchManagerVerifyStatusErrorSystemCancel;
                            }break;
                            case LAErrorTouchIDNotEnrolled:{
                                status = AxcTouchManagerVerifyStatusErrorNotEnrolled;
                            }break;
                            case LAErrorPasscodeNotSet: {
                                status = AxcTouchManagerVerifyStatusErrorPasscodeNotSet;
                            }break;
                            case LAErrorTouchIDNotAvailable: {
                                status = AxcTouchManagerVerifyStatusErrorNotAvailable;
                            }break;
                            case LAErrorTouchIDLockout: {
                                status = AxcTouchManagerVerifyStatusErrorLockout;
                            }break;
                            case LAErrorAppCancel:{
                                status = AxcTouchManagerVerifyStatusErrorAppCancel;
                            }break;
                            case LAErrorInvalidContext: {
                                status = AxcTouchManagerVerifyStatusErrorInvalidContext;
                            }break;
                        }
                    }
                    verifyBlock(success,status);
                }];
    }else{
        verifyBlock(NO,AxcTouchManagerVerifyStatusErrorNotSupport);
    }
}

@end

#pragma clang diagnostic pop
