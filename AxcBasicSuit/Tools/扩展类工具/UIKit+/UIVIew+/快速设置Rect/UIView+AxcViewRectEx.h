
//  UIView+Extension.h
//  AxcBasicSuit
//
//  Created by axc_5324 on 17/4/19.
//  Copyright © 2017年 axc_5324. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AxcViewRectEx)
/**
 *  1.间隔X值
 */
@property (nonatomic, assign) CGFloat axcTool_x;

/**
 *  2.间隔Y值
 */
@property (nonatomic, assign) CGFloat axcTool_y;

/**
 *  3.宽度
 */
@property (nonatomic, assign) CGFloat axcTool_width;

/**
 *  4.高度
 */
@property (nonatomic, assign) CGFloat axcTool_height;

/**
 *  5.中心点X值
 */
@property (nonatomic, assign) CGFloat axcTool_centerX;

/**
 *  6.中心点Y值
 */
@property (nonatomic, assign) CGFloat axcTool_centerY;

/**
 *  7.尺寸大小
 */
@property (nonatomic, assign) CGSize axcTool_size;

/**
 *  8.起始点
 */
@property (nonatomic, assign) CGPoint axcTool_origin;

/**
 *  9.上 < Shortcut for frame.origin.y
 */
@property (nonatomic) CGFloat axcTool_top;

/**
 *  10.下 < Shortcut for frame.origin.y + frame.size.height
 */
@property (nonatomic) CGFloat axcTool_bottom;

/**
 *  11.左 < Shortcut for frame.origin.x.
 */
@property (nonatomic) CGFloat axcTool_left;

/**
 *  12.右 < Shortcut for frame.origin.x + frame.size.width
 */
@property (nonatomic) CGFloat axcTool_right;




@end
