//
//  SystemVideoData.m
//  SeedGirl
//
//  Created by Admin on 15/11/16.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "SystemVideoData.h"

@implementation SystemVideoData
@synthesize videoID,videoTitle,videoStatus,videoPrice,videoURL,videoThumbnail,videoPlayCount;

//设置数据
- (void)setData:(id)_data {
    if (_data == nil) {
        return ;
    }
    
    //视频请求ID
    id IDKey = [_data objectForKey:@"id"];
    if(IDKey != nil && IDKey != [NSNull null]) {
        videoID = IDKey;
    }
    IDKey = nil;
    
    //视频标题
    id titleKey = [_data objectForKey:@"title"];
    if(titleKey != nil && titleKey != [NSNull null]) {
        videoTitle = titleKey;
    }
    titleKey = nil;
    
    //视频状态
    id statusKey = [_data objectForKey:@"status"];
    if(statusKey != nil && statusKey != [NSNull null]) {
        videoStatus = [statusKey integerValue];
    }
    statusKey = nil;
    
    //视频价格
    id priceKey = [_data objectForKey:@"price"];
    if(priceKey != nil && priceKey != [NSNull null]) {
        videoPrice = [priceKey integerValue];
    }
    priceKey = nil;
    
    //视频地址
    id urlKey = [_data objectForKey:@"url"];
    if(urlKey != nil && urlKey != [NSNull null]) {
        videoURL = urlKey;
    }
    urlKey = nil;
    
    //视频缩略图
    id thumbnailKey = [_data objectForKey:@"thumbnail"];
    if(thumbnailKey != nil && thumbnailKey != [NSNull null]) {
        videoThumbnail = thumbnailKey;
    }
    thumbnailKey = nil;
    
    //视频播放次数
    id playCountKey = [_data objectForKey:@"playCount"];
    if(playCountKey != nil && playCountKey != [NSNull null]) {
        videoPlayCount = [playCountKey integerValue];
    }
    playCountKey = nil;
}

@end
