//
//  AxcBasicSuit
//
//  Created by ZhaoXin on 16/3/9.
//  Copyright © 2016年 Axc5324. All rights reserved.
//


#import "UIColor+AxcColorEx.h"


@implementation UIColor (AxcColorEx)

+ (UIColor*)AxcTool_turquoiseColor {
    return [UIColor colorWithRed:26.0f/255.0f
                           green:188.0f/255.0f
                            blue:156.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_greenSeaColor {
    return [UIColor colorWithRed:22.0f/255.0f
                           green:160.0f/255.0f
                            blue:133.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_emeraldColor {
    return [UIColor colorWithRed:46.0f/255.0f
                           green:204.0f/255.0f
                            blue:113.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_nephritisColor {
    return [UIColor colorWithRed:39.0f/255.0f
                           green:174.0f/255.0f
                            blue:96.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_peterRiverColor {
    return [UIColor colorWithRed:52.0f/255.0f
                           green:152.0f/255.0f
                            blue:219.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_belizeHoleColor {
    return [UIColor colorWithRed:41.0f/255.0f
                           green:128.0f/255.0f
                            blue:185.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_amethystColor {
    return [UIColor colorWithRed:155.0f/255.0f
                           green:89.0f/255.0f
                            blue:182.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_wisteriaColor {
    return [UIColor colorWithRed:142.0f/255.0f
                           green:68.0f/255.0f
                            blue:173.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_wetAsphaltColor {
    return [UIColor colorWithRed:52.0f/255.0f
                           green:73.0f/255.0f
                            blue:94.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_midNightColor {
    return [UIColor colorWithRed:44.0f/255.0f
                           green:62.0f/255.0f
                            blue:80.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_sunFlowerColor {
    return [UIColor colorWithRed:241.0f/255.0f
                           green:196.0f/255.0f
                            blue:15.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_orangeColor {
    return [UIColor colorWithRed:243.0f/255.0f
                           green:156.0f/255.0f
                            blue:18.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_carrotColor {
    return [UIColor colorWithRed:230.0f/255.0f
                           green:126.0f/255.0f
                            blue:34.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_pumpkinColor {
    return [UIColor colorWithRed:211.0f/255.0f
                           green:84.0f/255.0f
                            blue:0.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_alizarinColor {
    return [UIColor colorWithRed:231.0f/255.0f
                           green:76.0f/255.0f
                            blue:60.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_pomegranateColor {
    return [UIColor colorWithRed:192.0f/255.0f
                           green:57.0f/255.0f
                            blue:43.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_cloudColor {
    return [UIColor colorWithRed:236.0f/255.0f
                           green:240.0f/255.0f
                            blue:241.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_silverColor {
    return [UIColor colorWithRed:189.0f/255.0f
                           green:195.0f/255.0f
                            blue:199.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_concreteColor {
    return [UIColor colorWithRed:149.0f/255.0f
                           green:165.0f/255.0f
                            blue:166.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_asbestosColor {
    return [UIColor colorWithRed:127.0f/255.0f
                           green:140.0f/255.0f
                            blue:141.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor*)AxcTool_r:(int )r g:(int )g b:(int )b{
    return [UIColor colorWithRed:r/255.f
                           green:g/255.f
                            blue:b/255.f alpha:1];
}

+ (NSArray <UIColor *>*)AxcTool_getAllColors{
    return @[[UIColor AxcTool_carrotColor],[UIColor AxcTool_cloudColor],[UIColor AxcTool_orangeColor],[UIColor AxcTool_silverColor],[UIColor AxcTool_emeraldColor],[UIColor AxcTool_pumpkinColor],[UIColor AxcTool_alizarinColor],[UIColor AxcTool_amethystColor],[UIColor AxcTool_asbestosColor],[UIColor AxcTool_concreteColor],[UIColor AxcTool_greenSeaColor],[UIColor AxcTool_midNightColor],[UIColor AxcTool_wisteriaColor],[UIColor AxcTool_nephritisColor],[UIColor AxcTool_sunFlowerColor],[UIColor AxcTool_turquoiseColor],[UIColor AxcTool_belizeHoleColor],[UIColor AxcTool_peterRiverColor],[UIColor AxcTool_wetAsphaltColor]];
}

+ (UIColor *)AxcTool_arcPresetColor{
    NSArray *colors = [self AxcTool_getAllColors];
    return colors[arc4random()%colors.count];
}

+(UIColor *)AxcTool_arcColor{
    return [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
}

+ (UIColor *)AxcTool_inverseColorFor:(UIColor *)color {
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:1.-r green:1.-g blue:1.-b alpha:a];
}


+(UIColor *)AxcTool_colorHex:(NSString *)hexCode{
    NSString *cleanString = [hexCode stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)AxcTool_colorWithImageView:(UIImageView *)imageView AtPixel:(CGPoint)point {
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, imageView.image.size.width,
                                        imageView.image.size.height), point)) {
        return nil;
    }
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = imageView.image.CGImage;
    NSUInteger width = imageView.image.size.width;
    NSUInteger height = imageView.image.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast |     kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


@end


