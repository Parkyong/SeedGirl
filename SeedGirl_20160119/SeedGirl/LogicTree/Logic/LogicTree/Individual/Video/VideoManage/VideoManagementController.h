//
//  VideoManagementController.h
//  SeedGirl
//  功能描述 - 视频管理视图控制器
//  Created by Admin on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSubViewController.h"

@class VideoManagementView;

@interface VideoManagementController : BaseSubViewController
@property (nonatomic, strong) VideoManagementView *videoManagementView;
@end
