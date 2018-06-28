//
//  AxcBaseVC.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/26.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AxcBasicSuitDefine.h"          // 快速宏定义
#import "AxcLanguageManagement.h"       // 语言管理对象
#import "AxcBasicSuitPrefixHeader.h"    // 可以全局引用的头文件
#import "NSObject+AxcBasicSuitObjectEx.h"


/** AxcVC基类 */
@interface AxcBaseVC : UIViewController
<   // 预设协议实现
UITableViewDelegate
,UITableViewDataSource

>
//***************** 常用对象 *****************
/** TableView (无懒加载) */
@property(nonatomic , strong)UITableView *tableView;
/** collectionView (无懒加载) */
@property(nonatomic , strong)UICollectionView *collectionView;
/** 列表数据集合 */
@property(nonatomic , strong)NSMutableArray *dataListArray;

//***************** 常用界面参数 *****************
/** tabbar高度 */
@property(nonatomic, assign)CGFloat axcTabBarHeight;
/** navbar高度 */
@property(nonatomic, assign)CGFloat axcNavBarHeight;
/** statusbar高度 */
@property(nonatomic, assign)CGFloat axcStatusBarHeight;
/** 上部Bar所有高度 */
@property(nonatomic, assign)CGFloat axcTopBarAllHeight;

//***************** 常用函数 *****************
/** 快速设置TableView */
- (void )AxcBase_settingTableType:(UITableViewStyle )tableType
                          nibName:(NSString *)nibName
                           cellID:(NSString *)cellID;



//***************** 子类补充&预留函数区 *****************
/** ViewDidLoad之后会执行创建UI的函数 */
- (void)createUI;
/** ViewDidLoad之后会执行数据请求的函数 */
- (void)requestData;

@end




#pragma mark - 类扩展函数分层: 快速弹出指示框扩展
@interface AxcBaseVC (AxcBaseVC_PopAlentEx)
//***************** 基础快速Alent函数 *****************
/**
 Alent - 弹出一个警示框
 @param msg 内容
 @param handler 触发Block
 */
- (void)AxcBase_popWarningAlentWithMsg:(NSString *)msg
                               handler:(void (^)(UIAlertAction *action))handler;
/**
 Sheet - 弹出一个警示框
 @param msg 内容
 @param handler 触发Block
 */
- (void)AxcBase_popWarningAlentSheetWithMsg:(NSString *)msg
                                    handler:(void (^)(UIAlertAction *action))handler;
/**
 Alent - 弹出一个提示框
 @param msg 内容
 @param handler 触发Block区别方法是：action.axcIntTag
 */
- (void)AxcBase_popPromptAlentWithMsg:(NSString *)msg
                              handler:(void (^)(UIAlertAction *action))handler;
/**
 Sheet - 弹出一个提示框
 @param msg 内容
 @param handler 触发Block区别方法是：action.axcIntTag
 */
- (void)AxcBase_popPromptAlentSheetWithMsg:(NSString *)msg
                                   handler:(void (^)(UIAlertAction *action))handler;
/**
 Alent - 快速弹框
 @param title 标题
 @param msg 内容
 @param alertActionTitles 按钮标题
 @param cancelActionTitle 取消按钮标题（可为空，空即没有取消按钮）
 @param handler 触发Block区别方法是：action.axcIntTag
 */
- (void)AxcBase_popAlentWithTitle:(NSString *)title
                              msg:(NSString *)msg
                alertActionTitles:(NSArray <NSString *>*)alertActionTitles
                cancelActionTitle:(NSString *)cancelActionTitle
                          handler:(void (^)(UIAlertAction *action))handler;
/**
 Sheet - 快速弹出多选一
 @param title 标题
 @param msg 内容
 @param alertActionTitles 按钮标题
 @param cancelActionTitle 取消按钮标题（可为空，空即没有取消按钮）
 @param handler 触发Block区别方法是：action.axcIntTag
 */
- (void)AxcBase_popAlentSheetWithTitle:(NSString *)title
                                   msg:(NSString *)msg
                     alertActionTitles:(NSArray <NSString *>*)alertActionTitles
                     cancelActionTitle:(NSString *)cancelActionTitle
                               handler:(void (^)(UIAlertAction *action))handler;

/**
 Sheet/Alent - 快速弹框: 模式
 @param title 标题
 @param msg 内容
 @param alertActionTitles 按钮标题
 @param cancelActionTitle 取消按钮标题（可为空，空即没有取消按钮）
 @param style 弹出模式
 @param handler 触发Block区别方法是：action.axcIntTag
 */
- (void)AxcBase_popAlentWithTitle:(NSString *)title
                              msg:(NSString *)msg
                alertActionTitles:(NSArray <NSString *>*)alertActionTitles
                cancelActionTitle:(NSString *)cancelActionTitle
                            style:(UIAlertControllerStyle )style
                          handler:(void (^)(UIAlertAction *action))handler;
@end

