//
//  NetworkProtocol.m
//  SeedSocial
//
//  Created by Admin on 15/5/4.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import "NetworkProtocol.h"
#import "UserData.h"
#import "BankManager.h"
#import "BankRuleData.h"
#import "RecordData.h"
#import "CommentData.h"
#import "VideoData.h"
#import "VideoSummaryData.h"
#import "SystemVideoData.h"
#import "VideoRequestData.h"
#import "CashRecordData.h"

//获取接口错误消息
NSString* networkErrorType(NSInteger errorType) {
    NSString *errorMsg = @"";
    switch (errorType) {
        case -1:
            errorMsg = @"session验证失败";
            break;
        case -2:
            errorMsg = @"参数验证失败";
            break;
        case -3:
            errorMsg = @"短信发送失败";
            break;
        case -4:
            errorMsg = @"短信验证失败";
            break;
        case -5:
            errorMsg = @"登录失败";
            break;
        case -6:
        case -11:
            errorMsg = @"获取用户信息失败";
            break;
        case -7:
            errorMsg = @"钻石数量不足";
            break;
        case -8:
            errorMsg = @"播种失败";
            break;
        case -9:
            errorMsg = @"上传头像失败";
            break;
        case -10:
            errorMsg = @"充值失败";
            break;
        case -12:
            errorMsg = @"此用户被禁用";
            break;
        case -13:
            errorMsg = @"评论失败";
            break;
        case -14:
            errorMsg = @"手机号已被注册";
            break;
        case -15:
            errorMsg = @"注册失败";
            break;
        case -16:
            errorMsg = @"找回密码手机号不存在";
            break;
        case -17:
            errorMsg = @"重置密码失败";
            break;
        case -18:
            errorMsg = @"只能重复一次";
            break;
        case -19:
            errorMsg = @"请求已被处理不能取消";
            break;
        case -20:
            errorMsg = @"请求未处理不能删除";
            break;
            
        case -21:
            errorMsg = @"绑定失败";
            break;
        case -22:
            errorMsg = @"解绑失败";
            break;
        case -23:
            errorMsg = @"已存在绑定";
            break;
        case -24:
            errorMsg = @"超过提现次数";
            break;
        case -25:
            errorMsg = @"更新个人信息失败";
            break;
        case -26:
            errorMsg = @"相册上传失败";
            break;
        case -27:
            errorMsg = @"相册不能超过8张";
            break;
        case -28:
            errorMsg = @"未绑定账号，请先注册";
            break;
        case -29:
            errorMsg = @"不显示视频列表";
            break;
        case -30:
            errorMsg = @"视频上传失败";
            break;
        case -31:
            errorMsg = @"会话重复";
            break;
        case -32:
            errorMsg = @"删除失败";
            break;
        case -33:
            errorMsg = @"更新失败";
            break;
        case -34:
            errorMsg = @"更新视频播放数失败";
            break;
        case -35:
            errorMsg = @"增加失败";
            break;
        case -50:
        case -51:
            errorMsg = @"暂无记录";
            break;
        case -52:
            errorMsg = @"领取钻石失败";
            break;
        default:
            break;
    }
    return errorMsg;
}
//公共解析
NSInteger publishProtocol(id netData) {
    NSInteger status = [[netData objectForKey:@"status"] integerValue];
    return status;
}
//用户更新
NSInteger userUpadateProtocol(id netData){
    id statusKey = [netData objectForKey:@"status"];
    if([statusKey integerValue] == 0) {
        UserData *userData = [[UserData alloc] init];
        [userData setUserDataWithUpdateData:netData];
        [[UserManager manager] updateUserData:userData];
    }
    return [statusKey integerValue];
}
//用户登录
NSInteger userLoginProtocol(id netData){
    NSLog(@"userLoginProtocol is %@",netData);
    id statusKey = [netData objectForKey:@"status"];
    if([statusKey integerValue] == 0) {
        if (userDataAnalysis(netData)) {
            [UserManager manager].isLogined = YES;
        }
    }
    return [statusKey integerValue];
}
//第三方用户登录
NSInteger oauthLoginProtocol(id netData) {
    id statusKey = [netData objectForKey:@"status"];
    if([statusKey integerValue] == 0) {
        if (userDataAnalysis(netData)) {
            [UserManager manager].isLogined = YES;
        }
    }
    return [statusKey integerValue];
}
//用户注册
NSInteger userRegisterProtocol(id netData){
    id statusKey = [netData objectForKey:@"status"];
    if([statusKey integerValue] == 0) {
        if (userDataAnalysis(netData)) {
            [UserManager manager].isLogined = YES;
        }
    }
    return [statusKey integerValue];
}
//用户密码重置
NSInteger userResetPassword(id netData){
    id statusKey = [netData objectForKey:@"status"];
    if([statusKey integerValue] == 0) {
        id token = [netData objectForKey:@"session_token"];
        if (token != nil && token != [NSNull null] ) {
            [[UserManager manager] setUserSessionToken:token];
            token = nil;
        }
        id userID = [netData objectForKey:@"user_id"];
        if (userID != nil && userID != [NSNull null] ) {
            [[UserManager manager] setUserID:userID];
            userID = nil;
        }
    }
    return [statusKey integerValue];
}
//获取用户个人信息
NSInteger userInfoProtocol(id netData) {
    APPLog(@"userInfoProtocol data is %@",netData);
    id statusKey = [netData objectForKey:@"status"];
    if([statusKey integerValue] == 0) {
        if ( [[UserManager manager] userData] == nil) {
            UserData *userData = [[UserData alloc] init];
            [userData setUserData:netData];
            [[UserManager manager] setUserData:userData];
            userData = nil;
        }else{
            [[[UserManager manager] userData] setUserData:netData];
        }
    }
    return [statusKey integerValue];
}
//获取钻石提现规则
NSInteger userMyDiamond(id netData){
    id statusKey = [netData objectForKey:@"status"];
    if ([statusKey integerValue] == 0) {
        BankRuleData *banRuleData = [[BankRuleData alloc] init];
        id card_number = [netData objectForKey:@"card_number"];
        if (card_number != nil && card_number != [NSNull null]) {
            [banRuleData setCard_number:card_number];
        }
        
        id fetch_cash = [netData objectForKey:@"fetch_cash"];
        if (fetch_cash != nil && fetch_cash != [NSNull null]) {
            [banRuleData setFetch_cash:[fetch_cash integerValue]];
        }
        
        id fetch_cash_count = [netData objectForKey:@"fetch_cash_count"];
        if (fetch_cash_count != nil && fetch_cash_count != [NSNull null]) {
            [banRuleData setFetch_cash_count:[fetch_cash_count integerValue]];
        }
        
        id keep_diamond = [netData objectForKey:@"keep_diamond"];
        if (keep_diamond != nil && keep_diamond != [NSNull null]) {
            [banRuleData setKeep_diamond:[keep_diamond integerValue]];
        }
        
        id low_requirement = [netData objectForKey:@"low_requirement"];
        if (low_requirement != nil && low_requirement != [NSNull null]) {
            [banRuleData setLow_requirement:[low_requirement integerValue]];
        }
        
        id proportion = [netData objectForKey:@"proportion"];
        if (proportion != nil && proportion != [NSNull null]) {
            [banRuleData setProportion:[proportion floatValue]];
        }
        [[BankManager manager] setBankRuleData:banRuleData];
    }
    return [statusKey integerValue];
}

