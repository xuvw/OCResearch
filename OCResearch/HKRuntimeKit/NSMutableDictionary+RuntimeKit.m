//
//  NSMutableDictionary+RuntimeKit.m
//  OCResearch
//
//  Created by heke on 2012/6/19.
//  Copyright © 2012年 MX. All rights reserved.
//

#import "NSMutableDictionary+RuntimeKit.h"
#import "HKRuntimeKitCore.h"

@implementation NSMutableDictionary (RuntimeKit)

+ (void)load {
    rk_replaceInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:), @selector(rk_setObject:forKey:));
    rk_replaceInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(objectForKey:), @selector(rk_objectForKey:));
}

- (void)rk_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    NSString *a = nil;
    [a conformsToProtocol:nil];
    if (anObject && aKey) {
        [self rk_setObject:anObject forKey:aKey];
    }else {
        NSLog(@"dictionary's setObject:forKey: in which object can not be nil!");
    }
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
