//
//  VideoPlayerControlView.h
//  SeedGirl
//  功能描述 - 视频播放器控制界面
//  Created by Admin on 15/12/14.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^VideoSliderBlock)(float value);

@interface VideoPlayerControlView : UIView

//关闭block
@property (nonatomic, copy) dispatch_block_t closeBlock;
//播放block
@property (nonatomic, copy) dispatch_block_t playBlock;
//暂停block
@property (nonatomic, copy) dispatch_block_t pauseBlock;
//聊天block
@property (nonatomic, copy) dispatch_block_t chatBlock;
//进度block
@property (nonatomic, copy) VideoSliderBlock sliderBlock;

//设置显示状态，0 准备播放，1 播放，2 暂停，3 结束
- (void)setControlState:(NSInteger)state;
//设置视频总时间
- (void)setVideoTotalTime:(CGFloat)time;
//设置视频当前时间
- (void)setVideoCurrentTime:(CGFloat)time;

@end
