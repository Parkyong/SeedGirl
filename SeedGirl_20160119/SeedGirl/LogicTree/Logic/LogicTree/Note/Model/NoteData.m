//
//  NoteData.m
//  SeedGirl
//
//  Created by ParkHunter on 15/12/10.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "NoteData.h"

@implementation NoteData
- (void)setData:(id)_data{
    if (_data == nil) {
        return;
    }
    
    if ([_data objectForKey:@"name"] != nil &&
        ![[_data objectForKey:@"name"] isEqual:[NSNull null]]) {
        _userName = [_data objectForKey:@"name"];
    }
    
    if ([_data objectForKey:@"icon"] != nil &&
        ![[_data objectForKey:@"icon"] isEqual:[NSNull null]]) {
        _userIcon = [_data objectForKey:@"icon"];
    }
    
    if ([_data objectForKey:@"timeStamp"] != nil &&
        ![[_data objectForKey:@"timeStamp"] isEqual:[NSNull null]]) {
        _timeStamp = [_data objectForKey:@"timeStamp"];
    }
    if ([_data objectForKey:@"lastMSG"] != nil &&
        ![[_data objectForKey:@"lastMSG"] isEqual:[NSNull null]]) {
        _lastMSG = [_data objectForKey:@"lastMSG"];
    }
    if ([_data objectForKey:@"hxid"] != nil &&
         ![[_data objectForKey:@"hxid"] isEqual:[NSNull null]]) {
        _userHxid = [_data objectForKey:@"hxid"];
    }
    if ([_data objectForKey:@"isRead"] != nil &&
        ![[_data objectForKey:@"isRead"] isEqual:[NSNull null]]) {
        _isRead = [_data objectForKey:@"isRead"];
    }

}
@end
