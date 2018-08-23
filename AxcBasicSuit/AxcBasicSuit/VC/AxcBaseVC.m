//
//  AxcBaseVC.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/26.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcBaseVC.h"
#import <objc/runtime.h>

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

#pragma mark - 父类重写
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if (self.useCustomToolBarView) [self AxcBase_layoutCustomToolBar];
}
#pragma mark - 父类初始化
- (void)settingInitialize{
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone; // 防止视图下移
    self.navigationController.navigationBar.translucent = NO;  // 不透明
    // 自定义属性
    self.themeColor = [UIColor AxcTool_carrotColor];
    self.defaultFont = [UIFont systemFontOfSize:12];
    self.useCustomToolBarView = NO;
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
        [self.tableView registerNib:[UINib nibWithNibName:nibName
                                                   bundle:nil]
             forCellReuseIdentifier:cellID.length? cellID : kAxcBasicSuitMark_ID];
    }else{
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kAxcBasicSuitMark_ID];
    }
}
/** 快速设置collectionView */
- (void)AxcBase_settingCollectionLayout:(UICollectionViewLayout* )flowLayout
                                nibName:(NSString *)nibName
                                 cellID:(NSString *)cellID{
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    if (nibName.length) {
        [self.collectionView registerNib:[UINib nibWithNibName:nibName
                                                        bundle:nil]
              forCellWithReuseIdentifier:cellID.length? cellID : kAxcBasicSuitMark_ID];
    }else{
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kAxcBasicSuitMark_ID];
    }
}
/** 设置自定义临时Bar的布局 */
- (void)AxcBase_layoutCustomToolBar{
    self.axcCustomToolBarView.frame = CGRectMake(0, self.view.axcTool_height - self.axcTabBarHeight,
                                                 self.view.axcTool_width, self.axcTabBarHeight);
}

#pragma mark - 代理协议预实现区
// MARK:TableView代理数据源
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAxcBasicSuitMark_ID];
    cell.backgroundColor = [UIColor AxcTool_arcPresetColor];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AxcLS(AxcBasicSuitDeleteText);
}
// MARK:CollectionView代理数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataListArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAxcBasicSuitMark_ID
                                                                           forIndexPath:indexPath];
    cell.backgroundColor = [UIColor AxcTool_arcPresetColor];
    return cell;
}
#pragma mark - 懒加载区
/***************** 常用对象 *****************/
- (UIView *)axcCustomToolBarView{
    if (!_axcCustomToolBarView){
        _axcCustomToolBarView = [UIView new];
        _axcCustomToolBarView.backgroundColor = [UIColor whiteColor];
    }
    return _axcCustomToolBarView;
}
- (NSMutableArray *)dataListArray{
    if (!_dataListArray) _dataListArray = @[].mutableCopy;
    return _dataListArray;
}

