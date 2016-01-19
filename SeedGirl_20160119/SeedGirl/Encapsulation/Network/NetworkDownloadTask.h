//
//  NetworkDownloadTask.h
//  AFNetworkingDemo
//  功能描述 - 网络下载任务
//  Created by yulei on 15/7/23.
//  Copyright (c) 2015年 yulei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DownloadCompletionBlock)(NSURL *filePath);
typedef void(^DownloadFailureBlock)(NSError *error);

@interface NetworkDownloadTask : NSObject

//完成block
@property (copy, nonatomic) DownloadCompletionBlock completionBlock;
//结束block
@property (copy, nonatomic) DownloadFailureBlock failureBlock;

//初始化
//parmeters : 请求/保存地址/是否缓存
- (instancetype)initWithRequest:(NSURLRequest *)_request
                     targetPath:(NSString *)_filePath
                   shouldResume:(BOOL)_status;

//创建普通下载任务
- (void)defaultDownloadTask;

//创建后台下载任务
- (void)backgroundDownloadTask:(NSString *)identifier;

//下载进度
- (void)downloadTaskProgress:(void(^)(int64_t bytesWritten,
                                      int64_t totalBytesWritten,
                                      int64_t totalBytesExpectedToWrite))progressBlock;

//下载进度
- (NSProgress *)downloadTaskProgress;

//下载完成
- (void)downloadTaskCompletion:(void (^)(NSURL *filePath))completion
                       Failure:(void (^)(NSError *error))failure;

//暂停
- (void)suspend;

//继续
- (void)resume;

//取消
- (void)cancel;

@end
