//
//  IOAApiManager.h
//  IOAMall
//
//  Created by Mac on 2018/1/31.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <YTKNetwork.h>
#import <AFNetworking.h>

@interface IOAApiManager : NSObject
+ (void)configNetwork;
//+ (NSString *)getService;
//+ (NSString *)getToken;
+ (NSMutableDictionary *)getCommomParametersWith:(NSString *)service token:(NSString *)token;
+ (NSMutableDictionary *)getParametersWithService:(NSString *)service;

+ (void)startNetworkMonitoring;
+ (void)stopNetworkMonitoring;
+ (BOOL)isNetworkReachable;
+ (AFNetworkReachabilityStatus)getNetworkStatus;

+ (void)saveToken:(NSString *)token;
+ (NSString *)getToken;
@end
