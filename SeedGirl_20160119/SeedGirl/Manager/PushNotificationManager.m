//
//  PushNotificationManager.m
//  SeedGirl
//
//  Created by Admin on 15/12/1.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "PushNotificationManager.h"

@interface PushNotificationManager ()
//标记数量
@property (assign, nonatomic) NSInteger badgeNumber;
//视频请求消息列表
@property (strong, nonatomic) NSMutableArray *videoRequestList;
@end

@implementation PushNotificationManager

+ (instancetype) manager {
    static PushNotificationManager *manager = nil;
    static dispatch_once_t predict;
    
    dispatch_once(&predict, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

//接收通知信息
- (void)remoteNotificationMessage:(NSDictionary *)userInfo {
    NSLog(@"消息 is %@",userInfo);
    /*
     第一种格式
     "_j_msgid" = 2984554952;
     aps =     {
     alert = "\U60a8\U6536\U5230V8227\U4e00\U4e2a\U9080\U8bf7";
     badge = 18;
     sound = happy;
     };
     balance = 52;
     cost = 2;
     "msg_id" = 0;
     "refuse_reason" = "223\U60a8\U6536\U5230\U4e00\U6761\U9080\U8bf7";
     
     第一种格式
    {"msg_content":"您收到V8227一个邀请","extras":{"balance":"38","refuse_reason":"223您收到一条邀请","msg_id":0,"cost":"2"},"content_type":"","title":""}
    */
    NSString *msgID = nil;
    NSDictionary *extrasDict = [userInfo objectForKey:@"extras"];
    if (extrasDict != nil) {
        msgID = [extrasDict objectForKey:@"msg_id"];
    } else {
        msgID = [userInfo objectForKey:@"msg_id"];
    }

    if (msgID != nil) {
        [self addVideoRequestID:msgID];
    }
}
//添加标记数量
- (void)addIconBadgeNumber {
    self.badgeNumber ++;
    [UIApplication sharedApplication].applicationIconBadgeNumber = self.badgeNumber;
}
//清除标记数量
- (void)clearIconBadgeNumer {
    self.badgeNumber = 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

#pragma mark - Video Request Message
//判断是否是新的视频请求
- (BOOL)isNewVideoRequest:(NSString *)requestID {
    if ([self.videoRequestList containsObject:requestID]) {
        return YES;
    }
    return NO;
}
//增加新的视频请求
- (BOOL)addVideoRequestID:(NSString *)requestID {
    if (self.videoRequestList == nil) {
        self.videoRequestList = [[NSMutableArray alloc] init];
    }

    if ([self.videoRequestList containsObject:requestID] == NO) {
        [self.videoRequestList addObject:requestID];
    }
    
    self.hasNewVideoRequestMessage = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:NewVideoRequestMessageNotification object:nil];
    return YES;
}
//移除新的视频请求
- (void)removeVideoRequestID:(NSString *)requestID {
    if ([self.videoRequestList containsObject:requestID]) {
        [self.videoRequestList removeObject:requestID];
    }
    
    if (self.videoRequestList.count == 0 && self.hasNewVideoRequestMessage == YES) {
        self.hasNewVideoRequestMessage = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:NoVideoRequestMessageNotification object:nil];
    }
}

#pragma mark - Note Message

- (void)setHasNewNoteMessage:(BOOL)hasNewNoteMessage{
    _hasNewNoteMessage = hasNewNoteMessage;
    if (hasNewNoteMessage) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NewNoteMessageNotification object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:NoNoteMessageNotification object:nil];
    }
}

@end
