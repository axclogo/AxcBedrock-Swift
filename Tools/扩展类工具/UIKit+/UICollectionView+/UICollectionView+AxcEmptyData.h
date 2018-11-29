//
//  UICollectionView+AxcEmptyData_CV.h
//  Fabric_Merchants
//
//  Created by Axc on 2018/3/30.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (AxcEmptyData)

/**
 当此指针拥有一个View的时候，会在TableView无数据的时候展示此占位View
 */
@property (nonatomic,strong) UIView * axcPlaceHolderView;

/**
 占位View的入场动画和出场动画，默认YES
 */
@property (nonatomic,assign) BOOL axcPlaceHolderViewAnimations;

@end
