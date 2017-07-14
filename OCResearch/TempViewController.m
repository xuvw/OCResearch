//
//  TempViewController.m
//  OCResearch
//
//  Created by heke on 2012/5/22.
//  Copyright © 2012年 MX. All rights reserved.
//

#import "TempViewController.h"
#import "NSObject+AvoidCrash.h"

#import "fishhook.h"

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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 100, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    __weak typeof(self)weakSelf = self;
    
    [self addDeallocJob:^{
        NSLog(@"class:%@ dealloc",NSStringFromClass([weakSelf class]));
    }];
}

- (void)push {
    TempViewController *vc = [[TempViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSLog(@"%@:viewWillAppear",[self class]);
    [NSArray arrayWithObjects:nil count:0];
    
    [UIView transitionWithView:[UIApplication sharedApplication].delegate.window duration:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView transitionFromView:self.view toView:self.view duration:1 options:UIViewAnimationOptionCurveEaseIn completion:^(BOOL finished) {
        
    }];
}

//https://developer.apple.com/reference/objectivec/objective_c_runtime?language=objc
//https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008048

@end
