//
//  PathTool.h
//  RecordingTest
//
//  Created by ParkHunter on 15/8/17.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PathTool : NSObject
+ (BOOL)createVideoFolderIfNotExist;
+ (NSString *)getVideoSaveFilePathString;
+ (NSString *)getVideoMergeFilePathString;
+ (NSString *)getVideoSaveFolderPathString;
+ (NSString *)documentFolder;
@end
