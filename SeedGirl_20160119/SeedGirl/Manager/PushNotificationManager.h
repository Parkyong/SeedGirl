//
//  PushNotificationManager.h
//  SeedGirl
//
//  Created by Admin on 15/12/1.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushNotificationManager : NSObject
//是否存在视频请求新消息
@property (nonatomic, assign) BOOL hasNewVideoRequestMessage;
//是否存在纸条新消息
@property (nonatomic, assign) BOOL hasNewNoteMessage;

+ (instancetype)manager;

//接收通知信息
- (void)remoteNotificationMessage:(NSDictionary *)userInfo;
//添加标记数量
- (void)addIconBadgeNumber;
//清除标记数量
- (void)clearIconBadgeNumer;

//判断是否是新的视频请求
- (BOOL)isNewVideoRequest:(NSString *)requestID;
//增加新的视频请求
- (BOOL)addVideoRequestID:(NSString *)requestID;
//移除新的视频请求
- (void)removeVideoRequestID:(NSString *)requestID;

@end
