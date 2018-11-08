//
//  UIImage+AxcTransfromZoom.m
//  AxcUIKit
//
//  Created by Axc on 2017/7/11.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//

#import "UIImage+AxcTransfromZoom.h"

@implementation UIImage (AxcTransfromZoom)

- (UIImage*)AxcTool_transformImageBitmapSize:(CGSize )size{
    return [self AxcTool_transformImageBitmapWidth:size.width height:size.height];
}
- (UIImage*)AxcTool_transformImageBitmapWidth:(CGFloat)width
                                     height:(CGFloat)height {
    CGFloat destW = width;
    CGFloat destH = height;
    CGFloat sourceW = width;
    CGFloat sourceH = height;
    
    CGImageRef imageRef = self.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                destW,
                                                destH,
                                                CGImageGetBitsPerComponent(imageRef),
                                                4*destW,
                                                CGImageGetColorSpace(imageRef),
                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *resultImage = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    return resultImage;
}



- (UIImage *)AxcTool_transformImageContextSize:(CGSize)size {
    return [self AxcTool_transformImageContextWidth:size.width height:size.height];
}
- (UIImage*)AxcTool_transformImageContextWidth:(CGFloat)width
                                      height:(CGFloat)height{
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self drawInRect:CGRectMake(0, 0, height, height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}


- (UIImage *)AxcTool_transformImageScale:(float)scale{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scale, self.size.height * scale));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scale, self.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


@end
