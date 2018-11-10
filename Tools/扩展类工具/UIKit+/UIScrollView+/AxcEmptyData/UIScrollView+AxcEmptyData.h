//
//  UIScrollView+AxcEmptyData.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/10.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (AxcEmptyData)

/**
 当此指针拥有一个View的时候，会在TableView/collectionView/webView无数据的时候展示此占位View
 */
@property (nonatomic,strong) UIView * axcPlaceHolderView;

/**
 占位View的入场动画和出场动画，默认YES
 */
@property (nonatomic,assign) BOOL axcPlaceHolderViewAnimations;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
