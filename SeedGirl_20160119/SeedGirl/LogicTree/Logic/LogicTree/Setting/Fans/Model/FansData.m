//
//  FansData.m
//  SeedGirl
//
//  Created by ParkHunter on 15/12/15.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "FansData.h"

@implementation FansData
- (void)setData:(id)_data{
    if (_data == nil) {
        return;
    }
    
    if ([_data objectForKey:@"icon"] != nil &&
        ![[_data objectForKey:@"icon"] isEqual:[NSNull null]]) {
        _fansIcon = [_data objectForKey:@"icon"];
    }
    
    if ([_data objectForKey:@"name"] != nil &&
        ![[_data objectForKey:@"name"] isEqual:[NSNull null]]) {
        _fansName = [_data objectForKey:@"name"];
    }

    if ([_data objectForKey:@"id"] != nil &&
        ![[_data objectForKey:@"id"] isEqual:[NSNull null]]) {
        _fansID = [_data objectForKey:@"id"];
    }

    if ([_data objectForKey:@"hxid"] != nil &&
        ![[_data objectForKey:@"hxid"] isEqual:[NSNull null]]) {
        _fansHxid = [_data objectForKey:@"hxid"];
    }

    if ([_data objectForKey:@"diamondCount"] != nil &&
        ![[_data objectForKey:@"diamondCount"] isEqual:[NSNull null]]) {
        _fansContributionDiamond = [[_data objectForKey:@"diamondCount"] integerValue];
    }
}
@end
