//
//  VideoRequestData.h
//  SeedGirl
//  功能描述 - 视频请求数据
//  Created by Admin on 15/11/12.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoRequestData : NSObject

//视频请求ID
@property (nonatomic, copy) NSString *requestID;
//请求用户昵称
@property (nonatomic, copy) NSString *userName;
//请求用户头像
@property (nonatomic, copy) NSString *userIcon;
//请求时间
@property (nonatomic, copy) NSString *requestTime;
//请求内容
@property (nonatomic, copy) NSString *requestMessage;
//请求花费钻石数
@property (nonatomic, assign) NSInteger requestCost;
//请求状态
@property (nonatomic, assign) NSInteger requestStatus;
//请求理由
@property (nonatomic, copy) NSString *requestRefuseReason;

//设置数据
- (void)setData:(id)_data;

@end
