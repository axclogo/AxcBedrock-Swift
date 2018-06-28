//
//  AxcBaseVC.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/26.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcBaseVC.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@interface AxcBaseVC ()
@end

@implementation AxcBaseVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingInitialize];
    [self createUI];
    [self requestData];
}
#pragma mark - 父类初始化
- (void)settingInitialize{
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone; // 防止视图下移
    self.navigationController.navigationBar.translucent = NO;  // 不透明
}
#pragma mark - 子类实现
- (void)createUI{}
- (void)requestData{}

#pragma mark - 子类使用
/** 快速设置TableView */
- (void)AxcBase_settingTableType:(UITableViewStyle)tableType
                         nibName:(NSString *)nibName
                          cellID:(NSString *)cellID{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:tableType];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    if (nibName.length) {
        [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil]
             forCellReuseIdentifier:cellID];
    }
}


#pragma mark - 代理协议预实现区
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UITableViewCell new];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AxcLS(AxcBasicSuitDeleteText);
}
#pragma mark - 懒加载区
/***************** 常用对象 *****************/
- (NSMutableArray *)dataListArray{
    if (!_dataListArray) _dataListArray = @[].mutableCopy;
    return _dataListArray;
}

/***************** 常用界面参数 *****************/
- (CGFloat)axcTabBarHeight{
    if (!_axcTabBarHeight) _axcTabBarHeight = [self.tabBarController.tabBar frame].size.height;
    return _axcTabBarHeight;
}
- (CGFloat )axcNavBarHeight{
    if (!_axcNavBarHeight) _axcNavBarHeight = [self.navigationController.navigationBar frame].size.height;
    return _axcNavBarHeight;
}
- (CGFloat )axcStatusBarHeight{
    if (!_axcStatusBarHeight) _axcStatusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    return _axcStatusBarHeight;
}
- (CGFloat )axcTopBarAllHeight{
    if (!_axcTopBarAllHeight) _axcTopBarAllHeight = self.axcStatusBarHeight + self.axcNavBarHeight;
    return _axcTopBarAllHeight;
}

@end


/*=-=-=-=-=-=-=-=-=-=-=-=-=-= 函数分层-分割线 =-=-=-=-=-=-=-=-=-=-=-=-=-=*/
#pragma mark - 类扩展函数分层: 快速弹出指示框扩展实现

@implementation AxcBaseVC (AxcBaseVC_PopAlentEx)
/** 弹出一个警示框 - Alent */
- (void)AxcBase_popWarningAlentWithMsg:(NSString *)msg
                               handler:(void (^)(UIAlertAction *action))handler{
    [self AxcBase_popAlentWithTitle:AxcLS(AxcBasicSuitWarningText)
                                msg:msg
                  alertActionTitles:@[AxcLS(AxcBasicSuitDetermineText)]
                  cancelActionTitle:nil handler:handler];
}
/** 弹出一个警示框 - Sheet */
- (void)AxcBase_popWarningAlentSheetWithMsg:(NSString *)msg
                                    handler:(void (^)(UIAlertAction *action))handler{
    [self AxcBase_popAlentSheetWithTitle:AxcLS(AxcBasicSuitWarningText)
                                     msg:msg
                       alertActionTitles:@[AxcLS(AxcBasicSuitDetermineText)]
                       cancelActionTitle:nil handler:handler];
}
/** 弹出一个提示框 - Alent */
- (void)AxcBase_popPromptAlentWithMsg:(NSString *)msg
                              handler:(void (^)(UIAlertAction *action))handler{
    [self AxcBase_popAlentWithTitle:AxcLS(AxcBasicSuitPromptText)
                                msg:msg
                  alertActionTitles:@[AxcLS(AxcBasicSuitDetermineText)]
                  cancelActionTitle:AxcLS(AxcBasicSuitCancelText) handler:handler];
}
/** 弹出一个提示框 - Sheet */
- (void)AxcBase_popPromptAlentSheetWithMsg:(NSString *)msg
                                   handler:(void (^)(UIAlertAction *action))handler{
    [self AxcBase_popAlentSheetWithTitle:AxcLS(AxcBasicSuitPromptText)
                                     msg:msg
                       alertActionTitles:@[AxcLS(AxcBasicSuitDetermineText)]
                       cancelActionTitle:AxcLS(AxcBasicSuitCancelText) handler:handler];
}

/** 快速弹框 - Alent */
- (void)AxcBase_popAlentWithTitle:(NSString *)title
                              msg:(NSString *)msg
                alertActionTitles:(NSArray <NSString *>*)alertActionTitles
                cancelActionTitle:(NSString *)cancelActionTitle
                          handler:(void (^)(UIAlertAction *action))handler{
    [self AxcBase_popAlentWithTitle:title
                                msg:msg
                  alertActionTitles:alertActionTitles
                  cancelActionTitle:cancelActionTitle
                              style:UIAlertControllerStyleAlert
                            handler:handler];
}

/** 快速弹出多选一Sheet */
- (void)AxcBase_popAlentSheetWithTitle:(NSString *)title
                                   msg:(NSString *)msg
                     alertActionTitles:(NSArray <NSString *>*)alertActionTitles
                     cancelActionTitle:(NSString *)cancelActionTitle
                               handler:(void (^)(UIAlertAction *action))handler{
    [self AxcBase_popAlentWithTitle:title
                                msg:msg
                  alertActionTitles:alertActionTitles
                  cancelActionTitle:cancelActionTitle
                              style:UIAlertControllerStyleActionSheet
                            handler:handler];
}

/** 快速弹框-模式Sheet/Alent */
- (void)AxcBase_popAlentWithTitle:(NSString *)title
                              msg:(NSString *)msg
                alertActionTitles:(NSArray <NSString *>*)alertActionTitles
                cancelActionTitle:(NSString *)cancelActionTitle
                            style:(UIAlertControllerStyle )style
                          handler:(void (^)(UIAlertAction *action))handler{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alertActionTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction* action = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault
                                                       handler:handler];
        action.axcIntTag = idx;
        [alert addAction:action];
    }];
    if (cancelActionTitle.length) {
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:cancelActionTitle style:UIAlertActionStyleCancel
                                                             handler:handler];
        cancelAction.axcIntTag = alertActionTitles.count;
        [alert addAction:cancelAction];
    }
    [self presentViewController:alert animated:YES completion:nil];
}
@end


#pragma clang diagnostic pop
