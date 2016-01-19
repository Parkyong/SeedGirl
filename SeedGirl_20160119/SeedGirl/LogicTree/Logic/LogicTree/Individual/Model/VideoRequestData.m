//
//  VideoRequestData.m
//  SeedGirl
//
//  Created by Admin on 15/11/12.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoRequestData.h"

@implementation VideoRequestData
@synthesize requestID,requestMessage,requestStatus,requestCost,requestTime,requestRefuseReason;
@synthesize userName,userIcon;

//设置数据
- (void)setData:(id)_data {
    if (_data == nil) {
        return ;
    }
    
    //视频请求ID
    id requestIDKey = [_data objectForKey:@"requestID"];
    if(requestIDKey != nil && requestIDKey != [NSNull null]) {
        requestID = requestIDKey;
    }
    requestIDKey = nil;
    
    //请求用户昵称
    id userNameKey = [_data objectForKey:@"userName"];
    if(userNameKey != nil && userNameKey != [NSNull null]) {
        userName = userNameKey;
    }
    userNameKey = nil;
    
    //请求用户头像
    id userIconKey = [_data objectForKey:@"userIcon"];
    if(userIconKey != nil && userIconKey != [NSNull null]) {
        userIcon = userIconKey;
    }
    userIconKey = nil;
    
    //请求时间
    id timeKey = [_data objectForKey:@"time"];
    if(timeKey != nil && timeKey != [NSNull null]) {
        requestTime = timeKey;
    }
    timeKey = nil;
    
    //请求内容
    id messageKey = [_data objectForKey:@"message"];
    if(messageKey != nil && messageKey != [NSNull null]) {
        requestMessage = messageKey;
    }
    messageKey = nil;
    
    //请求花费钻石数
    id costKey = [_data objectForKey:@"cost"];
    if(costKey != nil && costKey != [NSNull null]) {
        requestCost = [costKey integerValue];
    }
    costKey = nil;
    
    //请求状态
    id statusKey = [_data objectForKey:@"status"];
    if(statusKey != nil && statusKey != [NSNull null]) {
        requestStatus = [statusKey integerValue];
    }
    statusKey = nil;
    
    //请求拒绝理由
    id reasonKey = [_data objectForKey:@"refuseReason"];
    if(reasonKey != nil && reasonKey != [NSNull null]) {
        requestRefuseReason = reasonKey;
    }
    reasonKey = nil;
}

@end
