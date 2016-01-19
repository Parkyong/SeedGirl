//
//  oAuthManager.h
//  SeedGirl
//  功能描述 - 授权管理器
//  Created by Admin on 16/1/15.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"

@protocol oAuthManagerDelegate <NSObject>
//qq授权
- (void)oAuthDidReceiveQQUserInfo:(NSDictionary *)userInfo;
//qq授权取消
- (void)oAuthQQAuthCancel;
//qq授权失败
- (void)oAuthQQAuthFailure;
//微信授权
- (void)oAuthDidReceiveWebChatUserInfo:(NSDictionary *)userInfo;
//微信授权取消
- (void)oAuthWebchatAuthCancel;
//微信授权失败
- (void)oAuthWebchatAuthFailure;
@end

@interface oAuthManager : NSObject <TencentLoginDelegate,TencentSessionDelegate,WXApiDelegate>

@property (assign, nonatomic) id<oAuthManagerDelegate> delegate;

+ (instancetype)manager;

//发起QQ授权
- (void)sendTencentAuthRequest;
//发起微信授权
- (void)sendWebchatAuthRequest;

@end
