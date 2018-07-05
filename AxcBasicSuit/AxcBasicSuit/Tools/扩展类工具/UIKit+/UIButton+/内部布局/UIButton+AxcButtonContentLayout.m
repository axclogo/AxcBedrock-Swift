//
//  UIButton+AxcButtonContentLayout.m
//  AxcUIKit
//
//  Created by Axc on 2017/7/7.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//

#import "UIButton+AxcButtonContentLayout.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const kbuttonContentLayoutTypeKey = @"axcUI_buttonContentLayoutTypeKey";
static NSString * const kpaddingKey = @"axcUI_paddingKey";
static NSString * const kpaddingInsetKey = @"axcUI_paddingInsetKey";


@implementation UIButton (AxcContentLayout)

- (void)setupButtonLayout{
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGFloat image_w = self.imageView.frame.size.width;
    CGFloat image_h = self.imageView.frame.size.height;
    
    CGFloat title_w = self.titleLabel.frame.size.width;
    CGFloat title_h = self.titleLabel.frame.size.height;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0){
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        title_w = self.titleLabel.intrinsicContentSize.width;
        title_h = self.titleLabel.intrinsicContentSize.height;
    }
    
    UIEdgeInsets imageEdge = UIEdgeInsetsZero;
    UIEdgeInsets titleEdge = UIEdgeInsetsZero;
    
    if (self.axcPaddingInset == 0){
        self.axcPaddingInset = 5;
    }
    
    switch (self.axcContentLayoutType) {
        case AxcButtonContentLayoutStyleNormal:{
            titleEdge = UIEdgeInsetsMake(0, self.axcPadding, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, 0, 0, self.axcPadding);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case AxcButtonContentLayoutStyleCenterImageRight:{
            titleEdge = UIEdgeInsetsMake(0, -image_w - self.axcPadding, 0, image_w);
            imageEdge = UIEdgeInsetsMake(0, title_w + self.axcPadding, 0, -title_w);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case AxcButtonContentLayoutStyleCenterImageTop:{
            titleEdge = UIEdgeInsetsMake(0, -image_w, -image_h - self.axcPadding, 0);
            imageEdge = UIEdgeInsetsMake(-title_h - self.axcPadding, 0, 0, -title_w);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case AxcButtonContentLayoutStyleCenterImageBottom:{
            titleEdge = UIEdgeInsetsMake(-image_h - self.axcPadding, -image_w, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, 0, -title_h - self.axcPadding, -title_w);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case AxcButtonContentLayoutStyleLeftImageLeft:{
            titleEdge = UIEdgeInsetsMake(0, self.axcPadding + self.axcPaddingInset, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, self.axcPaddingInset, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case AxcButtonContentLayoutStyleLeftImageRight:{
            titleEdge = UIEdgeInsetsMake(0, -image_w + self.axcPaddingInset, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, title_w + self.axcPadding + self.axcPaddingInset, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case AxcButtonContentLayoutStyleRightImageLeft:{
            imageEdge = UIEdgeInsetsMake(0, 0, 0, self.axcPadding + self.axcPaddingInset);
            titleEdge = UIEdgeInsetsMake(0, 0, 0, self.axcPaddingInset);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
        case AxcButtonContentLayoutStyleRightImageRight:{
            titleEdge = UIEdgeInsetsMake(0, -self.frame.size.width / 2, 0, image_w + self.axcPadding + self.axcPaddingInset);
            imageEdge = UIEdgeInsetsMake(0, 0, 0, -title_w + self.axcPaddingInset);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
        default:break;
    }
    self.imageEdgeInsets = imageEdge;
    self.titleEdgeInsets = titleEdge;
    [self setNeedsDisplay];
}


#pragma mark - SET
- (void)setAxcContentLayoutType:(AxcButtonContentLayoutStyle)axcUI_buttonContentLayoutType{
    [self willChangeValueForKey:kbuttonContentLayoutTypeKey];
    objc_setAssociatedObject(self, &kbuttonContentLayoutTypeKey,
                             @(axcUI_buttonContentLayoutType),
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:kbuttonContentLayoutTypeKey];
    [self setupButtonLayout];
}

- (AxcButtonContentLayoutStyle)axcContentLayoutType{
    return [objc_getAssociatedObject(self, &kbuttonContentLayoutTypeKey) integerValue];
}

- (void)setAxcPadding:(CGFloat)axcUI_padding{
    [self willChangeValueForKey:kpaddingKey];
    objc_setAssociatedObject(self, &kpaddingKey,
                             @(axcUI_padding),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kpaddingKey];

    [self setupButtonLayout];
}

- (CGFloat)axcPadding{
    return [objc_getAssociatedObject(self, &kpaddingKey) floatValue];
}

- (void)setAxcPaddingInset:(CGFloat)axcUI_paddingInset{
    [self willChangeValueForKey:kpaddingInsetKey];
    objc_setAssociatedObject(self, &kpaddingInsetKey,
                             @(axcUI_paddingInset),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kpaddingInsetKey];
    [self setupButtonLayout];
}

- (CGFloat)axcPaddingInset{
    return [objc_getAssociatedObject(self, &kpaddingInsetKey) floatValue];
}


@end
NS_ASSUME_NONNULL_END

