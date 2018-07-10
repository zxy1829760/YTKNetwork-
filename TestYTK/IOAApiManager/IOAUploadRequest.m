//
//  IOAUploadRequest.m
//  IOAMall
//
//  Created by Mac on 2018/2/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "IOAUploadRequest.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self


@implementation IOAUploadResponseModel

@end

@implementation IOAUploadRequest
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

//设置上传图片 所需要的 HTTP HEADER
- (AFConstructingBlock)constructingBodyBlock {
    UIImage *image = self.image;
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImagePNGRepresentation(image);
        NSString *name = @"file";
        NSString *fileName = @"upload";
        NSString *type = @"image/png";
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:type];
    };
}
#pragma mark 上传进度
- (AFURLSessionTaskProgressBlock) resumableUploadProgressBlock {
    WS(weakSelf);
    AFURLSessionTaskProgressBlock block = ^void(NSProgress * progress){
        if (_uploadProgressBlock) {
            _uploadProgressBlock(weakSelf, progress);
        }
    };
    return block;
}
@end
