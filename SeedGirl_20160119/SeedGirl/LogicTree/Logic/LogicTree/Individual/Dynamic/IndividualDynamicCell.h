//
//  IndividualDynamicCell.h
//  SeedGirl
//  功能描述 - 个人动态视图cell
//  Created by Admin on 16/1/13.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecordData;

typedef void(^GetRewardBlock)(BOOL status);

@interface IndividualDynamicCell : UITableViewCell
//奖励block
@property (copy, nonatomic) GetRewardBlock rewardBlock;
//设置显示数据
- (void)setShowData:(RecordData *)data;
@end
