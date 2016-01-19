//
//  CommentData.m
//  SeedGirl
//
//  Created by Admin on 15/11/5.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "CommentData.h"

@implementation CommentData
@synthesize commentID,commentTime,commentText,praiseCount,isPraised,isSubComment,subCommentText,toUserName;
@synthesize userID,userIcon,userName,userLevel,userHxid;

//设置数据
- (void)setData:(id)_data {
    if (_data == nil) {
        return ;
    }
    
    //评论ID
    id commentIDKey = [_data objectForKey:@"commentID"];
    if(commentIDKey != nil && commentIDKey != [NSNull null]) {
        commentID = commentIDKey;
    }
    commentIDKey = nil;
    
    //评论用户ID
    id userIDKey = [_data objectForKey:@"userID"];
    if(userIDKey != nil && userIDKey != [NSNull null]) {
        userID = userIDKey;
    }
    userIDKey = nil;
    
    //评论用户头像地址
    id userIconKey = [_data objectForKey:@"userIcon"];
    if(userIconKey != nil && userIconKey != [NSNull null]) {
        userIcon = userIconKey;
    }
    userIDKey = nil;
    
    //评论用户昵称
    id userNameKey = [_data objectForKey:@"userName"];
    if(userNameKey != nil && userNameKey != [NSNull null]) {
        userName = userNameKey;
    }
    userNameKey = nil;
    
    //评论用户等级
    id userLevelKey = [_data objectForKey:@"userLevel"];
    if(userLevelKey != nil && userLevelKey != [NSNull null]) {
        userLevel = [userLevelKey integerValue];
    }
    userLevelKey = nil;
    
    //评论时间
    id commentTimeKey = [_data objectForKey:@"commentTime"];
    if(commentTimeKey != nil && commentTimeKey != [NSNull null]) {
        commentTime = commentTimeKey;
    }
    commentTimeKey = nil;
    
    //评论内容
    id commentTextKey = [_data objectForKey:@"commentText"];
    if(commentTextKey != nil && commentTextKey != [NSNull null]) {
        commentText = commentTextKey;
    }
    commentTextKey = nil;
    
    //点赞总数
    id praiseCountKey = [_data objectForKey:@"praiseCount"];
    if(praiseCountKey != nil && praiseCountKey != [NSNull null]) {
        praiseCount = [praiseCountKey integerValue];
    }
    praiseCountKey = nil;
    
    //是否点过赞
    id isPraisedKey = [_data objectForKey:@"isPraised"];
    if(isPraisedKey != nil && isPraisedKey != [NSNull null]) {
        isPraised = [isPraisedKey boolValue];
    }
    isPraisedKey = nil;
    
    //评论者环信帐号
    id userHxidKey = [_data objectForKey:@"userHxid"];
    if(userHxidKey != nil && userHxidKey != [NSNull null]) {
        userHxid = userHxidKey;
    }
    userHxidKey = nil;
    
    //    是否为子评论
    id isSubCommentKey = [_data objectForKey:@"haveSubCommentText"];
    if(isSubCommentKey != nil && isSubCommentKey != [NSNull null]) {
        isSubComment = [isSubCommentKey boolValue];
    }
    isSubCommentKey = nil;
    
    //    评论内容
    id subCommentTextKey = [_data objectForKey:@"subCommentText"];
    if(subCommentTextKey != nil && subCommentTextKey != [NSNull null]) {
        subCommentText = subCommentTextKey;
    }
    subCommentTextKey = nil;
    
    id toUserNameTextKey = [_data objectForKey:@"toUserName"];
    if (toUserNameTextKey != nil && toUserNameTextKey != [NSNull null]) {
        toUserName = toUserNameTextKey;
    }
    toUserNameTextKey = nil;
}
@end
