//
//  PhotographViewController.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/17.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemVideoData.h"
typedef NS_ENUM(NSInteger, CameraViewType){
    CAMERAVIEW= 0,          //只显示照相功能
    RECORDVIEW,             //只显示摄像功能
    CAMERAANDRECORDVIEW     //同时显示照相摄像功能
};

@interface PhotographViewController : UIViewController
@property (nonatomic, assign) BOOL              isPushStyle;   //模态进入 navigation进入
@property (nonatomic, assign) BOOL        isChangeHeadImage;   //是否更换头像
@property (nonatomic, assign) CameraViewType       viewType;   //主页显示类型
@property (nonatomic, strong) UIViewController *tempPointer;   //暂存指针
@property (nonatomic, strong) SystemVideoData    *videoData;   //暂存数据
@end