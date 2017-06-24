//
//  UIViewController+RuntimeKit.m
//  OCResearch
//
//  Created by heke on 2012/6/19.
//  Copyright © 2012年 MX. All rights reserved.
//

#import "UIViewController+RuntimeKit.h"
#import "HKRuntimeKitCore.h"

@implementation UIViewController (RuntimeKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rk_replaceInstanceMethod([UIViewController class], @selector(viewWillAppear:), @selector(rk_viewWillAppear:));
    });
}

- (void)rk_viewWillAppear:(BOOL)animated {
//    NSLog(@"%@:rk_viewWillAppear",[self class]);
    [self rk_viewWillAppear:animated];
}


@end