#pragma mark - 整理后接口
//用户数据解析
BOOL userDataAnalysis(id netData) {
    if (netData == nil) {
        return NO;
    }
    
    id userID = [netData objectForKey:@"user_id"];
    if (userID != nil && userID != [NSNull null] ) {
        [UserManager manager].userID = [NSString stringWithFormat:@"%@",userID];
        userID = nil;
    }
    
    id token = [netData objectForKey:@"session_token"];
    if (token != nil && token != [NSNull null] ) {
        [UserManager manager].userSessionToken = [NSString stringWithFormat:@"%@",token];
        token = nil;
    }
    
    id userHxid = [netData objectForKey:@"user_hxid"];
    if (userHxid != nil && userHxid != [NSNull null] ) {
        [UserManager manager].userHxid = [NSString stringWithFormat:@"%@",userHxid];
        userHxid = nil;
    }
    
    id videoRequest_status = [netData objectForKey:@"videoRequest_status"];
    if (videoRequest_status != nil && videoRequest_status != [NSNull null] ) {
        [UserManager manager].videoRequest_status = [videoRequest_status boolValue];
        videoRequest_status = nil;
    }
    
    id note_status = [netData objectForKey:@"note_status"];
    if (note_status != nil && note_status != [NSNull null] ) {
        [UserManager manager].note_status = [note_status boolValue];
        note_status = nil;
    }
    
    id video_validated = [netData objectForKey:@"video_validated"];
    if (video_validated != nil && video_validated != [NSNull null]) {
        [UserManager manager].videoValidatedStatus = [video_validated boolValue];
        video_validated = nil;
    }
    
    id user_balance = [netData objectForKey:@"user_balance"];
    if(user_balance != nil && user_balance != [NSNull null]) {
        [UserManager manager].userBalance = [user_balance integerValue];
        user_balance = nil;
    }
    
    UserData *userData = [[UserData alloc] init];
    [userData setUserData:netData];
    [[UserManager manager] setUserData:userData];
    return YES;
}

