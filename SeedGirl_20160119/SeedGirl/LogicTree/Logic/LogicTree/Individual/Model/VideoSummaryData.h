//
//  VideoSummaryData.h
//  SeedGirl
//  功能描述 - 视频概括数据
//  Created by Admin on 15/11/10.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoSummaryData : NSObject

//已录制制式视频总数
@property (assign, nonatomic) NSInteger videoCount;
//总计点播次数
@property (assign, nonatomic) NSInteger playCount;
//视频请求总数
@property (assign, nonatomic) NSInteger requestCount;
//接受请求总数
@property (assign, nonatomic) NSInteger acceptCount;
//制式视频累积获得钻石总数
@property (assign, nonatomic) NSInteger videoDiamondCount;
//自定义视频累计获得钻石总数
@property (assign, nonatomic) NSInteger customVideoDiamondCount;

//设置数据
- (void)setData:(id)_data;

@end
