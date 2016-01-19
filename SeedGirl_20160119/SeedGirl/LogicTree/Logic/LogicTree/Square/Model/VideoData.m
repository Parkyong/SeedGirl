//
//  VideoData.m
//  SeedGirl
//
//  Created by Admin on 15/10/29.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoData.h"

@implementation VideoData
@synthesize userName,videoURL,videoThumbnail,videoWidth,videoHeight,watchCount;

//设置数据
- (void)setData:(id)_data {
    if (_data == nil) {
        return ;
    }

    //发布用户昵称
    id userNameKey = [_data objectForKey:@"userName"];
    if(userNameKey != nil && userNameKey != [NSNull null]) {
        userName = userNameKey;
    }
    userNameKey = nil;

    //发布视频列表
    id videoURLKey = [_data objectForKey:@"url"];
    if(videoURLKey != nil && videoURLKey != [NSNull null]) {
        videoURL = videoURLKey;
    }
    videoURLKey = nil;
    
    //发布视频缩略图
    id videoThumbnailKey = [_data objectForKey:@"thumbnail"];
    if(videoThumbnailKey != nil && videoThumbnailKey != [NSNull null]) {
        videoThumbnail = videoThumbnailKey;
    }
    videoThumbnailKey = nil;
    
    //视频宽度
    id videoWidthKey = [_data objectForKey:@"width"];
    if(videoWidthKey != nil && videoWidthKey != [NSNull null]) {
        videoWidth = [videoWidthKey floatValue];
    }
    videoWidthKey = nil;

    //视频高度
    id videoHeightKey = [_data objectForKey:@"height"];
    if(videoHeightKey != nil && videoHeightKey != [NSNull null]) {
        videoHeight = [videoHeightKey floatValue];
    }
    videoHeightKey = nil;
    
    //观察总数
    id watchCountKey = [_data objectForKey:@"watchCount"];
    if(watchCountKey != nil && watchCountKey != [NSNull null]) {
        watchCount = [watchCountKey integerValue];
    }
    watchCountKey = nil;
}

@end
