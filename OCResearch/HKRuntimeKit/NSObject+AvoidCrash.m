//
//  NSObject+AvoidCrash.m
//  OCResearch
//
//  Created by heke on 2012/6/23.
//  Copyright © 2012年 MX. All rights reserved.
//

#import "NSObject+AvoidCrash.h"
#import "HKRuntimeKitCore.h"
#import "HKDeallocProxy.h"
#import <pthread.h>

#define SELName(sel) [NSString stringWithCString:sel_getName(sel) encoding:NSUTF8StringEncoding]

id nullObject = nil;

int nullMethod(id self, SEL cmd){
    return 0;
}

pthread_mutex_t rk_deallocProxyLock;

@implementation NSObject (AvoidCrash)

+ (void)load {
    
    HKDeallocProxy *dp = objc_getAssociatedObject(self, "rk_deallocProxy");
    if (!dp) {
        dp = [[HKDeallocProxy alloc] init];
        objc_setAssociatedObject(self, "rk_deallocProxy", dp, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    pthread_mutex_init(&rk_deallocProxyLock, NULL);
    //avoid send message crash
    rk_replaceClassMethod([self class], @selector(resolveClassMethod:), @selector(rk_resolveClassMethod:));
    rk_replaceClassMethod([self class], @selector(resolveInstanceMethod:), @selector(rk_resolveInstanceMethod:));
    
    rk_replaceInstanceMethod([self class], @selector(forwardingTargetForSelector:), @selector(rk_forwardingTargetForSelector:));
    rk_replaceInstanceMethod([self class], @selector(forwardInvocation:), @selector(rk_forwardInvocation:));
    rk_replaceInstanceMethod([self class], @selector(doesNotRecognizeSelector:), @selector(rk_doesNotRecognizeSelector:));
    rk_replaceInstanceMethod([self class], @selector(methodSignatureForSelector:), @selector(rk_methodSignatureForSelector:));
    
    //avoid kvo crash
//    rk_replaceInstanceMethod([self class], @selector(addObserver:forKeyPath:options:context:), @selector(rk_addObserver:forKeyPath:options:context:));
//    rk_replaceInstanceMethod([self class], @selector(removeObserver:forKeyPath:), @selector(rk_removeObserver:forKeyPath:));
//    rk_replaceInstanceMethod([self class], @selector(observeValueForKeyPath:ofObject:change:context:), @selector(rk_observeValueForKeyPath:ofObject:change:context:));
//    SEL deallocSEL = NSSelectorFromString(@"dealloc");
//    rk_replaceInstanceMethod([self class], deallocSEL, @selector(rk_dealloc));
    
//    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
//    
//    Method method2 = class_getInstanceMethod([self class], @selector(rk_dealloc));
//    
//    method_exchangeImplementations(method1, method2);
}


#pragma mark - method forward
+ (BOOL)rk_resolveClassMethod:(SEL)sel {
    
    return [self rk_resolveClassMethod:sel];
}

+ (BOOL)rk_resolveInstanceMethod:(SEL)sel {
    
    return [self rk_resolveInstanceMethod:sel];
}

- (id)rk_forwardingTargetForSelector:(SEL)aSelector {
    
    id target = [self rk_forwardingTargetForSelector:aSelector];
    if (target) {
        return target;
    }else {
        [self createClass:"rknullclass" sel:(SEL)aSelector];
        return nullObject;
    }
}

- (void)createClass:(const char *)className sel:(SEL)aSelector {
    Class cls = objc_getClass(className);
    if (!cls) {
        cls = objc_allocateClassPair([NSObject class], className, 0);
    }
    
    class_addMethod(cls, aSelector, (IMP)nullMethod, "i@:");
    
    if (cls) {
        nullObject = [[cls alloc] init];
    }
}

- (NSMethodSignature *)rk_methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"i@:"];
}

- (void)rk_forwardInvocation:(NSInvocation *)anInvocation {
    [self rk_forwardInvocation:anInvocation];
}

- (void)rk_doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"rk_doesNotRecognizeSelector %@,sel:%@",NSStringFromClass([self class]),SELName(aSelector));
    [self rk_doesNotRecognizeSelector:aSelector];
}

#pragma mark - avoid kvo crash
- (void)rk_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
}

- (void)rk_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    
    
}

- (void)rk_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}

#pragma mark - avoid NSNotification crash

#pragma mark - avoid NSTimer crash

#pragma mark - avoid bad access crash

#pragma mark - private
- (void)addDeallocJob:(void(^)(void))deallocJob {
    HKDeallocProxy *dp = [self rk_deallocProxy];
    [dp addDeallocJob:deallocJob];
}

- (HKDeallocProxy *)rk_deallocProxy {
    pthread_mutex_lock(&rk_deallocProxyLock);
    
    HKDeallocProxy *dp = objc_getAssociatedObject(self, "rk_deallocProxy");
    if (!dp) {
        dp = [[HKDeallocProxy alloc] init];
        objc_setAssociatedObject(self, "rk_deallocProxy", dp, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    pthread_mutex_unlock(&rk_deallocProxyLock);
    return dp;
}

@end
