//
//  ConcurrentViewController.m
//  OCResearch
//
//  Created by heke on 2012/6/8.
//  Copyright © 2012年 MX. All rights reserved.
//

#import "ConcurrentViewController.h"
#import <pthread.h>

//http://blog.csdn.net/cqupt_chen/article/details/8055215

#define HKSafe(BlockName,...) ( !BlockName ? nil : BlockName(__VA_ARGS__); )
#define HKPrintf(x) printf("sqaure of " #x " is %d.\n", (x) * (x))
#define HKName(n) x##n

@interface ConcurrentViewController ()

@end

@implementation ConcurrentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    //##@synchronized
//    NSObject *obj = [[NSObject alloc] init];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        @synchronized (obj) {
//            NSLog(@"1");
//            sleep(2);
//            NSLog(@"2");
//        }
//    });
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        @synchronized (obj) {
//            NSLog(@"3");
//            sleep(2);
//            NSLog(@"4");
//        }
//    });
    //##dispatch_semaphore_t
//    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
//    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_semaphore_wait(signal, overTime);
//        NSLog(@"1");
//        sleep(2);
//        NSLog(@"2");
//        dispatch_semaphore_signal(signal);
//    });
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        sleep(1);
//        dispatch_semaphore_wait(signal, overTime);
//        NSLog(@"3");
//        
//        NSLog(@"4");
//        dispatch_semaphore_signal(signal);
//    });
    //##NSLock
//    NSLock *lock = [[NSLock alloc] init];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [lock lock];
//        NSLog(@"1");
//        sleep(2);
//        NSLog(@"2");
//        [lock unlock];
//    });
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        sleep(1);
//        [lock lock];
//        NSLog(@"3");
//        
//        NSLog(@"4");
//        [lock unlock];
//    });
//    NSRecursiveLock *lock = [[NSRecursiveLock alloc] init];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [lock lock];
//        NSLog(@"1");
//        sleep(2);
//        NSLog(@"2");
//        [lock unlock];
//    });
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        sleep(1);
//        [lock lock];
//        NSLog(@"3");
//        
//        NSLog(@"4");
//        [lock unlock];
//    });
//    static void(^RecursizeMethod)(int);
//    RecursizeMethod = ^(int value){
//        [lock lock];
//        if (value > 0) {
//            NSLog(@"value = %d",value);
//            sleep(1);
//            RecursizeMethod(value-1);
//        }
//        [lock unlock];
//    };
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        RecursizeMethod(6);
//    });
    //##NSConditionLock
//    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:9];
//    NSMutableArray *products = [NSMutableArray array];
//    NSInteger HAS_DATA = 10;
//    NSInteger NO_DATA = 9;
//    
//    //生产
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        while (1) {
//            [lock lockWhenCondition:NO_DATA];
//            [products addObject:[[NSObject alloc] init]];
//            NSLog(@"produce a product,总量:%zi",products.count);
//            [lock unlockWithCondition:HAS_DATA];
//            sleep(1);
//        }
//    });
//    
//    //消费
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        while (1) {
//            NSLog(@"wait for product");
//            [lock lockWhenCondition:HAS_DATA];
//            [products removeObjectAtIndex:0];
//            NSLog(@"custome a product");
//            [lock unlockWithCondition:NO_DATA]; 
//        } 
//    });
    
    //##NSCondition
//    NSCondition *condition = [[NSCondition alloc] init];
//    NSMutableArray *products = [NSMutableArray array];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        while (1) {
//            [condition lock];
//            if ([products count] == 0) {
//                NSLog(@"wait for product");
//                [condition wait];
//            }
//            [products removeObjectAtIndex:0];
//            NSLog(@"custome a product");
//            [condition unlock];
//        }
//    });
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        while (1) {
//            [condition lock];
//            [products addObject:[[NSObject alloc] init]];
//            NSLog(@"produce a product,总量:%zi",products.count);
//            [condition signal];
//            [condition unlock]; 
//            sleep(1); 
//        }
//    });
    
    //##pthread_mutex_t
//    __block pthread_mutex_t theLock;
//    pthread_mutex_init(&theLock, NULL);
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        pthread_mutex_lock(&theLock);
//        NSLog(@"thread1 start");
//        sleep(3);
//        NSLog(@"thread1 end");
//        pthread_mutex_unlock(&theLock);
//        
//    });
//    
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        pthread_mutex_lock(&theLock);
//        sleep(3);
//        NSLog(@"thread2 start");
//        NSLog(@"thread2 end");
//        pthread_mutex_unlock(&theLock);
//    });
//    NSNotificationQueue;
}

@end
