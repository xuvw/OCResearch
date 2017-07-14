//
//  main.m
//  OCResearch
//
//  Created by heke on 2012/5/22.
//  Copyright © 2012年 MX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "fishhook.h"

void (*ori_NSLog)(NSString *format, va_list args);

void my_NSLog(NSString *format, va_list args) {
    ori_NSLog(format,args);
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        rebind_symbols((struct rebinding[1]){{"NSLog", my_NSLog, (void *)&ori_NSLog}}, 1);
        NSLog(@"Good");
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
