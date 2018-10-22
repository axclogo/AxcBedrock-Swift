//
//  UIView+AxcSpecialEffectsDrawing.h
//  AxcUIKit
//
//  Created by Axc on 2017/7/13.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AxcSpecialEffectsDrawing)

/**
 *  马赛克化
 */
- (UIImage *)AxcTool_drawingWithMosaic;

/**
 *  高斯模糊 0.5
 */
- (UIImage *)AxcTool_drawingWithGaussianBlur;

/**
 *  高斯模糊 自定义
 */
- (UIImage *)AxcTool_drawingWithGaussianBlurNumber:(CGFloat)blur;

/**
 *  边缘锐化
 */
- (UIImage *)AxcTool_drawingWithEdgeDetection;

/**
 *  浮雕
 */
- (UIImage *)AxcTool_drawingWithEmboss;

/**
 *  锐化
 */
- (UIImage *)AxcTool_drawingWithSharpen;

/**
 *  进一步锐化
 */
- (UIImage *)AxcTool_drawingWithNnsharpen;

// 几何操作：
/**
 *  图片旋转
 */
- (UIImage *)AxcTool_drawingWithRotateInRadians:(float)radians;


// 形态操作：
/**
 *  形态膨胀/扩张
 */
- (UIImage *)AxcTool_drawingWithDilate;
/**
 *  形态多倍膨胀/扩张
 */
- (UIImage *)AxcTool_drawingWithDilateIterations:(int)iterations;

/**
 *  侵蚀
 */
- (UIImage *)AxcTool_drawingWithErode;
/**
 *  多倍侵蚀
 */
- (UIImage *)AxcTool_drawingWithErodeIterations:(int)iterations;

/**
 *  均衡运算
 */
- (UIImage *)AxcTool_drawingWithEqualization;

/**
 *  梯度
 */
- (UIImage *)AxcTool_drawingWithGradientIterations:(int)iterations;

/**
 *  顶帽运算
 */
- (UIImage *)AxcTool_drawingWithTophatIterations:(int)iterations;

/**
 *  黑帽运算
 */
- (UIImage *)AxcTool_drawingWithBlackhatIterations:(int)iterations;







#pragma mark - 复用函数
/**
 *  混合函数(内部使用)
 */
- (UIImage *)AxcTool_imageBlendedWithImage:(UIImage *)overlayImage
                               blendMode:(CGBlendMode)blendMode
                                   alpha:(CGFloat)alpha;

@end
