//
//  SystemVideoData.h
//  SeedGirl
//  功能描述 - 系统视频数据
//  Created by Admin on 15/11/16.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemVideoData : NSObject

//视频请求ID
@property (nonatomic, copy) NSString *videoID;
//视频标题
@property (nonatomic, copy) NSString *videoTitle;
//视频状态
@property (nonatomic, assign) NSInteger videoStatus;
//视频价格
@property (nonatomic, assign) NSInteger videoPrice;
//视频地址
@property (nonatomic, copy) NSString *videoURL;
//视频缩略图
@property (nonatomic, copy) NSString *videoThumbnail;
//视频播放次数
@property (nonatomic, assign) NSInteger videoPlayCount;

//设置数据
- (void)setData:(id)_data;

@end
