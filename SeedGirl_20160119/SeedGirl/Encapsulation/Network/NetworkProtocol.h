//
//  NetworkProtocol.h
//  SeedSocial
//  功能描述 - 接口协议
//  Created by Admin on 15/5/4.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#ifndef SeedSocial_NetworkProtocol_h
#define SeedSocial_NetworkProtocol_h

#import <Foundation/Foundation.h>

//获取网络接口错误消息
NSString* networkErrorType(NSInteger errorType);
//公共解析
NSInteger publishProtocol(id netData);

//用户更新
NSInteger userUpadateProtocol(id netData);
//用户登录
NSInteger userLoginProtocol(id netData);
//第三方用户登录
NSInteger oauthLoginProtocol(id netData);
//用户注册
NSInteger userRegisterProtocol(id netData);
//用户密码重置
NSInteger userResetPassword(id netData);
//获取用户个人信息
NSInteger userInfoProtocol(id netData);

//获取钻石提现规则
NSInteger userMyDiamond(id netData);

//用户数据解析
BOOL userDataAnalysis(id netData);
#pragma mark - 整理后接口
//广场动态列表
BOOL squareDynamicProtocol(BOOL isOverride, id netData);
//广场视频列表
BOOL squareVideoProtocol(BOOL isOverride, id netData);

//个人动态列表
BOOL individualDynamicProtocol(BOOL isOverride, id netData);
//个人制式视频列表
BOOL individualVideoManagementProtocol(id netData);
//个人视频请求列表
BOOL individualVideoRequestProtocol(BOOL isOverride, id netData);

//提现记录列表
BOOL cashRecordProtocol(BOOL isOverride, id netData);

#endif
