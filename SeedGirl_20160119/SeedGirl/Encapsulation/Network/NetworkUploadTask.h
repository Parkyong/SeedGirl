//
//  NetworkUploadTask.h
//  AFNetworkingDemo
//  功能描述 - 网络上传任务
//  Created by yulei on 15/7/23.
//  Copyright (c) 2015年 yulei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkUploadTask : NSObject

//初始化
- (instancetype)initWithURL:(NSString *)_url;

//创建任务 地址/指定文件地址
- (void)createDefaultUploadTask;

//创建后台任务 地址/指定文件地址
- (void)createBackgroundUploadTask:(NSString *)identifier;

//上传 Data数据
- (void)taskWithUploadData:(NSData *)_data;

//上传 file
- (void)taskWithUploadFilePath:(NSString *)_filePath;

//上传进度
- (NSProgress *)taskUploadProgress;

//上传完成
- (void)taskUploadCompletion:(void (^)())completion
                     Failure:(void (^)(NSError *error))failure;

//暂停
- (void)suspend;

//继续
- (void)resume;

//取消
- (void)cancel;

@end
