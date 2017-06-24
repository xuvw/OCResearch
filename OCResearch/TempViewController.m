//
//  TempViewController.m
//  OCResearch
//
//  Created by heke on 2012/5/22.
//  Copyright © 2012年 MX. All rights reserved.
//

#import "TempViewController.h"

NSString * printName(id self, SEL _cmd, NSString *oldName);

@interface TempViewController ()
{
    NSInteger age;
}
@end

@implementation TempViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIViewController *vc = [self performSelector:@selector(method:param1:param2:param3:)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSLog(@"%@:viewWillAppear",[self class]);
}

//https://developer.apple.com/reference/objectivec/objective_c_runtime?language=objc
//https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008048

@end
