//
//  CashRecordData.m
//  SeedGirl
//  功能描述 - 提现记录基础数据
//  Created by Admin on 16/1/4.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "CashRecordData.h"

@implementation CashRecordData
@synthesize recordID,recordTime,recordStatus,recordMoney;

//设置数据
- (void)setData:(id)_data {
    if (_data == nil) {
        return ;
    }
    
    //记录ID
    id recordIDKey = [_data objectForKey:@"record_id"];
    if(recordIDKey != nil && recordIDKey != [NSNull null]) {
        recordID = [NSString stringWithFormat:@"%@",recordIDKey];
    }
    recordIDKey = nil;
    
    //记录时间
    id recordTimeKey = [_data objectForKey:@"record_time"];
    if(recordTimeKey != nil && recordTimeKey != [NSNull null]) {
        recordTime = [NSString stringWithFormat:@"%@",recordTimeKey];
    }
    recordTimeKey = nil;
    
    //记录状态
    id recordStatusKey = [_data objectForKey:@"record_status"];
    if(recordStatusKey != nil && recordStatusKey != [NSNull null]) {
        recordStatus = [recordStatusKey integerValue];
    }
    recordStatusKey = nil;
    
    //记录金钱
    id recordMoneyKey = [_data objectForKey:@"record_money"];
    if(recordMoneyKey != nil && recordMoneyKey != [NSNull null]) {
        recordMoney = [recordMoneyKey integerValue];
    }
    recordMoneyKey = nil;
}

@end