/***************** 常用界面参数 *****************/
- (CGFloat)axcTabBarHeight{
    if (!_axcTabBarHeight) {
        CGFloat systemTabBarHeight = [self.tabBarController.tabBar frame].size.height;
        _axcTabBarHeight = systemTabBarHeight ? systemTabBarHeight : AxcGetTabBarHeight ;
    }
    return _axcTabBarHeight;
}
- (CGFloat )axcNavBarHeight{
    if (!_axcNavBarHeight){
        CGFloat systemNavBarHeight = [self.navigationController.navigationBar frame].size.height;
        _axcNavBarHeight = systemNavBarHeight ? systemNavBarHeight : AxcGetNavBarHeight ;
    }
    return _axcNavBarHeight;
}
- (CGFloat )axcStatusBarHeight{
    if (!_axcStatusBarHeight){
        CGFloat systemStatusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;;
        _axcStatusBarHeight = systemStatusBarHeight ? systemStatusBarHeight : AxcGetStatusBarHeight ;
    }
    return _axcStatusBarHeight;
}
- (CGFloat )axcTopBarAllHeight{
    if (!_axcTopBarAllHeight) _axcTopBarAllHeight = self.axcStatusBarHeight + self.axcNavBarHeight;
    return _axcTopBarAllHeight;
}
// 设置Bar字体属性
- (void)setAxcNavBarTextAttributes:(NSDictionary *)axcNavBarTextAttributes{
    self.navigationController.navigationBar.titleTextAttributes = axcNavBarTextAttributes;
}
- (NSDictionary *)axcNavBarTextAttributes{
    return self.navigationController.navigationBar.titleTextAttributes;
}
// 设置Bar字体颜色
- (void)setAxcNavBarTextColor:(UIColor *)axcNavBarTextColor{
    [self setAxcNavBarTextAttributes:@{NSForegroundColorAttributeName: axcNavBarTextColor}];
}
- (UIColor *)axcNavBarTextColor{
    return self.axcNavBarTextAttributes[NSForegroundColorAttributeName];
}
// 设置Bar字体Font
- (void)setAxcNavBarTextFont:(UIFont *)axcNavBarTextFont{
    [self setAxcNavBarTextAttributes:@{NSFontAttributeName: axcNavBarTextFont}];
}
- (UIFont *)axcNavBarTextFont{
    return self.axcNavBarTextAttributes[NSFontAttributeName];
}
// 是否使用底部自定义TabBar
- (void)setUseCustomToolBarView:(BOOL)useCustomTabBarView{
    _useCustomToolBarView = useCustomTabBarView;
    if (_useCustomToolBarView) {
        [self.view addSubview: self.axcCustomToolBarView];
        [self AxcBase_layoutCustomToolBar];
        [self.view bringSubviewToFront:self.axcCustomToolBarView];
    }else{
        if (_axcCustomToolBarView) {
            [_axcCustomToolBarView removeFromSuperview];
            _axcCustomToolBarView = nil;
        } // 节约操作
    }
}

@end


/*=-=-=-=-=-=-=-=-=-=-=-=-=-= 函数分层-分割线 =-=-=-=-=-=-=-=-=-=-=-=-=-=*/



#pragma mark - 类扩展函数分层: 快速设置BarBtnItem扩展实现

static NSString * const krightBarItemBlock = @"rightBarItemBlock";
static NSString * const kleftBarItemBlock  = @"leftBarItemBlock";

#define AXCBASE_BARBTNITEM_TAG 100

@implementation AxcBaseVC (AxcBaseVC_BarButtonItemEx)

/**
 文字 个 - 按钮在导航栏上，触发函数
 @param bearing 方位左右
 @param title 标题
 */
- (UIButton *)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                 title:(NSString *)title{
    return [self AxcBase_addBarButtonItem:bearing titles:@[title] handler:nil].firstObject;
}

/**
 图片 个 - 按钮在导航栏上，触发函数
 @param bearing 方位左右
 @param image 图片
 */
- (UIButton *)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                 image:(NSString *)image{
    return [self AxcBase_addBarButtonItem:bearing images:@[image] handler:nil].firstObject;
}

/**
 文字 个 - 按钮在导航栏上，触发Block
 @param bearing 方位左右
 @param title 标题
 */
- (UIButton *)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                 title:(NSString *)title
                               handler:(AxcBasicSuitBarBtnItemBlock )handler{
    return [self AxcBase_addBarButtonItem:bearing titles:@[title] handler:handler].firstObject;
}

/**
 图片 个 - 按钮在导航栏上，触发Block
 @param bearing 方位左右
 @param image 图片
 */
- (UIButton *)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                 image:(NSString *)image
                               handler:(AxcBasicSuitBarBtnItemBlock )handler{
    return [self AxcBase_addBarButtonItem:bearing images:@[image] handler:handler].firstObject;
}

/**
 文字 组 - 按钮在导航栏上，触发函数
 @param bearing 方位左右
 @param titles 标题
 */
- (NSArray <UIButton *>*)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                           titles:(NSArray <NSString *>*)titles{
    return [self AxcBase_addBarButtonItem:bearing titles:titles handler:nil];
}

/**
 图片 组 - 按钮在导航栏上，触发函数
 @param bearing 方位左右
 @param images 图片
 */
- (NSArray <UIButton *>*)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                           images:(NSArray <NSString *>*)images{
    return [self AxcBase_addBarButtonItem:bearing images:images handler:nil];
}

/**
 文字 组 - 按钮在导航栏上，触发Block
 @param bearing 方位左右
 @param titles 文字
 @param handler 触发回调Block区分方法使用Btn的axcStringTag
 */
