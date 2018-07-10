//
//  IOAUploadRequest.h
//  IOAMall
//
//  Created by Mac on 2018/2/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "IOARequest.h"

// 上传图片返回的模型
@interface IOAUploadResponseModel : NSObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *file;

@property (nonatomic, copy) NSString *file_name;

@end

@interface IOAUploadRequest : IOARequest
@property (nonatomic, strong) UIImage *image;

//获取上传进度
@property(nonatomic, copy) void(^uploadProgressBlock)(IOAUploadRequest *currentApi, NSProgress * progress);
@end

