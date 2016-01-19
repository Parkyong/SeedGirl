//
//  SkimVideoViewController.h
//  SeedGirl
//
//  Created by ParkHunter on 15/10/14.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemVideoData.h"
@interface SkimVideoViewController : UIViewController
@property (nonatomic, strong) NSURL            *videoUrl;
@property (nonatomic, strong) UIImage        *coverImage;     //封面图片
@property (nonatomic, strong) SystemVideoData *videoData;     //暂存数据
@end
