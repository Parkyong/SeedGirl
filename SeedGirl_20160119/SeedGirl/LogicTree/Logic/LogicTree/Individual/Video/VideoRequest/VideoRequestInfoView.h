//
//  VideoRequestInfoView.h
//  SeedGirl
//  功能描述 - 视频请求详情视图
//  Created by Admin on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoRequestData;

@interface VideoRequestInfoView : UIScrollView

//接受block
@property (nonatomic, copy) dispatch_block_t acceptBlock;
//拒绝block
@property (nonatomic, copy) dispatch_block_t refuseBlock;

//设置显示数据
- (void)setShowData:(VideoRequestData *)data;

@end
