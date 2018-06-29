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
    
    [self AxcBase_addBarButtonItem:AxcBaseBarButtonItemLocationRight
                            images:@[@"barItemImg",@"barItemImg"]
                           handler:^(UIButton *barItemBtn) {
                               NSLog(@"%@",barItemBtn.axcStringTag);
                           }];
    [self AxcBase_addBarButtonItem:AxcBaseBarButtonItemLocationLeft
                            titles:@[@"赵新",@"哈哈哈"]];
    self.dataListArray = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
    // 设置布局
//    UICollectionViewFlowLayout *_flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    _flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
//    _flowLayout.minimumLineSpacing = 15;
//    _flowLayout.minimumInteritemSpacing = 10;
//    [self AxcBase_settingCollectionLayout:_flowLayout nibName:nil cellID:@"111"];
//    [self.view addSubview:self.collectionView];
    
    [self AxcBase_settingTableType:UITableViewStylePlain nibName:nil cellID:nil];
    [self.view addSubview:self.tableView];
    self.useCustomToolBarView = YES;
    AxcErrorLog(@"%@",@"asdasd");
}

- (void)AxcBase_clickLeftBarItemBtn:(UIButton *)sender{
    NSLog(@"%@",sender.axcStringTag);
}



@end
