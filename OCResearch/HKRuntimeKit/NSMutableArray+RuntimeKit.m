//
//  NSMutableArray+RuntimeKit.m
//  OCResearch
//
//  Created by heke on 2012/6/19.
//  Copyright © 2012年 MX. All rights reserved.
//

#import "NSMutableArray+RuntimeKit.h"
#import "HKRuntimeKitCore.h"

@implementation NSMutableArray (RuntimeKit)

//__NSArray0,__NSArrayM,__NSDictionary0,__NSDictionaryM
+ (void)load {
    rk_replaceInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndex:), @selector(rk_objectAtIndex:));
}

- (id)rk_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self rk_objectAtIndex:index];
    }else {
        NSLog(@"NSMutableArray objectAtIndex 越界:%ld",index);
        return nil;
    }
}

@end
