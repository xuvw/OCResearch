//
//  NSDictionary+RuntimeKit.m
//  OCResearch
//
//  Created by heke on 2012/6/19.
//  Copyright © 2012年 MX. All rights reserved.
//

#import "NSDictionary+RuntimeKit.h"
#import "HKRuntimeKitCore.h"

@implementation NSDictionary (RuntimeKit)

+ (void)load {
    rk_replaceInstanceMethod(objc_getClass("__NSDictionary0"), @selector(objectForKey:), @selector(rk_objectForKey:));
}

- (id)rk_objectForKey:(id)aKey {
    if (aKey) {
        return [self rk_objectForKey:aKey];
    }else {
        NSLog(@"objectForKey:'s key is nil return nil!");
        return nil;
    }
}

@end
