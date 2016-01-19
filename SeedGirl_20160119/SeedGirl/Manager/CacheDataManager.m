//
//  CacheDataManager.m
//  SeedGirl
//
//  Created by Admin on 15/12/11.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "CacheDataManager.h"

@implementation CacheDataManager

+ (instancetype)sharedInstance {
    static CacheDataManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedInstance = [[CacheDataManager alloc] init];
        sharedInstance.EmptyData = -50;
        sharedInstance.NoMoreData = -51;
    });
    return sharedInstance;
}

@end
