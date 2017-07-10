//
//  HKWeakArray.m
//  OCResearch
//
//  Created by heke on 2017/7/7.
//  Copyright © 2017年 MX. All rights reserved.
//

#import "HKWeakArray.h"

@interface HKWeakArray ()
{
    NSPointerArray *pointerArray;
}
@end

@implementation HKWeakArray

+ (instancetype)array {
    
    return [[HKWeakArray alloc] init];
    
}

@end
