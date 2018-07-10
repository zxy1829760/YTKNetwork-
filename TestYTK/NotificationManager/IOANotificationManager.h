//
//  IOAMessageManager.h
//  IOAMall
//
//  
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSString *kNotNetworkNotificationKey;

@interface IOANotificationManager : NSObject

// 无网络
+ (void)postNoNetworkNotification:(NSDictionary *)userInfo;

// 无网络
+ (void)addNoNetworkBoserver:(id)target selector:(SEL)selector;

+ (void)removeObservers:(id)target;
@end
