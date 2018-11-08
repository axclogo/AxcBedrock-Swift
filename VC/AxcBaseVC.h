//
//  AxcBaseVC.h
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/26.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AxcBasicSuitPrefixHeader.h"    // 可以全局引用的头文件

/** AxcVC基类 */
@interface AxcBaseVC : UIViewController
<   // 预设协议实现
UITableViewDelegate,UITableViewDataSource,
UICollectionViewDelegate,UICollectionViewDataSource

>
//***************** 常用对象 *****************
/** TableView (无懒加载) */
@property(nonatomic , strong)UITableView *tableView;
/** collectionView (无懒加载) */
@property(nonatomic , strong)UICollectionView *collectionView;
/** 列表数据集合 */
@property(nonatomic , strong)NSMutableArray *dataListArray;
/** 是否使用自定义底部视图，默认NO */
@property(nonatomic , assign)BOOL useCustomToolBarView;
/** 自定义底部视图，与tabbar高度一致 */
@property(nonatomic , strong)UIView *axcCustomToolBarView;

//***************** 常用界面参数 *****************
/** tabbar高度 */
@property(nonatomic, assign)CGFloat axcTabBarHeight;
/** navbar高度 */
@property(nonatomic, assign)CGFloat axcNavBarHeight;
/** statusbar高度 */
@property(nonatomic, assign)CGFloat axcStatusBarHeight;
/** 上部Bar所有高度 */
@property(nonatomic, assign)CGFloat axcTopBarAllHeight;

/** 设置Bar字体属性 */
@property(nonatomic, strong)NSDictionary *axcNavBarTextAttributes;
/** 设置Bar字体颜色 */
@property(nonatomic, strong)UIColor *axcNavBarTextColor;
/** 设置Bar字体Font */
@property(nonatomic, strong)UIFont *axcNavBarTextFont;

//***************** 默认界面参数 *****************
/** 默认主题色 */
@property(nonatomic , strong)UIColor *themeColor;
/** 默认字号 */
@property(nonatomic , strong)UIFont *defaultFont;

//***************** 常用函数 *****************
/** 快速设置TableView */
- (void )AxcBase_settingTableType:(UITableViewStyle )tableType
                          nibName:(NSString *)nibName
                           cellID:(NSString *)cellID;
/** 快速设置collectionView */
- (void)AxcBase_settingCollectionLayout:(UICollectionViewLayout* )flowLayout
                                nibName:(NSString *)nibName
                                 cellID:(NSString *)cellID;


//***************** 子类补充&预留函数区 *****************
/** ViewDidLoad之后会执行创建UI的函数 */
- (void)createUI;
/** ViewDidLoad之后会执行数据请求的函数 */
- (void)requestData;

@end

/*=-=-=-=-=-=-=-=-=-=-=-=-=-= 函数分层-分割线 =-=-=-=-=-=-=-=-=-=-=-=-=-=*/

#pragma mark - 类扩展函数分层: 快速设置BarBtnItem的扩展

typedef NS_ENUM(NSInteger, AxcBaseBarButtonItemBearing) {
    /** 导航条右边 */
    AxcBaseBarButtonItemLocationRight, // 默认
    /** 导航条左边 */
    AxcBaseBarButtonItemLocationLeft
};

@interface AxcBase_BarItemBtnModel :NSObject
/**
 快速实例化
 @param title 标题
 @param imgName 图片名
 */
- (instancetype)initWithTitle:(NSString *)title imgName:(NSString *)imgName;
/** 标题文字 */
@property(nonatomic , copy)NSString *title;
/** 图片 */
@property(nonatomic , copy)NSString *image;

@end

@interface AxcBaseVC (AxcBaseVC_BarButtonItemEx)

/**
 右按钮触发回调函数
 @param sender 按钮
 */
- (void )AxcBase_clickRightBarItemBtn:(UIButton *)sender;

/**
 左按钮触发回调函数
 @param sender 按钮
 */
- (void )AxcBase_clickLeftBarItemBtn:(UIButton *)sender;

/**
 获取BarBtnItem的Tag值
 @param sender 传入这个按钮对象
 @return Tag值
 */
- (NSInteger )getBarBtnItemTag:(UIButton *)sender;


/**
 获取BarBtnItem的所在方位
 @param sender 传入这个按钮对象
 @return 所在方位
 */
- (AxcBaseBarButtonItemBearing )getBarBtnItemBearing:(UIButton *)sender;


//////////////////////////// 添加/设置函数区：

/**
 文字 个 - 按钮在导航栏上，触发函数
 @param bearing 方位左右
 @param title 标题
 */
