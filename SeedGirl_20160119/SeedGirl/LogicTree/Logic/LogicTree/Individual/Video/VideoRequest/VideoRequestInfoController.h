//
//  VideoRequestInfoController.h
//  SeedGirl
//  功能描述 - 个人视频请求详细信息控制器
//  Created by Admin on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSubViewController.h"
#import "VideoRequestData.h"

@interface VideoRequestInfoController : BaseSubViewController
//视频请求数据
@property (nonatomic, strong) VideoRequestData *requestData;
@property (nonatomic, copy)   dispatch_block_t  returnBlcok;
@end
