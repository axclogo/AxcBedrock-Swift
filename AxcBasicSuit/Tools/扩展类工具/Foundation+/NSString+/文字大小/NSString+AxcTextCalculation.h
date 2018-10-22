//
//  NSString+AxcTextCalculation.h
//  AxcUIKit
//
//  Created by Axc on 2017/6/30.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface NSString (AxcTextCalculation)

/**
 *  传入attribute计算文字宽度
 */
- (CGFloat) AxcTool_getWidthAttribute:(NSDictionary <NSString *, id> *)attribute maxHeight:(CGFloat )maxHeight;
/**
 *  传入attribute计算文字高度
 */
- (CGFloat) AxcTool_getHeightAttribute:(NSDictionary <NSString *, id> *)attribute maxWidth:(CGFloat )maxWidth;

/**
 *  传入font数值计算文字宽度
 */
- (CGFloat) AxcTool_getWidthFontSize:(CGFloat )font maxHeight:(CGFloat )maxHeight;
/**
 *  传入font数值计算文字高度
 */
- (CGFloat) AxcTool_getHeightFontSize:(CGFloat )font maxWidth:(CGFloat )maxWidth;

/**
 *  传入font计算文字宽度
 */
- (CGFloat) AxcTool_getWidthFont:(UIFont *)font maxHeight:(CGFloat )maxHeight;
/**
 *  传入font计算文字高度
 */
- (CGFloat) AxcTool_getHeightFont:(UIFont *)font maxWidth:(CGFloat )maxWidth;

/**
 *  传入font计算文字rect的Size
 */
- (CGRect ) AxcTool_getRectFont:(CGFloat )font maxSize:(CGSize )maxSize;



/**
 *  传入attribute计算文字rect的Size
 */
- (CGRect ) AxcTool_getRectAttribute:(NSDictionary <NSString *, id> *)attribute
                                 maxSize:(CGSize )size;
@end
