//
//  IOAApiManager.m
//  IOAMall
//
//  Created by Mac on 2018/1/31.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "IOAApiManager.h"
//#import "IOADataManager.h"
//#import "IOAUser.h"

typedef NS_ENUM(NSUInteger, ServerType) {
    kSeverTypeDev,     // 开发服务器地址
    kSeverTypeTest,     //测试服务器地址
    kSeverTypeRelease   //发布版服务器地址
};

@implementation IOAApiManager

+ (void)configNetwork {
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    [agent setValue:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/x-www-form-urlencodem", nil] forKeyPath:@"_manager.responseSerializer.acceptableContentTypes"];
    
    static ServerType serverType = kSeverTypeRelease;
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    switch (serverType) {
        case kSeverTypeDev:     // 开发服务器地址
            config.baseUrl = @"http://www.baidu.com";
            break;
        case kSeverTypeTest:     // 测试服务器地址
            config.baseUrl = @"http://www.baidu.com";
            break;
        case kSeverTypeRelease:   // 发布版服务器地址
            config.baseUrl = @"http://www.baidu.com";
            break;
        default:
            break;
    }
    //证书配置
    [self configHttps];
}

+ (void)configHttps {
    
    // 获取证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ssl_content" ofType:@"pem"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // 配置安全模式
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    //    config.cdnUrl = @"";
    
    // 验证公钥和证书的其他信息
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // 允许自建证书
    securityPolicy.allowInvalidCertificates = YES;
    
    // 校验域名信息
    securityPolicy.validatesDomainName = YES;
    
    // 添加服务器证书,单向验证;  可采用双证书 双向验证;
    securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    
    [config setSecurityPolicy:securityPolicy];
}

+ (NSMutableDictionary *)getCommomParametersWith:(NSString *)service token:(NSString *)token {
    if (service == nil) service = @"";
    if (token == nil) token = @"";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:token forKey:@"token"];
    [dic setObject:service forKey:@"service"];
    
    return dic;
}
const static NSString *AppApiVersion = @"Appv1";
+ (NSMutableDictionary *)getParametersWithService:(NSString *)service {
    if (service == nil) service = @"";
#if DEBUG
    // 接口版本控制
    NSArray *array = [service componentsSeparatedByString:@"."];
    NSMutableArray *serviceArray = [NSMutableArray arrayWithCapacity:array.count];
    [serviceArray addObject:AppApiVersion];
    for (int i=1; i<array.count; i++) {
        [serviceArray addObject:array[i]];
    }
    service = [serviceArray componentsJoinedByString:@"."];
#else
    NSArray *array = [service componentsSeparatedByString:@"."];
    NSMutableArray *serviceArray = [NSMutableArray arrayWithCapacity:array.count];
    [serviceArray addObject:AppApiVersion];
    for (int i=1; i<array.count; i++) {
        [serviceArray addObject:array[i]];
    }
    service = [serviceArray componentsJoinedByString:@"."];
#endif
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:service forKey:@"service"];
    
    return dic;
}

+ (void)startNetworkMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (void)stopNetworkMonitoring {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

+ (BOOL)isNetworkReachable {
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}
+ (AFNetworkReachabilityStatus)getNetworkStatus {
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

+ (void)saveToken:(NSString *)token {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if (token.length == 0) {
        [defaults removeObjectForKey:@"token"];
        [defaults synchronize];
        return;
    }
    [defaults setObject:token forKey:@"token"];
    [defaults synchronize];
}
+ (NSString *)getToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
//    IOADLog(@"token is %@", token);

    if (token) {
        return token;
    }
    else {
        return @"";
    }
}
@end
