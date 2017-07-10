//
//  NSObject+AvoidCrash.h
//  OCResearch
//
//  Created by heke on 2012/6/23.
//  Copyright © 2012年 MX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AvoidCrash)

- (void)addDeallocJob:(void(^)(void))deallocJob;

@end
