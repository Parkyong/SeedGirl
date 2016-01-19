//
//  UserManager.m
//  SeedSocial
//
//  Created by Admin on 15/5/4.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import "UserManager.h"
#import "UserData.h"

@implementation UserManager

+ (instancetype) manager {
    static UserManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedInstance = [[UserManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark - user login
//获取保存的userid
- (NSString *)loginUserID {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"login_user_id"];
}
//获取保存的seesion token
- (NSString *)loginSessionToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"login_session_token"];
}
//更新用户信息
- (void)updateUserData:(UserData *)_data{
    if (self.userData != nil) {
        self.userData.userName        = _data.userName;
        self.userData.userTagList     = _data.userTagList;
        self.userData.userShowList    = _data.userShowList;
        self.userData.userAge         = _data.userAge;
        self.userData.userHeigth      = _data.userHeigth;
        self.userData.userCity        = _data.userCity;
        self.userData.userVocation    = _data.userVocation;
        self.userData.userInterst     = _data.userInterst;
        self.userData.userDescription = _data.userDescription;
    }
}
//清除用户信息
- (void)cleanUserData {
    _userID           = nil;
    _userSessionToken = nil;
    _userHxid         = nil;
    _userData = nil;
}
//保存登录信息
- (void)saveUserLoginInfo {
    [self saveToFile];
}
//清空登录信息
- (void)cleanUserLoginInfo {
    _userID           = nil;
    _userSessionToken = nil;
    _userHxid         = nil;
    _isLogined        = NO;
    [self saveToFile];
}

#pragma mark    保存到本地
- (void)saveToFile {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:_userID forKey:@"login_user_id"];
    [userDefault setValue:_userSessionToken forKey:@"login_session_token"];
    [userDefault synchronize];
}
@end