- (NSArray <UIButton *>*)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                           titles:(NSArray <NSString *>*)titles
                                          handler:(AxcBasicSuitBarBtnItemBlock )handler{
    NSMutableArray <AxcBase_BarItemBtnModel *>*btnModels = @[].mutableCopy;
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        [btnModels addObject:[[AxcBase_BarItemBtnModel alloc] initWithTitle:title imgName:nil]];
    }];
    return [self AxcBase_addBarButtonItem:bearing imgNameAndTitles:btnModels handler:handler];
}

/**
 图片 组 - 按钮在导航栏上，触发Block
 @param bearing 方位左右
 @param images 图片
 @param handler 触发回调Block区分方法使用Btn的axcStringTag
 */
- (NSArray <UIButton *>*)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                           images:(NSArray <NSString *>*)images
                                          handler:(AxcBasicSuitBarBtnItemBlock )handler{
    NSMutableArray <AxcBase_BarItemBtnModel *>*btnModels = @[].mutableCopy;
    [images enumerateObjectsUsingBlock:^(NSString * _Nonnull imgName, NSUInteger idx, BOOL * _Nonnull stop) {
        [btnModels addObject:[[AxcBase_BarItemBtnModel alloc] initWithTitle:nil imgName:imgName]];
    }];
    return [self AxcBase_addBarButtonItem:bearing imgNameAndTitles:btnModels handler:handler];
}

/**
 图 文 组 - 按钮在导航栏上，触发函数
 @param bearing 方位左右
 @param imageTitles 图片名和标题
 @return 一组设置好的按钮
 */
- (NSArray <UIButton *>*)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                 imgNameAndTitles:(NSArray <AxcBase_BarItemBtnModel *>*)imageTitles{
    return [self AxcBase_addBarButtonItem:bearing imgNameAndTitles:imageTitles handler:nil];
}

/**
 图 文 组 - 按钮在导航栏上，触发Block
 @param bearing 方位左右
 @param imageTitles 图片名和标题
 @param handler 触发Block回调
 @return 一组设置好的按钮
 */
- (NSArray <UIButton *>*)AxcBase_addBarButtonItem:(AxcBaseBarButtonItemBearing )bearing
                                 imgNameAndTitles:(NSArray <AxcBase_BarItemBtnModel *>*)imageTitles
                                          handler:(AxcBasicSuitBarBtnItemBlock )handler{
    SEL action = nil;
    if (bearing == AxcBaseBarButtonItemLocationRight) { // 右边
        if (handler)  self.rightBarItemBlock = handler;   // 指针移交
        action = @selector(AxcBase_clickRightBarItemBtn:);
    }else{
        if (handler)  self.leftBarItemBlock = handler;   // 指针移交
        action = @selector(AxcBase_clickLeftBarItemBtn:);
    }
    NSMutableArray <UIButton *>*btns = @[].mutableCopy;
    [imageTitles enumerateObjectsUsingBlock:^(AxcBase_BarItemBtnModel * _Nonnull imageTitle, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *image = nil;
        if(imageTitle.image.length) image = [UIImage imageNamed:imageTitle.image];
        UIButton *imageBtn = [self AxcBase_createButtonWithImage:image
                                                           title:imageTitle.title
                                                            font:self.defaultFont
                                                          action:action];
        imageBtn.axcStringTag = [NSString stringWithFormat:@"%@%@%ld",
                                 bearing == AxcBaseBarButtonItemLocationRight ? kAxcBasicSuitBarRightItemTag : kAxcBasicSuitBarLeftItemTag,
                                 kAxcBasicSuitSegmentation,
                                 AXCBASE_BARBTNITEM_TAG + idx];
        [btns addObject:imageBtn];
    }];
    [self AxcBase_settingBtnBearing:bearing buttons:btns];
    return btns;
}

/**
 根据方位放置按钮
 @param bearing 方位左右
 @param btns 按钮组
 */
