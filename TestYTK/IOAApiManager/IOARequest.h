//
//  IOARequest.h
//  IOAMall
//
//  Created by Mac on 2018/1/31.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <YTKNetwork.h>
#import "IOAApiManager.h"
//#import "IOADataManager.h"
#import "IOANotificationManager.h"
#import "IOAResponse.h"


@interface IOARequest : YTKRequest
//返回接口状态码，其中：200 成功，
//                  600 未登录
//                  500 服务器错误
//                  501 已经存在
//                  502 数据接口为空
//                  400 请求参数有错，
//                  401 非法请求，
//                  1 没有网络
//                  0 服务后台问题，可使用response的statuscode查询具体问题

@property (nonatomic, readonly, assign) NSInteger serverResponseStatusCode;

//返回请求状态码，其中：1正常，0不正常
@property (nonatomic, readonly, assign) NSInteger serverRequestStatusCode;

// 返回的提示信息
@property (nonatomic, readonly, copy) NSString *serverResponseMessage;

// 如果没有网络 failure同步方式返回
- (void)startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success
                                    failure:(YTKRequestCompletionBlock)failure;
@end
