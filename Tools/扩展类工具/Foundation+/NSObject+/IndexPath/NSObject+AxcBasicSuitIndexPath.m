//
//  NSObject+AxcBasicSuitIndexPath.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/6/26.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "NSObject+AxcBasicSuitIndexPath.h"
#import <objc/runtime.h>

static NSString * const kaxcIntTag = @"kaxcIntTag";
static NSString * const kaxcIndexPath = @"kaxcIndexPath";
static NSString * const kaxcStringTag = @"kaxcStringTag";
static NSString * const ksaveValueObj = @"ksaveValueObj";


@implementation NSObject (AxcBasicSuitIndexPath)

//////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setAxcIndexPath:(NSIndexPath *)axcIndexPath{
    [self willChangeValueForKey:kaxcIndexPath];
    objc_setAssociatedObject(self, &kaxcIndexPath,
                             axcIndexPath,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kaxcIndexPath];
}
- (NSIndexPath *)axcIndexPath{
    return objc_getAssociatedObject(self, &kaxcIndexPath);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setAxcStringTag:(NSString *)axcStringTag{
    [self willChangeValueForKey:kaxcStringTag];
    objc_setAssociatedObject(self, &kaxcStringTag,
                             axcStringTag,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kaxcStringTag];
}
- (NSString *)axcStringTag{
    return objc_getAssociatedObject(self, &kaxcStringTag);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setAxcIntTag:(NSInteger)axcIntTag{
    [self willChangeValueForKey:kaxcIntTag];
    objc_setAssociatedObject(self, &kaxcIntTag,
                             @(axcIntTag),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kaxcIntTag];
}
- (NSInteger )axcIntTag{
    NSNumber *num = objc_getAssociatedObject(self, &kaxcIntTag);
    return num.integerValue;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSaveValueObj:(NSObject *)saveValueObj{
    [self willChangeValueForKey:ksaveValueObj];
    objc_setAssociatedObject(self, &ksaveValueObj,
                             saveValueObj,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:ksaveValueObj];
}
- (NSObject *)saveValueObj{
    return objc_getAssociatedObject(self, &ksaveValueObj);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////



@end
