//
//  RecordData.m
//  SeedGirl
//
//  Created by Admin on 15/10/29.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "RecordData.h"

@implementation RecordData
@synthesize recordID,userID,userIcon,userName,userLevel,recordTime,recordText;
@synthesize picList,picListCount,videoURL,videoThumbnail;
@synthesize watchCount,commentCount,praiseCount,userHxid;//,isPraised;
@synthesize hasReward;

//设置数据
- (void)setData:(id)_data {
    if (_data == nil) {
        return ;
    }
//    NSLog(@"data ia %@",_data);
    //记录ID
    id recordIDKey = [_data objectForKey:@"recordid"];
    if(recordIDKey != nil && recordIDKey != [NSNull null]) {
        recordID = [NSString stringWithFormat:@"%@",recordIDKey];
    }
    recordIDKey = nil;
    
    //发布用户ID
    id userIDKey = [_data objectForKey:@"userid"];
    if(userIDKey != nil && userIDKey != [NSNull null]) {
        userID = [NSString stringWithFormat:@"%@",userIDKey];
    }
    userIDKey = nil;
    
    //发布用户头像地址
    id userIconKey = [_data objectForKey:@"icon"];
    if(userIconKey != nil && userIconKey != [NSNull null]) {
        userIcon = userIconKey;
    }
    userIDKey = nil;
    
    //发布用户昵称
    id userNameKey = [_data objectForKey:@"username"];
    if(userNameKey != nil && userNameKey != [NSNull null]) {
        userName = userNameKey;
    }
    userNameKey = nil;
    
    //发布用户等级
    id userLevelKey = [_data objectForKey:@"level"];
    if(userLevelKey != nil && userLevelKey != [NSNull null]) {
        userLevel = [userLevelKey integerValue];
    }
    userLevelKey = nil;
    
    //发布时间
    id recordTimeKey = [_data objectForKey:@"recordtime"];
    if(recordTimeKey != nil && recordTimeKey != [NSNull null]) {
        recordTime = [NSString stringWithFormat:@"%@",recordTimeKey];
    }
    recordTimeKey = nil;
    
    //发布内容
    id recordTextKey = [_data objectForKey:@"recordtext"];
    if(recordTextKey != nil && recordTextKey != [NSNull null]) {
        recordText = recordTextKey;
    }
    recordTextKey = nil;
    
    //发布图片列表
    id picListKey = [_data objectForKey:@"picList"];
    if(picListKey != nil && picListKey != [NSNull null]) {
        picList = [[NSMutableArray alloc] init];
        for (id object in picListKey) {
            [picList addObject:object];
        }
    }
    picListKey = nil;
    
    picListCount = picList.count;
    
    id videoKey = [_data objectForKey:@"video"];
    if (videoKey != nil && videoKey != [NSNull null]) {
        
        //发布视频列表
        id videoURLKey = [videoKey objectForKey:@"videourl"];
        if(videoURLKey != nil && videoURLKey != [NSNull null]) {
            videoURL = videoURLKey;
        }
        videoURLKey = nil;
        
        //发布视频缩略图
        id videoThumbnailKey = [videoKey objectForKey:@"videothumbnail"];
        if(videoThumbnailKey != nil && videoThumbnailKey != [NSNull null]) {
            videoThumbnail = videoThumbnailKey;
        }
        videoThumbnailKey = nil;
        
//        //发布视频缩略图
//        NSString *videoThumbnailKey = [videoKey objectForKey:@"videoThumbnail"];
//        if (![videoThumbnailKey isEmptyString]) {
//            videoThumbnail = videoThumbnailKey;
//        }
//        videoThumbnailKey = nil;
    }
    
    //观察总数
    id watchCountKey = [_data objectForKey:@"watchcount"];
    if(watchCountKey != nil && watchCountKey != [NSNull null]) {
        watchCount = [watchCountKey integerValue];
    }
    watchCountKey = nil;
    
    //评论总数
    id commentCountKey = [_data objectForKey:@"commentcount"];
    if(commentCountKey != nil && commentCountKey != [NSNull null]) {
        commentCount = [commentCountKey integerValue];
    }
    commentCountKey = nil;
    
    //点赞总数
    id praiseCountKey = [_data objectForKey:@"praisecount"];
    if(praiseCountKey != nil && praiseCountKey != [NSNull null]) {
        praiseCount = [praiseCountKey integerValue];
    }
    praiseCountKey = nil;
    
    //点赞总数
    id userHxidKey = [_data objectForKey:@"userHxid"];
    if(userHxidKey != nil && userHxidKey != [NSNull null]) {
        userHxid = userHxidKey ;
    }
    userHxidKey = nil;
    
    //    //是否点过赞
    //    id isPraisedKey = [_data objectForKey:@"isPraised"];
    //    if(isPraisedKey != nil && isPraisedKey != [NSNull null]) {
    //        isPraised = [isPraisedKey boolValue];
    //    }
    //    isPraisedKey = nil;
    
    //是否领取过奖励
    id rewardKey = [_data objectForKey:@"reward"];
    if(rewardKey != nil && rewardKey != [NSNull null]) {
        hasReward = [rewardKey boolValue];
    }
    rewardKey = nil;
}

@end
