//
//  HKDeallocProxy.h
//  OCResearch
//
//  Created by heke on 2017/7/1.
//  Copyright © 2017年 MX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKDeallocProxy : NSObject

//http://www.jianshu.com/p/7b894f3819d7  arc下dealloc过程
- (void)addDeallocJob:(void(^)(void))deallocJob;

@end
