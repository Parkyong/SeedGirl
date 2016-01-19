//
//  NetworkHTTPManager.m
//  AFNetworkingDemo
//
//  Created by yulei on 15/4/23.
//  Copyright (c) 2015年 yulei. All rights reserved.
//

#import "NetworkHTTPManager.h"
#import "AFNetworking.h"

//网络测试地址
#define DebugNetworkUrl @"http://seedsocial.tinyconn.mockable.io/"
//网络正式地址
#define ReleaseNetworkUrl @"http://seedsocial.chumob.com/girl.php/Index/"

@interface NetworkHTTPManager ()

@end

@implementation NetworkHTTPManager

+ (instancetype) manager {
    static NetworkHTTPManager *manager = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

#pragma mark - 网络基本设置

//获取服务器基本地址
- (NSString *)networkUrl {
//    return DebugNetworkUrl;
    return ReleaseNetworkUrl;
}

#pragma mark - 基本http网络请求
//get方法
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure {
    return [self GET:URLString parameters:parameters responseType:nil success:success failure:failure];
}
//get方法，可以设置响应类型
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                 responseType:(NSSet *)responseType
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    NSString *urlString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (responseType != nil) {
        sessionManager.responseSerializer.acceptableContentTypes = responseType;
    }
    
    NSURLSessionDataTask *dataTask = [sessionManager GET:urlString
                                              parameters:parameters
                                                 success:^(NSURLSessionDataTask *task, id responseObject) {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         success(responseObject);
                                                     });
                                                 }
                                                 failure:^(NSURLSessionDataTask * task, NSError *error) {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         failure(error);
                                                     });
                                                 }];
    return dataTask;
}

//post方法
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                sessionManager:(AFHTTPSessionManager*)sessionManager
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure {
    
    
    if (sessionManager == nil) {
        return nil;
    }
    
    NSString *urlString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask *dataTask = [sessionManager POST:urlString
                                               parameters:parameters
                                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          success(responseObject);
                                                      });
                                                  }
                                                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          failure(error);
                                                      });
                                                  }];
    return dataTask;
}
//post方法，默认30秒后超时
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure {
    return [self POST:URLString parameters:parameters timeoutInterval:30 success:success failure:failure];
}
//post方法，超时操作
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
               timeoutInterval:(NSTimeInterval)timeout
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager.requestSerializer setTimeoutInterval:timeout];
    return [self POST:URLString sessionManager:sessionManager parameters:parameters success:success failure:failure];
}

//post方法，超时操作，设置响应类型
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
           responseContentType:(NSSet *)responseSet
               timeoutInterval:(NSTimeInterval)timeout
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager.requestSerializer setTimeoutInterval:timeout];
    [sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [sessionManager.responseSerializer setAcceptableContentTypes:responseSet];
    
    return [self POST:URLString sessionManager:sessionManager parameters:parameters success:success failure:failure];
}

@end
