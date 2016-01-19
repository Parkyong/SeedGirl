//
//  BankRuleData.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/20.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "BankRuleData.h"

@implementation BankRuleData
- (instancetype)init{
    if (self = [super init]) {
        _card_number = @"";
        _fetch_cash         = 0;
        _fetch_cash_count   = 0;
        _keep_diamond       = 0;
        _low_requirement    = 0;
        _proportion         = 0;
        _isBind             = NO;
    }
    return self;
}

- (void)setBankRuleData:(id)_data{
    if(_data == nil)
        return ;
    
    if([_data objectForKey:@"card_number"] != nil)
    {
        _card_number = [_data objectForKey:@"user_id"];
    }
    
    if([_data objectForKey:@"fetch_cash"] != nil)
    {
        _fetch_cash = [[_data objectForKey:@"fetch_cash"] integerValue];
    }

    if([_data objectForKey:@"fetch_cash_count"] != nil)
    {
        _fetch_cash_count = [[_data objectForKey:@"fetch_cash_count"] integerValue];
    }

    if([_data objectForKey:@"keep_diamond"] != nil)
    {
        _keep_diamond = [[_data objectForKey:@"keep_diamond"] integerValue];
    }

    if([_data objectForKey:@"low_requirement"] != nil)
    {
        _low_requirement = [[_data objectForKey:@"low_requirement"] integerValue];
    }

    if([_data objectForKey:@"proportion"] != nil)
    {
        _proportion = [[_data objectForKey:@"proportion"] floatValue];
    }

    return;
}

- (void)setCard_number:(NSString *)card_number{
    if (card_number.length != 0) {
        _card_number = card_number;
        _isBind      = YES;
    }else{
        _card_number = @"";
        _isBind      = NO;
    }
}
@end
