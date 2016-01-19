//
//  BankManager.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/20.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "BankManager.h"

@implementation BankManager
+(instancetype)manager{
    static BankManager * defaultManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [[BankManager alloc] init];
    });
    return defaultManager;
}
@end
