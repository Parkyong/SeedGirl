//
//  LocalFileManager.m
//  AFNetworkingDemo
//
//  Created by yulei on 15/5/5.
//  Copyright (c) 2015年 yulei. All rights reserved.
//

#import "LocalFileManager.h"

@implementation LocalFileManager
@synthesize cacheFilePath,videoFilePath,tmpPath;

//缓存保存目录
static NSString *cacheFilePath() {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    
    NSString *dbPath = [directory stringByAppendingPathComponent:[[[NSBundle mainBundle] bundleIdentifier] stringByAppendingString:@".cache"]];
    [[NSFileManager defaultManager] createDirectoryAtPath:dbPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    return dbPath;
}

//视频保存目录
static NSString *videoFilePath() {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    
    NSString *dbPath = [directory stringByAppendingPathComponent:[[[NSBundle mainBundle] bundleIdentifier] stringByAppendingString:@".video"]];
    [[NSFileManager defaultManager] createDirectoryAtPath:dbPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    return dbPath;
}

+ (instancetype)manager {
    static LocalFileManager *manager = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        manager = [[self alloc] init];
        manager->cacheFilePath = cacheFilePath();
        manager->videoFilePath = videoFilePath();
        manager->tmpPath = NSTemporaryDirectory();
    });
    return manager;
}

//是否存在本地文件
- (BOOL)isExistFile:(NSString *)_filePath {
    BOOL status = NO;
    if([[NSFileManager defaultManager] fileExistsAtPath:_filePath]) {
        status = YES;
    }
    
    return status;
}

//删除本地文件
- (void)deleteFileWithTargetPath:(NSString *)_filePath {
//    if([[NSFileManager defaultManager] fileExistsAtPath:_filePath]) {
//        [[NSFileManager defaultManager] removeItemAtPath:_filePath error:nil];
//    }
    [[NSFileManager defaultManager] removeItemAtPath:_filePath error:nil];
}

//文件大小
- (unsigned long long)fileSizeForPath:(NSString *)_path {
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager]; // not thread safe
    if ([fileManager fileExistsAtPath:_path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:_path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

@end
