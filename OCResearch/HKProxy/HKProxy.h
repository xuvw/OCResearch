//
//  HKProxy.h
//  OCResearch
//
//  Created by heke on 2017/7/10.
//  Copyright © 2017年 MX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKProxy : NSProxy

+ (instancetype _Nonnull )hk_proxyFor:(id __nonnull)object;

@end
