
//  UIView+Extension.m
//  AxcBasicSuit
//
//  Created by axc_5324 on 17/4/19.
//  Copyright © 2017年 axc_5324. All rights reserved.
//

#import "UIView+AxcViewRectEx.h"

@implementation UIView (AxcViewRectEx)

- (void)setAxcTool_x:(CGFloat)axcTool_X
{
    CGRect frame = self.frame;
    frame.origin.x = axcTool_X;
    self.frame = frame;
}

- (void)setAxcTool_y:(CGFloat)axcTool_Y
{
    CGRect frame = self.frame;
    frame.origin.y = axcTool_Y;
    self.frame = frame;
}

- (CGFloat)axcTool_x
{
    return self.frame.origin.x;
}

- (CGFloat)axcTool_y
{
    return self.frame.origin.y;
}

- (void)setAxcTool_width:(CGFloat)axcTool_Width
{
    CGRect frame = self.frame;
    frame.size.width = axcTool_Width;
    self.frame = frame;
}

- (void)setAxcTool_height:(CGFloat)axcTool_Height
{
    CGRect frame = self.frame;
    frame.size.height = axcTool_Height;
    self.frame = frame;
}

- (CGFloat)axcTool_height
{
    return self.frame.size.height;
}

- (CGFloat)axcTool_width
{
    return self.frame.size.width;
}

- (UIView * (^)(CGFloat x))setX{
    return ^(CGFloat x) {
        self.axcTool_x = x;
        return self;
    };
}

- (void)setAxcTool_centerX:(CGFloat)axcTool_CenterX
{
    CGPoint center = self.center;
    center.x = axcTool_CenterX;
    self.center = center;
}

- (CGFloat)axcTool_centerX
{
    return self.center.x;
}

- (void)setAxcTool_centerY:(CGFloat)axcTool_CenterY
{
    CGPoint center = self.center;
    center.y = axcTool_CenterY;
    self.center = center;
}

- (CGFloat)axcTool_centerY
{
    return self.center.y;
}

- (void)setAxcTool_size:(CGSize)axcTool_Size
{
    CGRect frame = self.frame;
    frame.size = axcTool_Size;
    self.frame = frame;
}

- (CGSize)axcTool_size
{
    return self.frame.size;
}

- (void)setAxcTool_origin:(CGPoint)axcTool_Origin
{
    CGRect frame = self.frame;
    frame.origin = axcTool_Origin;
    self.frame = frame;
}

- (CGPoint)axcTool_origin
{
    return self.frame.origin;
}

- (CGFloat)axcTool_left {
    return self.frame.origin.x;
}

- (void)setAxcTool_left:(CGFloat)axcTool_Left {
    CGRect frame = self.frame;
    frame.origin.x = axcTool_Left;
    self.frame = frame;
}

- (CGFloat)axcTool_top {
    return self.frame.origin.y;
}

- (void)setAxcTool_top:(CGFloat)axcTool_Top {
    CGRect frame = self.frame;
    frame.origin.y = axcTool_Top;
    self.frame = frame;
}

- (CGFloat)axcTool_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setAxcTool_right:(CGFloat)axcTool_Right {
    CGRect frame = self.frame;
    frame.origin.x = axcTool_Right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)axcTool_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setAxcTool_bottom:(CGFloat)axcTool_Bottom {
    CGRect frame = self.frame;
    frame.origin.y = axcTool_Bottom - frame.size.height;
    self.frame = frame;
}


- (UIView *(^)(UIColor *color)) setColor{
    return ^ (UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

- (UIView *(^)(CGRect frame)) setFrame{
    return ^ (CGRect frame) {
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGSize size)) setSize
{
    return ^ (CGSize size) {
        self.bounds = CGRectMake(0, 0, size.width, size.height);
        return self;
    };
}

- (UIView *(^)(CGPoint point)) setCenter
{
    return ^ (CGPoint point) {
        self.center = point;
        return self;
    };
}

- (UIView *(^)(NSInteger tag)) setTag
{
    return ^ (NSInteger tag) {
        self.tag = tag;
        return self;
    };
}


@end
