//
//  NSObject+AvoidCrash.m
//  OCResearch
//
//  Created by heke on 2012/6/23.
//  Copyright © 2012年 MX. All rights reserved.
//

#import "NSObject+AvoidCrash.h"
#import "HKRuntimeKitCore.h"

#define SELName(sel) [NSString stringWithCString:sel_getName(sel) encoding:NSUTF8StringEncoding]

id nullObject = nil;

int nullMethod(id self, SEL cmd){
    
//    NSLog(@"avoid [%@ %@]crash",[self class],SELName(cmd));
    return 0;
}

@implementation NSObject (AvoidCrash)

+ (void)load {
//    rk_replaceClassMethod([self class], @selector(resolveClassMethod:), @selector(rk_resolveClassMethod:));
//    rk_replaceClassMethod([self class], @selector(resolveInstanceMethod:), @selector(rk_resolveInstanceMethod:));
    
    rk_replaceInstanceMethod([self class], @selector(forwardingTargetForSelector:), @selector(rk_forwardingTargetForSelector:));
//    rk_replaceInstanceMethod([self class], @selector(forwardInvocation:), @selector(rk_forwardInvocation:));
//    rk_replaceInstanceMethod([self class], @selector(doesNotRecognizeSelector:), @selector(rk_doesNotRecognizeSelector:));
//    rk_replaceInstanceMethod([self class], @selector(methodSignatureForSelector:), @selector(rk_methodSignatureForSelector:));
}

//+ (BOOL)rk_resolveClassMethod:(SEL)sel {
//    
//    NSLog(@"rk_resolveClassMethod %@,sel:%@",NSStringFromClass([self class]),SELName(sel));
//    return [self rk_resolveClassMethod:sel];
//}
//
//+ (BOOL)rk_resolveInstanceMethod:(SEL)sel {
//    NSLog(@"rk_resolveInstanceMethod %@,sel:%@",NSStringFromClass([self class]),SELName(sel));
//    return [self rk_resolveInstanceMethod:sel];
//}

- (id)rk_forwardingTargetForSelector:(SEL)aSelector {
//    NSLog(@"rk_forwardingTargetForSelector %@,sel:%@",NSStringFromClass([self class]),SELName(aSelector));
    
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

//- (NSMethodSignature *)rk_methodSignatureForSelector:(SEL)aSelector {
//    
//    NSLog(@"rk_methodSignatureForSelector %@,sel:%@",NSStringFromClass([self class]),SELName(aSelector));
//    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//}

//- (void)rk_forwardInvocation:(NSInvocation *)anInvocation {
//    NSLog(@"rk_forwardInvocation %@,sel:%@",NSStringFromClass([self class]),SELName(anInvocation.selector));
//    [self rk_forwardInvocation:anInvocation];
//}

- (void)rk_doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"rk_doesNotRecognizeSelector %@,sel:%@",NSStringFromClass([self class]),SELName(aSelector));
    [self rk_doesNotRecognizeSelector:aSelector];
}


@end
