//
//  LocalFileManager.h
//  AFNetworkingDemo
//  功能描述 - 本地文件管理
//  Created by yulei on 15/5/5.
//  Copyright (c) 2015年 yulei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalFileManager : NSObject

//缓存路径
@property (copy, nonatomic) NSString *cacheFilePath;
//视频路径
@property (copy, nonatomic) NSString *videoFilePath;
//缓存路径
@property (copy, nonatomic) NSString *tmpPath;

+ (instancetype) manager;

//是否存在本地文件
- (BOOL)isExistFile:(NSString *)_filePath;

//删除本地文件
- (void)deleteFileWithTargetPath:(NSString *)_filePath;

//文件大小
- (unsigned long long)fileSizeForPath:(NSString *)_path;

@end
