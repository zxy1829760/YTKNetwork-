//
//  IOANetworkManager.m
//  IOAMall
//
//  Created by Mac on 2018/1/31.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "IOANetworkManager.h"

@implementation IOANetworkManager

+ (void)startNetworkMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (void)stopNetworkMonitoring {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

+ (BOOL)isReachable {
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}
+ (AFNetworkReachabilityStatus)getNetworkStatus {
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}
@end
