//
//  VideoRequestHeaderView.h
//  SeedGirl
//  功能描述 - 视频请求头视图
//  Created by Admin on 15/11/16.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoSummaryData;

@interface VideoRequestHeaderView : UIView

//设置显示数据
- (void)setShowData:(VideoSummaryData *)data;

@end
