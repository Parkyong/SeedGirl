//
//  CashRecordData.h
//  SeedGirl
//
//  Created by Admin on 16/1/4.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CashRecordData : NSObject

//记录ID
@property (nonatomic, copy) NSString *recordID;
//记录时间
@property (nonatomic, copy) NSString *recordTime;
//记录状态
@property (nonatomic, assign) NSInteger recordStatus;
//记录金钱
@property (nonatomic, assign) NSInteger recordMoney;

//设置数据
- (void)setData:(id)_data;

@end
