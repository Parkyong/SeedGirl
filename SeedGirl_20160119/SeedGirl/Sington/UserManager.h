//
//  UserManager.h
//  SeedSocial
//  功能描述 - 用户数据管理
//  Created by Admin on 15/5/4.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserData;

@interface UserManager : NSObject

//用户是否登录
@property (assign, nonatomic) BOOL isLogined;
//用户是否注册
@property (assign, nonatomic) BOOL isRegisted;

//用户ID
@property (copy, nonatomic) NSString           *userID;
//用户sessiontoken
@property (copy, nonatomic) NSString *userSessionToken;
//环信ID
@property (copy, nonatomic) NSString         *userHxid;
//用户详情
@property (strong, nonatomic) UserData       *userData;

//用户钻石数量
@property (assign, nonatomic) NSInteger userBalance;
//是否通过制式视频验证
@property (assign, nonatomic) BOOL videoValidatedStatus;

//是否签到
@property (assign, nonatomic) BOOL              isSign;
//是否接受纸条
@property (assign, nonatomic) BOOL videoRequest_status;
//是否接受纸条
@property (assign, nonatomic) BOOL         note_status;

+ (instancetype) manager;

#pragma mark - user login
//获取保存的userid
- (NSString *)loginUserID;
//获取保存的seesion token
- (NSString *)loginSessionToken;
//更新用户信息
- (void)updateUserData:(UserData *)_data;
//清除用户信息
- (void)cleanUserData;

//保存登录信息
- (void)saveUserLoginInfo;
//清空登录信息
- (void)cleanUserLoginInfo;

@end
