//
//  VideoSummaryData.m
//  SeedGirl
//
//  Created by Admin on 15/11/10.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoSummaryData.h"

@implementation VideoSummaryData
@synthesize videoCount,playCount,requestCount,acceptCount,videoDiamondCount,customVideoDiamondCount;

//设置数据
- (void)setData:(id)_data {
    if (_data == nil) {
        return ;
    }

    //已录制制式视频总数
    id videoCountKey = [_data objectForKey:@"videoCount"];
    if(videoCountKey != nil && videoCountKey != [NSNull null]) {
        videoCount = [videoCountKey integerValue];
    }
    videoCountKey = nil;
    
    //总计点播次数
    id playCountKey = [_data objectForKey:@"playCount"];
    if(playCountKey != nil && playCountKey != [NSNull null]) {
        playCount = [playCountKey integerValue];
    }
    playCountKey = nil;
    
    //视频请求总数
    id requestCountKey = [_data objectForKey:@"requestCount"];
    if(requestCountKey != nil && requestCountKey != [NSNull null]) {
        requestCount = [requestCountKey integerValue];
    }
    requestCountKey = nil;
    
    //接受请求总数
    id acceptCountKey = [_data objectForKey:@"acceptCount"];
    if(acceptCountKey != nil && acceptCountKey != [NSNull null]) {
        acceptCount = [acceptCountKey integerValue];
    }
    acceptCountKey = nil;
    
    //制式视频累积获得钻石总数
    id videoDiamondCountKey = [_data objectForKey:@"videoDiamondCount"];
    if(videoDiamondCountKey != nil && videoDiamondCountKey != [NSNull null]) {
        videoDiamondCount = [videoDiamondCountKey integerValue];
    }
    videoDiamondCountKey = nil;

    //自定义视频累计获得钻石总数
    id customVideoDiamondCountKey = [_data objectForKey:@"customVideoDiamondCount"];
    if(customVideoDiamondCountKey != nil && customVideoDiamondCountKey != [NSNull null]) {
        customVideoDiamondCount = [customVideoDiamondCountKey integerValue];
    }
    customVideoDiamondCountKey = nil;
}

@end
