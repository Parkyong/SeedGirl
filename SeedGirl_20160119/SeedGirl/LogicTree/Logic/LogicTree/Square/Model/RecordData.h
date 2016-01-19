//
//  RecordData.h
//  SeedGirl
//  功能描述 - 记录数据
//  Created by Admin on 15/10/29.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordData : NSObject

//记录ID
@property (copy, nonatomic) NSString *recordID;
//发布用户ID
@property (copy, nonatomic) NSString *userID;
//发布用户头像地址
@property (copy, nonatomic) NSString *userIcon;
//发布用户昵称
@property (copy, nonatomic) NSString *userName;
//发布用户等级
@property (assign, nonatomic) NSInteger userLevel;
//发布时间
@property (copy, nonatomic) NSString *recordTime;
//发布内容
@property (copy, nonatomic) NSString *recordText;
//发布图片列表
@property (strong, nonatomic) NSMutableArray *picList;
@property (assign) NSInteger picListCount;
//发布视频列表
@property (copy, nonatomic) NSString *videoURL;
//发布视频缩略图
@property (copy, nonatomic) NSString *videoThumbnail;
//观察总数
@property (assign, nonatomic) NSInteger watchCount;
//评论总数
@property (assign, nonatomic) NSInteger commentCount;
//点赞总数
@property (assign, nonatomic) NSInteger praiseCount;
//环信用户ID
@property (copy, nonatomic) NSString *userHxid;
//是否点过赞
//@property (assign, nonatomic) BOOL isPraised;

//是否领取过奖励
@property (assign, nonatomic, getter=isHasReword) BOOL hasReward;

//设置数据
- (void)setData:(id)_data;

@end
