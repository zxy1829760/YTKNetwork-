//
//  IOAResponse.h
//  IOAMall
//
//  Created by Mac on 2018/3/5.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ResponseStatusType) {
    kResponseStatusTypeRequestError = 0, // 服务后台问题
    kResponseStatusTypeNoNetwork = 1, // 没有网络
    kResponseStatusTypeSuccess = 200,
    kResponseStatusTypeExpiryToken = 401,
    kResponseStatusTypeServerServiceError = 500,
//    kResponseStatustypeServiceExist = 501,
    kResponseStatusTypeDataNull = 502,
    kResponseStatusTypeNotLogin = 600,
};

@class IOARequest;

@interface IOAResponse : NSObject
@property (nonatomic, assign) BOOL success;
//返回接口状态码，其中：200 成功，
//                  600 未登录
//                  500 服务器错误
//                  501 已经存在
//                  502 数据接口为空
//                  400 请求参数有错，
//                  401 非法请求，
//                  1 没有网络
//                  0 服务后台问题，可使用response的statuscode查询具体问题
@property (nonatomic, assign) ResponseStatusType responseStatusType;
@property (nonatomic, assign) NSInteger serverResponseStatusCode; // 服务端返回的status code
@property (nonatomic, assign) NSInteger requestResponseStatusCode; // 请求返回的status code

@property (nonatomic, strong) id responseObject;

@property (nonatomic, copy) NSString *responseMessage;

+ (IOAResponse *)responseWithRequest:(IOARequest *)request;

- (void)updateStatusCodesWithRequest:(IOARequest *)request;

// 是否需要提示
- (BOOL)alertOrNot;
// 是否没有有网络
- (BOOL)isNoNetwork;

// 是否token失效
- (BOOL)isExpiryToken;

// 服务器错误
- (BOOL)isRequestServerError;

// 后台服务错误
- (BOOL)isServerServiceError;

// 该目标已存在
- (BOOL)isTargetExist;
@end
