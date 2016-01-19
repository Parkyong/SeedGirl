//
//  CommentData.h
//  SeedGirl
//  功能描述 - 评论数据
//  Created by Admin on 15/11/5.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentData : NSObject

//评论ID
@property (copy, nonatomic) NSString *commentID;
//评论用户ID
@property (copy, nonatomic) NSString *userID;
//评论用户头像地址
@property (copy, nonatomic) NSString *userIcon;
//评论用户昵称
@property (copy, nonatomic) NSString *userName;
//评论用户等级
@property (assign) NSInteger userLevel;
//评论时间
@property (copy, nonatomic) NSString *commentTime;
//评论内容
@property (copy, nonatomic) NSString *commentText;
//是否有二级评论
@property (assign, nonatomic) BOOL isSubComment;
//评论内容
@property (copy, nonatomic) NSString *subCommentText;

@property (copy, nonatomic) NSString *toUserName;

@property (copy, nonatomic) NSString *userHxid;
//点赞总数
@property (assign) NSInteger praiseCount;
//是否点过赞
@property (assign) BOOL isPraised;

//设置数据
- (void)setData:(id)_data;

@end
