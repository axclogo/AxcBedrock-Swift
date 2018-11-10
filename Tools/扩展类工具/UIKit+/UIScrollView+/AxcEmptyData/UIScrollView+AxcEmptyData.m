//
//  UIScrollView+AxcEmptyData.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/10.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "UIScrollView+AxcEmptyData.h"
#import <objc/runtime.h>

static NSString * const kaxcPlaceHolderViewAnimations = @"axcPlaceHolderViewAnimations";

@implementation UIScrollView (AxcEmptyData)

-(void)setAxcPlaceHolderViewAnimations:(BOOL)axcPlaceHolderViewAnimations{
    [self willChangeValueForKey:kaxcPlaceHolderViewAnimations];
    objc_setAssociatedObject(self, &kaxcPlaceHolderViewAnimations,
                             @(axcPlaceHolderViewAnimations),
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:kaxcPlaceHolderViewAnimations];
}
- (BOOL)axcPlaceHolderViewAnimations{
    if (!objc_getAssociatedObject(self, &kaxcPlaceHolderViewAnimations)) {
        return YES;
    }else{
        BOOL bol = [objc_getAssociatedObject(self, &kaxcPlaceHolderViewAnimations) boolValue];
        return bol;
    }
}

- (void)setAxcPlaceHolderView:(UIView *)axcPlaceHolderView{
    objc_setAssociatedObject(self, @selector(axcPlaceHolderView),axcPlaceHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (objc_getAssociatedObject(self, @selector(axcPlaceHolderView))) {
        //防止手动调用load出现多次调用的情况：
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if ([self respondsToSelector:@selector(reloadData)]) { // 如果已实现，说明是两种列表结构
                [UIScrollView swizzleOriginMethod:@selector(reloadData)
                                           Method:@selector(customReloadData)];
            }
        });
    }
}
-(UIView *)axcPlaceHolderView{
    UIView *view = objc_getAssociatedObject(self, @selector(axcPlaceHolderView));
    return view;
}
#pragma mark 自定义刷新方法：
-(void)customReloadData{
    [self checkIsEmpty];
    [self customReloadData];
}
- (void)reloadData{
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        [tableView reloadData];
    }else if([self isKindOfClass:[UICollectionView class]]){
        UICollectionView *collectionView = (UICollectionView *)self;
        [collectionView reloadData];
    }
}
//替换方法：
+ (void)swizzleOriginMethod:(SEL)oriSel Method:(SEL)newSel{
    Method oriMethod = class_getInstanceMethod(self, oriSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    BOOL methodIsAdd = class_addMethod(self, oriSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (methodIsAdd) {
        class_replaceMethod(self, newSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }else{
        method_exchangeImplementations(oriMethod, newMethod);
    }
}


- (void)checkIsEmpty{
    BOOL isEmpty = YES;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        id<UITableViewDataSource> src = tableView.dataSource;
        if ([src respondsToSelector:@selector(numberOfSectionsInTableView:)]) {//group
            NSInteger sections = [src numberOfSectionsInTableView:tableView];
            if (sections > 1) {
                isEmpty = NO;
            }else if (sections == 1){
                NSInteger rows = [src tableView:tableView numberOfRowsInSection:0];//plain
                if (rows > 0) isEmpty = NO;
            }
        }else{
            NSInteger rows = [src tableView:tableView numberOfRowsInSection:0];//plain
            if (rows > 0) isEmpty = NO;
        }
        
    }else if([self isKindOfClass:[UICollectionView class]]){
        UICollectionView *collectionView = (UICollectionView *)self;
        id<UICollectionViewDataSource> src = collectionView.dataSource;
        if ([src respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {//group
            NSInteger sections = [src numberOfSectionsInCollectionView:collectionView];
            if (sections > 1) {
                isEmpty = NO;
            }else if (sections == 1){
                NSInteger rows = [src collectionView:collectionView numberOfItemsInSection:0];//plain
                if (rows > 0) isEmpty = NO;
            }
        }else{
            NSInteger rows = [src collectionView:collectionView numberOfItemsInSection:0];//plain
            if (rows > 0) isEmpty = NO;
        }
    }else if([self isKindOfClass:[WKWebView class]]){
        
    }
    if (isEmpty) {
        [self.axcPlaceHolderView removeFromSuperview];
        [self addSubview:self.axcPlaceHolderView];
        if (self.axcPlaceHolderView) {
            WeakSelf;
            self.axcPlaceHolderView.alpha = 0;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 weakSelf.axcPlaceHolderView.alpha = 1;
                             }];
        }
    }else{
        if (self.axcPlaceHolderViewAnimations) {
            WeakSelf;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 weakSelf.axcPlaceHolderView.alpha = 0;
                             } completion:^(BOOL finished) {
                                 [weakSelf.axcPlaceHolderView removeFromSuperview];
                             }];
        }else{
            [self.axcPlaceHolderView removeFromSuperview];
        }
    }
}

@end
