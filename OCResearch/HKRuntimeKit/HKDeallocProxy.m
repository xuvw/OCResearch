//
//  HKDeallocProxy.m
//  OCResearch
//
//  Created by heke on 2017/7/1.
//  Copyright © 2017年 MX. All rights reserved.
//

#import "HKDeallocProxy.h"

@interface HKDeallocProxy ()

@property (nonatomic, strong) NSMutableArray <void(^)(void)>*deallocJobs;

@end

@implementation HKDeallocProxy

- (void)dealloc {
    [self.deallocJobs enumerateObjectsUsingBlock:^(void (^ _Nonnull obj)(void), NSUInteger idx, BOOL * _Nonnull stop) {
        obj();
    }];
}

- (void)addDeallocJob:(void(^)(void))deallocJob {
    if (!self.deallocJobs) {
        self.deallocJobs = @[].mutableCopy;
    }
    [self.deallocJobs addObject:deallocJob];
}

@end