//广场动态列表
BOOL squareDynamicProtocol(BOOL isOverride, id netData) {
//    NSLog(@"squareDynamicProtocol data is %@",netData);
    id statusKey = [netData objectForKey:@"status"];
    if([statusKey integerValue] == 0) {
        id recordListKey = [netData objectForKey:@"recordlist"];
        if (recordListKey != nil && recordListKey != [NSNull null]) {
            NSMutableArray *dynamicList = [[NSMutableArray alloc] init];
            NSArray *recordList = (NSArray *)recordListKey;
            for (id object in recordList) {
                RecordData *data = [[RecordData alloc] init];
                [data setData:object];
                [dynamicList addObject:data];
            }
            
            if (isOverride) {
                [[CacheDataManager sharedInstance] setSquareDynamicList:dynamicList];
            } else if (recordList.count > 0) {
                [[[CacheDataManager sharedInstance] squareDynamicList] addObjectsFromArray:dynamicList];
            }
            dynamicList = nil;
            recordList = nil;
        }
        recordListKey = nil;
        return YES;
    }
    return NO;
}
//广场视频列表
BOOL squareVideoProtocol(BOOL isOverride, id netData) {
//    NSLog(@"squareDynamicProtocol data is %@",netData);
    id statusKey = [netData objectForKey:@"status"];
    if([statusKey integerValue] == 0) {
        id videoListKey = [netData objectForKey:@"video"];
        if (videoListKey != nil && videoListKey != [NSNull null]) {
            NSMutableArray *videoList = [[NSMutableArray alloc] init];
            NSArray *recordList = (NSArray *)videoListKey;
            for (id object in recordList) {
                VideoData *data = [[VideoData alloc] init];
                [data setData:object];
                [videoList addObject:data];
            }
            
            if (isOverride) {
                [[CacheDataManager sharedInstance] setSquareVideoList:videoList];
            } else if (recordList.count > 0) {
                [[[CacheDataManager sharedInstance] squareVideoList] addObjectsFromArray:videoList];
            }
            videoList = nil;
            recordList = nil;
        }
        videoListKey = nil;
        return YES;
    }
    return NO;
}
//个人动态列表
BOOL individualDynamicProtocol(BOOL isOverride, id netData) {
    NSLog(@"individualDynamicProtocol data is %@",netData);
    id statusKey = [netData objectForKey:@"status"];
    if([statusKey integerValue] == 0) {
        id recordListKey = [netData objectForKey:@"recordlist"];
        if (recordListKey != nil && recordListKey != [NSNull null]) {
            NSMutableArray *dynamicList = [[NSMutableArray alloc] init];
            NSArray *recordList = (NSArray *)recordListKey;
            for (id object in recordList) {
                RecordData *data = [[RecordData alloc] init];
                [data setData:object];
                [dynamicList addObject:data];
            }
            
            if (isOverride) {
                [[CacheDataManager sharedInstance] setIndividualDynamicList:dynamicList];
            } else if (recordList.count > 0) {
                [[[CacheDataManager sharedInstance] individualDynamicList] addObjectsFromArray:dynamicList];
            }
            dynamicList = nil;
            recordList = nil;
        }
        recordListKey = nil;
        return YES;
    }
    return NO;
}
//个人制式视频列表
BOOL individualVideoManagementProtocol(id netData) {
    NSLog(@"individualVideoManagementProtocol data is %@",netData);
    id statusKey = [netData objectForKey:@"status"];
    if([statusKey integerValue] == 0) {
        VideoSummaryData *summaryData = [[VideoSummaryData alloc] init];
        [summaryData setData:netData];
        [[CacheDataManager sharedInstance] setIndividualVideoSummaryData:summaryData];
        summaryData = nil;
        
        id videoListKey = [netData objectForKey:@"videoList"];
        if (videoListKey != nil && videoListKey != [NSNull null]) {
            NSMutableArray *videoList = [[NSMutableArray alloc] init];
            NSArray *temp_videoList = (NSArray *)videoListKey;
            for (id object in temp_videoList) {
                SystemVideoData *data = [[SystemVideoData alloc] init];
                [data setData:object];
                [videoList addObject:data];
            }
            
            [[CacheDataManager sharedInstance] setIndividualVideoManagementList:videoList];
            videoList = nil;
            temp_videoList = nil;
        }
        videoListKey = nil;
        return YES;
    }
    return NO;
}
//视频请求列表
BOOL individualVideoRequestProtocol(BOOL isOverride, id netData) {
    NSLog(@"individualVideoRequestProtocol data is %@",netData);
    id statusKey = [netData objectForKey:@"status"];
    if([statusKey integerValue] == 0) {
        id requestListKey = [netData objectForKey:@"requestList"];
        if (requestListKey != nil && requestListKey != [NSNull null]) {
            NSMutableArray *requestList = [[NSMutableArray alloc] init];
            NSArray *temp_requestList = (NSArray *)requestListKey;
            for (id object in temp_requestList) {
                VideoRequestData *data = [[VideoRequestData alloc] init];
                [data setData:object];
                [requestList addObject:data];
            }
            
            if (isOverride) {
                [[CacheDataManager sharedInstance] setIndividualVideoRequestList:requestList];
            } else if (requestList.count > 0) {
                [[[CacheDataManager sharedInstance] individualVideoRequestList] addObjectsFromArray:requestList];
            }
            requestList = nil;
            temp_requestList = nil;
        }
        requestListKey = nil;
        return YES;
    } else if ([statusKey integerValue] == [[CacheDataManager sharedInstance] EmptyData]||
               [statusKey integerValue] == [[CacheDataManager sharedInstance] NoMoreData]) {
        return YES;
    }
    return NO;
}
//提现记录列表
BOOL cashRecordProtocol(BOOL isOverride, id netData) {
    NSLog(@"cashRecordProtocol data is %@",netData);
    id statusKey = [netData objectForKey:@"status"];
    if([statusKey integerValue] == 0) {
        id recordListKey = [netData objectForKey:@"recordList"];
        if (recordListKey != nil && recordListKey != [NSNull null]) {
            NSMutableArray *recordList = [[NSMutableArray alloc] init];
            NSArray *temp_recordList = (NSArray *)recordListKey;
            for (id object in temp_recordList) {
                CashRecordData *data = [[CashRecordData alloc] init];
                [data setData:object];
                [recordList addObject:data];
            }
            
            if (isOverride) {
                [[CacheDataManager sharedInstance] setCashRecordList:recordList];
            } else if (recordList.count > 0) {
                [[[CacheDataManager sharedInstance] cashRecordList] addObjectsFromArray:recordList];
            }
            recordList = nil;
            temp_recordList = nil;
        }
        recordListKey = nil;
        return YES;
    } else if ([statusKey integerValue] == [[CacheDataManager sharedInstance] EmptyData]||
               [statusKey integerValue] == [[CacheDataManager sharedInstance] NoMoreData]) {
        return YES;
    }
    return NO;
}
