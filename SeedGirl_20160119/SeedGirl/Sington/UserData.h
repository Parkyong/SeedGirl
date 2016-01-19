//
//  UserData.h
//  SeedSocial
//  功能描述 - 用户基本数据
//  Created by Admin on 15/4/23.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

//用户昵称
@property (copy, nonatomic) NSString                 *userName;
//用户头像
@property (copy, nonatomic) NSString                 *userIcon;
//用户等级
@property (assign, nonatomic) NSInteger              userLevel;
//用户拥有粉丝数量
@property (assign, nonatomic) NSInteger               userFans;
//用户标签列表
@property (strong, nonatomic) NSMutableArray      *userTagList;
//用户展示图片列表
@property (strong, nonatomic) NSMutableArray     *userShowList;
//用户年龄
@property (assign, nonatomic) NSInteger                userAge;
//用户身高
@property (assign, nonatomic) NSInteger             userHeigth;
//用户所在城市
@property (copy,   nonatomic) NSString               *userCity;
//用户职业
@property (copy,   nonatomic) NSString           *userVocation;
//用户兴趣
@property (copy,   nonatomic) NSString            *userInterst;
//用户个性签名
@property (copy,   nonatomic) NSString        *userDescription;
//用户经验
@property (assign, nonatomic) NSInteger         userExperience;
//用户下一等级所需经验
@property (assign, nonatomic) NSInteger   userUpdateExperience;

//设置数据
- (void)setUserData:(id)_data;
//设置数据因为字段不一样
- (void)setUserDataWithUpdateData:(id)_data;

@end
