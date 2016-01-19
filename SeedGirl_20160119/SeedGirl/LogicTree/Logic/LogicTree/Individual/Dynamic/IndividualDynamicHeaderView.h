//
//  IndividualDynamicHeaderView.h
//  SeedGirl
//  功能描述 - 个人动态视图cell头部视图
//  Created by Admin on 16/1/13.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndividualDynamicHeaderView : UIView
//奖励block
@property (copy, nonatomic) dispatch_block_t rewardBlock;

//设置个人信息
- (void)setUserIcon:(NSString *)url name:(NSString *)name;
//设置记录时间和是否领取过奖励
- (void)setRecordTime:(NSString *)time getReward:(BOOL)status;
@end
