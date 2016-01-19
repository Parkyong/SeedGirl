//
//  CacheDataManager.h
//  SeedGirl
//  功能描述 - 缓存数据管理器
//  Created by Admin on 15/12/11.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VideoSummaryData;

@interface CacheDataManager : NSObject

//数据列表无记录接口返回值
@property (nonatomic, assign) NSInteger EmptyData;
@property (nonatomic, assign) NSInteger NoMoreData;

//广场动态列表
@property (nonatomic, strong) NSMutableArray *squareDynamicList;
//广场视频列表
@property (nonatomic, strong) NSMutableArray *squareVideoList;

//是否需要强制更新广场动态
@property (nonatomic, assign) BOOL isForcedUpdateIndividualDynamic;
//个人动态列表
@property (nonatomic, strong) NSMutableArray *individualDynamicList;

//个人视频概况信息
@property (nonatomic, strong) VideoSummaryData *individualVideoSummaryData;
//是否需要强制更新个人制式视频
@property (nonatomic, assign) BOOL isForcedUpdateIndividualVideoManagement;
//个人制式视频列表
@property (nonatomic, strong) NSMutableArray *individualVideoManagementList;
//是否需要强制更新个人视频请求
@property (nonatomic, assign) BOOL isForcedUpdateIndividualVideoRequest;
//个人自定义视频请求列表
@property (nonatomic, strong) NSMutableArray *individualVideoRequestList;

//提现记录列表
@property (nonatomic, strong) NSMutableArray *cashRecordList;

+ (instancetype)sharedInstance;

@end