- (void)AxcBase_settingBtnBearing:(AxcBaseBarButtonItemBearing )bearing
                          buttons:(NSArray <UIButton *>*)btns{
    NSMutableArray *barBtnItems = @[].mutableCopy;
    [btns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:obj];
        [barBtnItems addObject:item];
    }];
    switch (bearing) {
        case AxcBaseBarButtonItemLocationRight:
            self.navigationItem.rightBarButtonItems = barBtnItems; break;
        case AxcBaseBarButtonItemLocationLeft:
            self.navigationItem.leftBarButtonItems = barBtnItems; break;
        default: break;
    }
}

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
                                     action:(SEL )action{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setTitleColor:self.themeColor forState:UIControlStateNormal];
    if (image) { [button setImage:image forState:UIControlStateNormal];}
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        CGFloat width = [title AxcTool_getWidthFont:font maxHeight:self.axcNavBarHeight];
        button.axcTool_width = width;
    }
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark 其他实现

- (void )AxcBase_clickRightBarItemBtn:(UIButton *)sender{
    if (self.rightBarItemBlock)  self.rightBarItemBlock(sender);
}
- (void )AxcBase_clickLeftBarItemBtn:(UIButton *)sender{
    if (self.leftBarItemBlock)  self.leftBarItemBlock(sender);
}
/**
 获取BarBtnItem的Tag值
 @param sender 传入这个按钮对象
 @return Tag值
 */
- (NSInteger )getBarBtnItemTag:(UIButton *)sender{
    return [self comStringTagsWithSender:sender].lastObject.integerValue - AXCBASE_BARBTNITEM_TAG;
}
/**
 获取BarBtnItem的所在方位
 @param sender 传入这个按钮对象
 @return 所在方位
 */
- (AxcBaseBarButtonItemBearing )getBarBtnItemBearing:(UIButton *)sender{
    return [[self comStringTagsWithSender:sender].firstObject isEqualToString:kAxcBasicSuitBarRightItemTag] ?
    AxcBaseBarButtonItemLocationRight : AxcBaseBarButtonItemLocationLeft ;
}

- (NSArray <NSString *>*)comStringTagsWithSender:(UIButton *)sender{
    return [sender.axcStringTag componentsSeparatedByString:kAxcBasicSuitSegmentation];
}

#pragma mark 类扩展实现setGet
// right
- (void)setRightBarItemBlock:(AxcBasicSuitBarBtnItemBlock)rightBarItemBlock{
    [self willChangeValueForKey:krightBarItemBlock];
    objc_setAssociatedObject(self, &krightBarItemBlock,
                             rightBarItemBlock,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:krightBarItemBlock];
}
- (AxcBasicSuitBarBtnItemBlock)rightBarItemBlock{
    return objc_getAssociatedObject(self, &krightBarItemBlock);
}
// left
- (void)setLeftBarItemBlock:(AxcBasicSuitBarBtnItemBlock)leftBarItemBlock{
    [self willChangeValueForKey:kleftBarItemBlock];
    objc_setAssociatedObject(self, &kleftBarItemBlock,
                             leftBarItemBlock,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kleftBarItemBlock];
}
- (AxcBasicSuitBarBtnItemBlock)leftBarItemBlock{
    return objc_getAssociatedObject(self, &kleftBarItemBlock);
}

@end

@implementation AxcBase_BarItemBtnModel
- (instancetype)initWithTitle:(NSString *)title imgName:(NSString *)imgName{
    if (self == [super init]) {
        self.title = title;
        self.image = imgName;
    }
    return self;
}
@end

#pragma mark - 类扩展函数分层: 快速弹出指示框扩展实现

@implementation AxcBaseVC (AxcBaseVC_PopAlentEx)
/** 弹出一个警示框 - 自定标题Alent */
- (void)AxcBase_popWarningAlentWithTitle:(NSString *)title
                                     msg:(NSString *)msg
                               handler:(void (^)(UIAlertAction *action))handler{
    [self AxcBase_popAlentWithTitle:title
                                msg:msg
                  alertActionTitles:@[AxcLS(AxcBasicSuitDetermineText)]
                  cancelActionTitle:nil handler:handler];
}
/** 弹出一个警示框 - 自定标题Sheet */
- (void)AxcBase_popWarningAlentSheetWithTitle:(NSString *)title
                                          msg:(NSString *)msg
                                    handler:(void (^)(UIAlertAction *action))handler{
    [self AxcBase_popAlentSheetWithTitle:title
                                     msg:msg
                       alertActionTitles:@[AxcLS(AxcBasicSuitDetermineText)]
                       cancelActionTitle:nil handler:handler];
}

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
                                                            preferredStyle:style];
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
