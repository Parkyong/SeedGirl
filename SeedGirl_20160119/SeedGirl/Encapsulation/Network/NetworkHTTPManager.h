//
//  NetworkClientManager.h
//  AFNetworkingDemo
//  功能描述 - 网络接口封装
//  Created by yulei on 15/4/23.
//  Copyright (c) 2015年 yulei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkHTTPManager : NSObject

+ (instancetype) manager;

#pragma mark - 网络基本设置

//获取服务器基本地址
- (NSString *)networkUrl;

#pragma mark - 基本http网络请求
/*
 函数注释 : 基本http请求，目前只支持post和get
 URLString : 传递请求地址，目前传递整个url地址，如果后期分布式另议
 Parameters : 传递数据，以字典方式传递key-value
 ResponseContentType : 接受参数以指定格式解析，主要针对network暂不支持的
 TimeoutInterval : 超时时间
 Success : block，成功返回请求数据
 Failure : block，失败返回错误信息
 */
//get方法
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure;
//get方法，可以设置响应类型
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                 responseType:(NSSet *)responseType
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure;

//post方法，默认30秒后超时
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;

//post方法，超时操作
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
               timeoutInterval:(NSTimeInterval)timeout
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;

//post方法，超时操作，设置响应类型
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
           responseContentType:(NSSet *)responseSet
               timeoutInterval:(NSTimeInterval)timeout
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;

@end
