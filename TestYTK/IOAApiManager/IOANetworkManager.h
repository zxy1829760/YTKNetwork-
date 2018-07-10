//
//  IOANetworkManager.h
//  IOAMall
//
//  Created by Mac on 2018/1/31.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <AFNetworking.h>

@interface IOANetworkManager : NSObject

+ (void)startNetworkMonitoring;
+ (void)stopNetworkMonitoring;
+ (BOOL)isReachable;
+ (AFNetworkReachabilityStatus)getNetworkStatus;
@end
