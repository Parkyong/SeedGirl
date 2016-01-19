//
//  IndividualVideoHeaderView.h
//  SeedGirl
//  功能描述 - 个人视频试图header
//  Created by Admin on 15/11/10.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoSummaryData;

@interface IndividualVideoHeaderView : UIView
//设置显示数据
- (void)setShowData:(VideoSummaryData *)data;
- (void)setShowDefaultData;
@end
