//
//  IOAResponse.m
//  IOAMall
//
//  Created by Mac on 2018/3/5.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "IOAResponse.h"
#import "IOARequest.h"

@implementation IOAResponse

+ (IOAResponse *)responseWithRequest:(IOARequest *)request {
    if (!request) return nil;
    IOAResponse *response = [IOAResponse new];
    [response updateStatusCodesWithRequest:request];
    
    return response;
}

- (void)updateStatusCodesWithRequest:(IOARequest *)request {
    NSInteger statusCode = [request responseStatusCode];
    self.requestResponseStatusCode = statusCode;
    self.responseMessage = @"服务器错误";
    
    if (statusCode > 200 && statusCode < 300) {
        self.responseStatusType = kResponseStatusTypeRequestError;
    }
    else {
        self.serverResponseStatusCode = request.serverResponseStatusCode;
        if (request.serverResponseStatusCode == 0) { // 后台服务错误
            if (request.serverResponseMessage.length) {
                self.responseMessage = request.serverResponseMessage;
            }
            self.responseStatusType = kResponseStatusTypeRequestError;
            return;
        }
        
        if (request.serverResponseStatusCode == 1) { // 没有网络
            self.responseMessage = @"没有网络";
            self.responseStatusType = kResponseStatusTypeNoNetwork;
            return;
        }
        
        self.responseMessage = request.serverResponseMessage;
        if (request.serverResponseStatusCode == 200) {
            self.responseMessage = request.serverResponseMessage;
            self.responseStatusType = kResponseStatusTypeSuccess;
            return;
        }
        if (request.serverResponseStatusCode == 400) {
            self.responseStatusType = kResponseStatusTypeRequestError;
            return;
        }
        if (request.serverResponseStatusCode > 400 && request.serverResponseStatusCode < 500) {
//            self.responseMessage = @"token 失效";
            self.responseStatusType = kResponseStatusTypeExpiryToken;

            return;
        }
        
        if (request.serverResponseStatusCode == 500) {
            self.responseStatusType = kResponseStatusTypeServerServiceError;
            return;
        }
        
        if (request.serverResponseStatusCode == 501) {
            self.responseStatusType = kResponseStatusTypeServerServiceError;
            return;
        }
        
        if (request.serverResponseStatusCode == 502) {
//            self.responseStatusType = kResponseStatusTypeDataNull;
            self.responseStatusType = kResponseStatusTypeServerServiceError;
            return;
        }
        
        if (request.serverResponseStatusCode == 600) {
            self.responseStatusType = kResponseStatusTypeNotLogin;
            return;
        }
    }
}

- (BOOL)alertOrNot {
    if (!(self.responseStatusType == kResponseStatusTypeNoNetwork ||
          self.responseStatusType == kResponseStatusTypeExpiryToken ||
          self.responseStatusType == kResponseStatusTypeDataNull)) {
        return YES;
    }
    
    return NO;
}

// 是否没有有网络
- (BOOL)isNoNetwork {
    if (self.responseStatusType == kResponseStatusTypeNoNetwork) {
        return YES;
    }
    
    return NO;
}

// 是否token失效
- (BOOL)isExpiryToken {
    if (self.responseStatusType == kResponseStatusTypeExpiryToken) {
        return YES;
    }
    
    return NO;
}

// 服务器错误
- (BOOL)isRequestServerError {
    if (self.responseStatusType == kResponseStatusTypeRequestError) {
        return YES;
    }
    
    return NO;
}

// 后台服务错误
- (BOOL)isServerServiceError {
    if (self.responseStatusType == kResponseStatusTypeServerServiceError) {
        return YES;
    }
    
    return NO;
}

// 该目标已存在
- (BOOL)isTargetExist {
    return NO;
}
@end