- (UIButton *)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                 title:(NSString *)title;
/**
 图片 个 - 按钮在导航栏上，触发函数
 @param bearing 方位左右
 @param image 图片
 */
- (UIButton *)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                 image:(NSString *)image;
/**
 文字 个 - 按钮在导航栏上，触发Block
 @param bearing 方位左右
 @param title 标题
 */
- (UIButton *)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                 title:(NSString *)title
                               handler:(AxcBasicSuitBarBtnItemBlock )handler;
/**
 图片 个 - 按钮在导航栏上，触发Block
 @param bearing 方位左右
 @param image 图片
 */
- (UIButton *)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                 image:(NSString *)image
                               handler:(AxcBasicSuitBarBtnItemBlock )handler;
/**
 文字 组 - 按钮在导航栏上，触发函数
 @param bearing 方位左右
 @param titles 图片
 */
- (NSArray <UIButton *>*)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                           titles:(NSArray <NSString *>*)titles;
/**
 图片 组 - 按钮在导航栏上，触发函数
 @param bearing 方位左右
 @param images 图片
 */
- (NSArray <UIButton *>*)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                           images:(NSArray <NSString *>*)images;
/**
 文字 组 - 按钮在导航栏上，触发Block
 @param bearing 方位左右
 @param titles 文字
 @param handler 触发回调Block区分方法使用Btn的axcStringTag
 */
- (NSArray <UIButton *>*)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                           titles:(NSArray <NSString *>*)titles
                                          handler:(AxcBasicSuitBarBtnItemBlock )handler;
/**
 图片 组 - 按钮在导航栏上，触发Block
 @param bearing 方位左右
 @param images 图片
 @param handler 触发回调Block区分方法使用Btn的axcStringTag
 */
- (NSArray <UIButton *>*)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                           images:(NSArray <NSString *>*)images
                                          handler:(AxcBasicSuitBarBtnItemBlock )handler;
/**
 图 文 组 - 按钮在导航栏上，触发函数
 @param bearing 方位左右
 @param imageTitles 图片名和标题
 @return 一组设置好的按钮
 */
- (NSArray <UIButton *>*)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                 imgNameAndTitles:(NSArray <AxcBase_BarItemBtnModel *>*)imageTitles;
/**
 图 文 组 - 按钮在导航栏上，触发Block
 @param bearing 方位左右
 @param imageTitles 图片名和标题
 @param handler 触发Block回调
 @return 一组设置好的按钮
 */
- (NSArray <UIButton *>*)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                 imgNameAndTitles:(NSArray <AxcBase_BarItemBtnModel *>*)imageTitles
                                          handler:(AxcBasicSuitBarBtnItemBlock )handler;
/**
 快速创建一个Btn
 @param image 图片 爱填不填
 @param title 文字 爱填不填
 @param font 字号
 @param action 触发
 @return 按钮
 */
- (UIButton *)AxcBase_createButtonWithImage:(UIImage *)image
                                      title:(NSString *)title
                                       font:(UIFont *)font
                                     action:(SEL )action;

// 回调Block指针
@property(nonatomic , copy)AxcBasicSuitBarBtnItemBlock rightBarItemBlock;
@property(nonatomic , copy)AxcBasicSuitBarBtnItemBlock leftBarItemBlock;

@end

#pragma mark - 类扩展函数分层: 快速弹出指示框扩展

@interface AxcBaseVC (AxcBaseVC_PopAlentEx)
//***************** 基础快速Alent函数 *****************
/**
 Alent - 弹出一个警示框
 @param title 标题
 @param msg 内容
 @param handler 触发Block区别方法是：action.axcIntTag
 */
- (void)AxcBase_popWarningAlentWithTitle:(NSString *)title
                                     msg:(NSString *)msg
                                 handler:(void (^)(UIAlertAction *action))handler;
/**
 Sheet - 弹出一个警示框
 @param title 标题
 @param msg 内容
 @param handler 触发Block区别方法是：action.axcIntTag
 */
- (void)AxcBase_popWarningAlentSheetWithTitle:(NSString *)title
                                          msg:(NSString *)msg
                                      handler:(void (^)(UIAlertAction *action))handler;
/**
 Alent - 弹出一个警示框
 @param msg 内容
 @param handler 触发Block区别方法是：action.axcIntTag
 */
- (void)AxcBase_popWarningAlentWithMsg:(NSString *)msg
                               handler:(void (^)(UIAlertAction *action))handler;
/**
 Sheet - 弹出一个警示框
 @param msg 内容
 @param handler 触发Block区别方法是：action.axcIntTag
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

