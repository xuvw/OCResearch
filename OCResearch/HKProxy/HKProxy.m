//
//  HKProxy.m
//  OCResearch
//
//  Created by heke on 2017/7/10.
//  Copyright © 2017年 MX. All rights reserved.
//

#import "HKProxy.h"

@interface HKProxy ()

@property (nonatomic, strong) id object;

@end

@implementation HKProxy

+ (instancetype _Nonnull )hk_proxyFor:(id __nonnull)object {
    HKProxy *proxy = [HKProxy alloc];
    proxy.object = object;
    return proxy;
}

- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    if ([self.object respondsToSelector:sel]){
        return [self.object methodSignatureForSelector:sel];
    }else {
        return [super methodSignatureForSelector:sel];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    //before method exe
    if ([self.object respondsToSelector:invocation.selector]){
        [invocation invokeWithTarget:self.object];
    }else {
        [super forwardInvocation:invocation];
    }
    //after method exe
    
    //at this point we can set/get the invocation.selector's return value,eg:
    
    /*
    NSObject *obj = [[NSObject alloc] init];
    [invocation getReturnValue:&obj];
    [invocation setReturnValue:&obj];
    */
}


@end
