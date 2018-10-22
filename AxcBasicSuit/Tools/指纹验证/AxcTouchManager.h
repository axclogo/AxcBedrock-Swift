//
//  AxcTouchManager.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <LocalAuthentication/LocalAuthentication.h>

#import "AxcBasicSuitBlockDefine.h"

/** TouchID 验证状态 */
typedef NS_ENUM(NSInteger, AxcTouchManagerVerifyStatus) {
    /** TouchID验证成功 */
    AxcTouchManagerVerifyStatusSuccess,
    /** TouchID验证失败 */
    AxcTouchManagerVerifyStatusFailure,
    /** 取消TouchID验证 (用户点击了取消) */
    AxcTouchManagerVerifyStatusErrorUserCancel,
    /** 在TouchID对话框中点击输入密码按钮，可以自定义标题 */
    AxcTouchManagerVerifyStatusErrorUserFallback,
    /** 在验证的TouchID的过程中被系统取消 例如突然来电话、按了Home键、锁屏... */
    AxcTouchManagerVerifyStatusErrorSystemCancel,
    /** 设备没有录入TouchID,无法启用TouchID */
    AxcTouchManagerVerifyStatusErrorNotEnrolled,
    /** 无法启用TouchID,设备没有设置密码 */
    AxcTouchManagerVerifyStatusErrorPasscodeNotSet,
    /** 该设备的TouchID无效 */
    AxcTouchManagerVerifyStatusErrorNotAvailable,
    /** 多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁 */
    AxcTouchManagerVerifyStatusErrorLockout,
    /** 当前软件被挂起取消了授权(如突然来了电话,应用进入前台) */
    AxcTouchManagerVerifyStatusErrorAppCancel,
    /** 当前软件被挂起取消了授权 (授权过程中,LAContext对象被释) */
    AxcTouchManagerVerifyStatusErrorInvalidContext,
    /** 当前设备不支持指纹识别 */
    AxcTouchManagerVerifyStatusErrorNotSupport
};
/**
 TouchID验证Block
 @param success 是否成功
 @param status 当前验证状态
 */
typedef void (^AxcTouchManagerVerifyBlock )(BOOL success, AxcTouchManagerVerifyStatus status);



@interface AxcTouchManager : NSObject

/**
 发起TouchID认证
 @param verifyBlock 回调状态
 */
+ (void)AxcTool_TouchManagerWithVerifyBlock:(AxcTouchManagerVerifyBlock )verifyBlock;

/**
 发起TouchID认证
 @param message 提示消息，如“验证TouchID进行支付”
 @param verifyBlock 回调状态
 */
+ (void)AxcTool_TouchManagerWithMessage:(NSString *)message
                            verifyBlock:(AxcTouchManagerVerifyBlock )verifyBlock;

/**
 发起TouchID认证
 @param message 提示消息，如“验证TouchID进行支付”
 @param fallbackTitle 当验证失败一次后，新出现按钮的提示语，如“输入密码”
 @param verifyBlock 回调状态
 */
+ (void)AxcTool_TouchManagerWithMessage:(NSString *)message
                          fallbackTitle:(NSString *)fallbackTitle
                            verifyBlock:(AxcTouchManagerVerifyBlock )verifyBlock;



@end

