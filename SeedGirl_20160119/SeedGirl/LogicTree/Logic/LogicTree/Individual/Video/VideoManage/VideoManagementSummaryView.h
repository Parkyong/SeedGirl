//
//  VideoManagementSummaryView.h
//  SeedGirl
//  功能描述 - 视频管理概括头视图
//  Created by Admin on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoSummaryData;

@interface VideoManagementSummaryView : UIView

//设置显示数据
- (void)setShowData:(VideoSummaryData *)data;

@end
