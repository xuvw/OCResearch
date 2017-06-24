//
//  UIImage+RuntimeKit.m
//  OCResearch
//
//  Created by heke on 2012/6/16.
//  Copyright © 2012年 MX. All rights reserved.
//

#import "UIImage+RuntimeKit.h"
#import "HKRuntimeKitCore.h"


@implementation UIImage (RuntimeKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rk_replaceClassMethod([self class],
                      @selector(imageNamed:),
                      @selector(rk_imageNamed:));
        
        rk_replaceClassMethod([self class],
                      @selector(imageWithContentsOfFile:),
                      @selector(rk_imageWithContentsOfFile:));
    });
}

+ (UIImage *)rk_imageNamed:(NSString *)imageName {
    UIImage *image = nil;
    if (imageName.length < 1) {
        image = nil;
    }else {
        image = [UIImage rk_imageNamed:imageName];
    }

    if (!image) {
        NSLog(@"rk:图片：`name:%@`加载失败",imageName);
    }
    return image;
}

+ (UIImage *)rk_imageWithContentsOfFile:(NSString *)path {
    UIImage *image = nil;
    if (path.length > 0) {
        image = [UIImage rk_imageWithContentsOfFile:path];
    }
    
    if (!image) {
        NSLog(@"rk:图片：`path：%@`加载失败",path);
    }
    
    return image;
}

@end
