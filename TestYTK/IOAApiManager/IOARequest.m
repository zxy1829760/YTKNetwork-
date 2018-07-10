//
//  IOARequest.m
//  IOAMall
//
//  Created by Mac on 2018/1/31.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "IOARequest.h"

@interface IOARequest ()
@property (nonatomic, readwrite, assign) NSInteger serverResponseStatusCode;
@property (nonatomic, readwrite, assign) NSInteger serverRequestStatusCode;

@property (nonatomic, readwrite, copy) NSString *serverResponseMessage;
@end

@implementation IOARequest

- (void)dealloc {
    
}
- (NSTimeInterval)requestTimeoutInterval {
    return 30.0;
}
- (YTKRequestMethod)requestMethod {
#ifdef DEBUG
    return YTKRequestMethodGET;
#else
    return YTKRequestMethodPOST;
#endif

//    return YTKRequestMethodPOST;
//    return YTKRequestMethodGET;
}

//- (YTKRequestSerializerType)requestSerializerType {
//    return YTKRequestSerializerTypeJSON;
//}

- (void)startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success
                                    failure:(YTKRequestCompletionBlock)failure {
    if (![IOAApiManager isNetworkReachable]) {
        self.serverResponseStatusCode = 1; // 没网络
        [IOANotificationManager postNoNetworkNotification:nil];
        if (failure) {
            failure(self);
        }
        return;
    }
    
//    WS(weakSelf);
    [self setCompletionBlockWithSuccess:success failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request);
//            return;
        }
#if DEBUG
//        if (!request.responseObject)
//            [weakSelf testAlertInfo:@"解析失败"];
#endif
    }];
    [self start];
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    NSString *token = [IOAApiManager getToken];
//    NSString *user_id = [IOADataManager getUserInfo].user_id;
//    user_id = user_id ?: @"";

//      token =@"fa205d7bbb5ea7558a432842808e1f9b";
    if (token.length == 0) {
        return nil;
    }
    return @{@"Authorization": token,
//             @"user_id": user_id
             };
}

- (BOOL)statusCodeValidator {
#if DEBUG
#endif
    
    BOOL isOk = [super statusCodeValidator];
    //    NSInteger statusCode = [self responseStatusCode];
    //    return (statusCode >= 200 && statusCode <= 299);
    if (!isOk) {
#if DEBUG
        [self testAlertInfo:@"网络请求错误"];
#endif
        
        return isOk;
    }
    
    if (!self.responseObject) {
#if DEBUG
//        [self testAlertInfo:@"后台服务错误"];
#endif
        
        self.serverResponseStatusCode = 0;
        return NO;
    }

    self.serverResponseStatusCode = [self.responseObject[@"ret"] integerValue];
    self.serverRequestStatusCode = [self.responseObject[@"code"] integerValue];
    self.serverResponseMessage = self.responseObject[@"msg"];
    
    if (self.serverResponseStatusCode == 200) {
        return YES;
    }
    else if (self.serverResponseStatusCode > 400 && self.serverResponseStatusCode < 500) {
        [IOAApiManager saveToken:nil];
        
        
//        [IOADataManager removeUserInfo];
//        [IOANotificationManager postUserLogoutNotification:YES];
        
#if DEBUG
//        [self testAlertInfo:@"token 失效"];
#endif
        
        return NO;
    }
#if DEBUG
//    [self testAlertInfo:@"后台服务错误"];
#endif
    return NO;
}

#if DEBUG
- (void)testAlertInfo:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        //        [[UIApplication sharedApplication].keyWindow makeToast:self.serverResponseMessage];
//        [[UIApplication sharedApplication].keyWindow.rootViewController showAlertWithTitle:title detail:self.serverResponseMessage clickBlock:nil];
    });
}
#endif
@end
