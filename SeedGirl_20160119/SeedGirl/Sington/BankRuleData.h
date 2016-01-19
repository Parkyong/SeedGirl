//
//  BankRuleData.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/20.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankRuleData : NSObject
@property (nonatomic, copy)   NSString      *card_number;              //银行卡卡号
@property (nonatomic, assign) NSInteger       fetch_cash;              //可提现数额
@property (nonatomic, assign) NSInteger fetch_cash_count;              //每月可提现次数
@property (nonatomic, assign) NSInteger     keep_diamond;              //拥有钻石数量
@property (nonatomic, assign) NSInteger  low_requirement;              //最低提现数额
@property (nonatomic, assign) CGFloat         proportion;              //砖石与人民币对应比例
@property (nonatomic, assign) BOOL                isBind;              //是否绑定

- (void)setBankRuleData:(id)_data;
@end
