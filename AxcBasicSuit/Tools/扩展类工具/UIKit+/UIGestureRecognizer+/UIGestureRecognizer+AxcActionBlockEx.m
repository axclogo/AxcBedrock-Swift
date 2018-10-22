//
//  UIGestureRecognizer+AxcActionBlockEx.m
//  AxcBasicSuit
//
//  Created by AxcLogo on 2018/7/6.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "UIGestureRecognizer+AxcActionBlockEx.h"
#import <objc/runtime.h>


static const int block_key;

@interface _AxcTool_UIGestureRecognizerBlockTarget : NSObject

@property (nonatomic, copy) AxcBasicSuitSenderBlock block;

- (id)initWithBlock:(AxcBasicSuitSenderBlock )block;
- (void)invoke:(id)sender;

@end

@implementation _AxcTool_UIGestureRecognizerBlockTarget

- (id)initWithBlock:(AxcBasicSuitSenderBlock)block{
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}

- (void)invoke:(id)sender {
    if (self.block) self.block(sender);
}


@end




@implementation UIGestureRecognizer (LFAdditions)

- (instancetype)initWithActionBlock:(AxcBasicSuitSenderBlock )block {
    self = [self init];
    [self AxcTool_addActionBlock:block];
    return self;
}

- (void)AxcTool_addActionBlock:(AxcBasicSuitSenderBlock )block {
    _AxcTool_UIGestureRecognizerBlockTarget *target = [[_AxcTool_UIGestureRecognizerBlockTarget alloc] initWithBlock:block];
    [self addTarget:target action:@selector(invoke:)];
    NSMutableArray *targets = [self _Axc_allUIGestureRecognizerBlockTargets];
    [targets addObject:target];
}

- (void)AxcTool_removeAllActionBlocks{
    NSMutableArray *targets = [self _Axc_allUIGestureRecognizerBlockTargets];
    [targets enumerateObjectsUsingBlock:^(id target, NSUInteger idx, BOOL *stop) {
        [self removeTarget:target action:@selector(invoke:)];
    }];
    [targets removeAllObjects];
}

- (NSMutableArray *)_Axc_allUIGestureRecognizerBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
