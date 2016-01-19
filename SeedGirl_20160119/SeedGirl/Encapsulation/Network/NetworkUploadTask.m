//
//  NetworkUploadTask.m
//  AFNetworkingDemo
//
//  Created by yulei on 15/7/23.
//  Copyright (c) 2015年 yulei. All rights reserved.
//

#import "NetworkUploadTask.h"
#import "AFNetworking.h"

@interface NetworkUploadTask ()

//session
@property (strong, nonatomic) AFURLSessionManager *sessionManager;
//请求地址
@property (copy, nonatomic) NSString *taskURL;
//上传任务
@property (strong, nonatomic) NSURLSessionUploadTask *uploadTask;

@end

@implementation NetworkUploadTask

#pragma mark - Private Interface

#pragma mark - Common Interface

//初始化
- (instancetype)initWithURL:(NSString *)_url {
    if (self = [super init]) {
        self.taskURL = _url;
    }
    return self;
}

//创建任务 地址/指定文件地址
- (void)createDefaultUploadTask {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
}

//创建后台任务 地址/指定文件地址
- (void)createBackgroundUploadTask:(NSString *)identifier {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:identifier];
    self.sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
}

//上传 Data数据
- (void)taskWithUploadData:(NSData *)_data {
    NSURL *tmp_url = [NSURL URLWithString:[self.taskURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *taskRequest = [NSURLRequest requestWithURL:tmp_url];
    
    self.uploadTask = [self.sessionManager uploadTaskWithRequest:taskRequest fromData:_data progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error == nil) {
            NSLog(@"upload data is %@",responseObject);
        } else {
            NSLog(@"error is %@",[error localizedDescription]);
        }
    }];
}

//上传 file
- (void)taskWithUploadFilePath:(NSString *)_filePath {
    NSURL *tmp_url = [NSURL URLWithString:[self.taskURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *taskRequest = [NSURLRequest requestWithURL:tmp_url];
    
    NSURL *filePathURL = [NSURL fileURLWithPath:_filePath];
    
    self.uploadTask = [self.sessionManager uploadTaskWithRequest:taskRequest fromFile:filePathURL progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error == nil) {
            NSLog(@"upload data is %@",responseObject);
        } else {
            NSLog(@"error is %@",[error localizedDescription]);
        }
    }];
}

//上传进度
- (NSProgress *)taskUploadProgress {
    return [self.sessionManager uploadProgressForTask:self.uploadTask];
}

//上传完成
- (void)taskUploadCompletion:(void (^)())completion
                     Failure:(void (^)(NSError *error))failure {

}

//暂停
- (void)suspend {
    if (self.uploadTask.state == NSURLSessionTaskStateRunning) {
        [self.uploadTask suspend];
    }
}

//继续
- (void)resume {
    if (self.uploadTask.state == NSURLSessionTaskStateSuspended) {
        [self.uploadTask resume];
    }
}

//取消
- (void)cancel {
    if (self.uploadTask.state == NSURLSessionTaskStateRunning) {
        [self.uploadTask cancel];
    }
}

@end
