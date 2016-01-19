//
//  BindBankCardView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/25.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BindBankCard_M.h"
#import "BindBankCard.h"

typedef void (^BindBankCardViewBlock)();
@interface BindBankCardView : UIView
@property (nonatomic, strong) BindBankCard         *accountRow;
@property (nonatomic, strong) BindBankCard_M          *bankRow;
@property (nonatomic, strong) BindBankCard            *nameRow;
@property (nonatomic, strong) BindBankCard     *mobilePhoneNum;
@property (nonatomic, copy)   BindBankCardViewBlock localBlock;
- (NSString *)getConfirmMessage;
@end
