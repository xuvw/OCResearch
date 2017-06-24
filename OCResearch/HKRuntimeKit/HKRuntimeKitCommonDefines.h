//
//  HKRuntimeKitCommonDefines.h
//  OCResearch
//
//  Created by heke on 2012/6/18.
//  Copyright © 2012年 MX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

CG_INLINE Class rk_getMetaClass(Class fromClass) {
    return objc_getMetaClass(object_getClassName(fromClass));
}

CG_INLINE void
rk_replaceClassMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    
    if (_class == NULL ||
        _originSelector == NULL ||
        _newSelector == NULL) {
        return;
    }
    
    Method oriMethod = class_getClassMethod(rk_getMetaClass(_class), _originSelector);
    Method newMethod = class_getClassMethod(objc_getMetaClass(object_getClassName(_class)), _newSelector);
    
    if (class_addMethod(rk_getMetaClass(_class), _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(rk_getMetaClass(_class), _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

CG_INLINE void
rk_replaceInstanceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    if (_class == NULL ||
        _originSelector == NULL ||
        _newSelector == NULL) {
        return;
    }
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    
    if (class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

@interface HKRuntimeKitCommonDefines : NSObject

@end
