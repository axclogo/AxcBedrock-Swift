//
//  NSString+AxcTextCalculation.m
//  AxcUIKit
//
//  Created by Axc on 2017/6/30.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//

#import "NSString+AxcTextCalculation.h"

@implementation NSString (AxcTextCalculation)

- (CGFloat) AxcTool_getWidthAttribute:(NSDictionary <NSString *, id> *)attribute maxHeight:(CGFloat )maxHeight{
    return [self  AxcTool_getRectAttribute:attribute
                                   maxSize:CGSizeMake(CGFLOAT_MAX, maxHeight)].size.width;
}
- (CGFloat) AxcTool_getHeightAttribute:(NSDictionary <NSString *, id> *)attribute maxWidth:(CGFloat)maxWidth{
    return [self  AxcTool_getRectAttribute:attribute
                                   maxSize:CGSizeMake(maxWidth, CGFLOAT_MAX)].size.height;
}

- (CGFloat) AxcTool_getWidthFontSize:(CGFloat)font maxHeight:(CGFloat)maxHeight{
    return [self  AxcTool_getRectAttribute:@{NSFontAttributeName : [UIFont systemFontOfSize:font]}
                                   maxSize:CGSizeMake(CGFLOAT_MAX, maxHeight)].size.width;
}
- (CGFloat) AxcTool_getHeightFontSize:(CGFloat)font maxWidth:(CGFloat)maxWidth{
    return [self  AxcTool_getRectAttribute:@{NSFontAttributeName : [UIFont systemFontOfSize:font]}
                                   maxSize:CGSizeMake(maxWidth, CGFLOAT_MAX)].size.height;
}

- (CGFloat) AxcTool_getWidthFont:(UIFont *)font maxHeight:(CGFloat)maxHeight{
    return [self  AxcTool_getRectAttribute:@{NSFontAttributeName : font}
                                   maxSize:CGSizeMake(CGFLOAT_MAX, maxHeight)].size.width;
}
- (CGFloat) AxcTool_getHeightFont:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    return [self  AxcTool_getRectAttribute:@{NSFontAttributeName : font}
                                   maxSize:CGSizeMake(maxWidth, CGFLOAT_MAX)].size.height;
}

- (CGRect ) AxcTool_getRectFont:(CGFloat )font maxSize:(CGSize )maxSize{
    return [self  AxcTool_getRectAttribute:@{NSFontAttributeName : [UIFont systemFontOfSize:font]}
                                   maxSize:maxSize];
}

- (CGRect ) AxcTool_getRectAttribute:(NSDictionary <NSString *, id> *)attribute
                             maxSize:(CGSize )size{
    NSParameterAssert(attribute);
    CGRect rect = CGRectZero;
    if (self.length) {
        rect = [self boundingRectWithSize:size
                                  options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:attribute
                                  context:nil];
    }
    return rect;
}


@end

