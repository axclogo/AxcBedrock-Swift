//
//  Axc框架封装工程
//
//  Created by ZhaoXin on 16/3/9.
//  Copyright © 2016年 Axc5324. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AxcColorEx)

/** 湖色 */
+ (UIColor*)AxcTool_turquoiseColor;

/** 绿海色 */
+ (UIColor*)AxcTool_greenSeaColor;

/** 翡翠绿 */
+ (UIColor*)AxcTool_emeraldColor;

/** 未知 */
+ (UIColor*)AxcTool_nephritisColor;
/**
 *  河水蓝
 */
+ (UIColor*)AxcTool_peterRiverColor;
/**
 *  暴雪蓝
 */
+ (UIColor*)AxcTool_belizeHoleColor;
/**
 *  紫水晶
 */
+ (UIColor*)AxcTool_amethystColor;
/**
 *  紫藤
 */
+ (UIColor*)AxcTool_wisteriaColor;
/**
 *  湿沥青藏蓝
 */
+ (UIColor*)AxcTool_wetAsphaltColor;
/**
 *  午夜
 */
+ (UIColor*)AxcTool_midNightColor;
/**
 *  太阳花
 */
+ (UIColor*)AxcTool_sunFlowerColor;
/**
 *  橘色
 */
+ (UIColor*)AxcTool_orangeColor;
/**
 *  胡萝卜
 */
+ (UIColor*)AxcTool_carrotColor;
/**
 *  南瓜
 */
+ (UIColor*)AxcTool_pumpkinColor;
/**
 *  茜素红
 */
+ (UIColor*)AxcTool_alizarinColor;
+ (UIColor*)AxcTool_pomegranateColor;
/**
 *  云色
 */
+ (UIColor*)AxcTool_cloudColor;
/**
 *  石榴红
 */
+ (UIColor*)AxcTool_silverColor;
/**
 *  混凝土
 */
+ (UIColor*)AxcTool_concreteColor;
+ (UIColor*)AxcTool_asbestosColor;


/** 获取扩展中所有的颜色 */
+ (NSArray <UIColor *>*)AxcTool_getAllColors;

/** 在扩展中随机一个颜色 */
+ (UIColor*)AxcTool_arcPresetColor;

/** 随机色 */
+ (UIColor*)AxcTool_arcColor;

/** RGB */
+ (UIColor*)AxcTool_r:(int )r g:(int )g b:(int )b;

/** 反转色 */
+ (UIColor *)AxcTool_inverseColorFor:(UIColor *)color ;

/** Hex的16进制转颜色 */
+ (UIColor *)AxcTool_colorHex:(NSString *)hexCode;


@end

