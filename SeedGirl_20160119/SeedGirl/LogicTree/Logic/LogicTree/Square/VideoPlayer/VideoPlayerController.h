//
//  VideoPlayerController.h
//  SeedGirl
//  功能描述 - 视频播放器
//  Created by Admin on 15/12/10.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoData;

@interface VideoPlayerController : UIViewController

//视频信息
@property (nonatomic, strong) VideoData *videoData;

@end
