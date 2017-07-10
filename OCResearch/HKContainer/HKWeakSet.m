//
//  HKWeakSet.m
//  OCResearch
//
//  Created by heke on 2017/7/7.
//  Copyright © 2017年 MX. All rights reserved.
//

#import "HKWeakSet.h"

@interface HKWeakSet ()
{
    NSHashTable *hashTable;
}
@end

@implementation HKWeakSet

+ (instancetype)set {
    
    return [[HKWeakSet alloc] init];
    
}

@end
