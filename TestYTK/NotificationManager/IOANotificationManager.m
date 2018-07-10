//
//  IOAMessageManager.m
//  IOAMall
//
//  
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "IOANotificationManager.h"

const NSString *kNotNetworkNotificationKey = @"com.ioa.NoNetwork";

@implementation IOANotificationManager

+ (void)postNoNetworkNotification:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)kNotNetworkNotificationKey object:nil userInfo:userInfo];
}


// 无网络
+ (void)addNoNetworkBoserver:(id)target selector:(SEL)selector {
    if (target) {
        [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:(NSString *)kNotNetworkNotificationKey object:nil];
    }
}

+ (void)removeObservers:(id)target {
    [[NSNotificationCenter defaultCenter] removeObserver:target];
}
@end
