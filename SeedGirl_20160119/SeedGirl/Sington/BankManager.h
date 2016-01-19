//
//  BankManager.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/20.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankRuleData.h"

@interface BankManager : NSObject
@property (nonatomic, strong) BankRuleData *bankRuleData;
+(instancetype)manager;
@end
