//
//  IndividualView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/19.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecordData;

typedef void(^DynamicBlock)(RecordData *recordData);
typedef void(^VideoBlock)(NSInteger index);
typedef void(^ScrollBlock)(NSInteger index);

@interface IndividualView : UIScrollView

@property (nonatomic, strong) UIViewController*parentsController;
//滑动block
@property (nonatomic, copy) ScrollBlock scrollBlock;
//动态block
@property (nonatomic, copy) DynamicBlock dynamicBlock;
//视频block
@property (nonatomic, copy) VideoBlock videoBlock;

//显示指定视图
- (void)showSubViewAtIndex:(NSInteger)_index;
//更新广场数据
- (void)updateIndividualData;
//显示视频请求新消息提醒
- (void)showNewVideoRequestMessage:(BOOL)status;

@end
