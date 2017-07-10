//
//  HKWeakDictionary.m
//  OCResearch
//
//  Created by heke on 2017/7/7.
//  Copyright © 2017年 MX. All rights reserved.
//

#import "HKWeakDictionary.h"

@interface HKWeakDictionary ()
{
    NSMapTable *mapTable;
}

@end

@implementation HKWeakDictionary

+ (instancetype)dictionary {
    
    return [[HKWeakDictionary alloc] init];
    
}

@end
