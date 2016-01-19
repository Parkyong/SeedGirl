//
//  UserData.m
//  SeedSocial
//
//  Created by Admin on 15/4/23.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import "UserData.h"
#import "SeedTagData.h"

@implementation UserData

- (instancetype)init{
    if(self = [super init]){
        _userName               = @"";
        _userIcon               = @"";
        _userLevel              = 0;
        _userFans               = 0;
        _userTagList            = nil;
        _userShowList           = nil;
        _userAge                = 0;
        _userHeigth             = 0;
        _userCity               = @"";
        _userVocation           = @"";
        _userInterst            = @"";
        _userDescription        = @"";
        _userExperience         = 0;
        _userUpdateExperience   = 0;
    }
    return self;
}


//设置数据
- (void)setUserData:(id)_data {
    if(_data == nil)
        return;
    
    if ([_data objectForKey:@"user_name"] != nil &&
        [_data objectForKey:@"user_name"] != [NSNull null]) {
        _userName = [NSString stringWithFormat:@"%@", [_data objectForKey:@"user_name"]];
    }
    
    if([_data objectForKey:@"user_icon"] != nil &&
       [_data objectForKey:@"user_icon"] != [NSNull null]){
        _userIcon = [NSString stringWithFormat:@"%@",[_data objectForKey:@"user_icon"]];
    }
    
    if([_data objectForKey:@"user_level"] != nil &&
       [_data objectForKey:@"user_level"] != [NSNull null]){
        _userLevel = [[_data objectForKey:@"user_level"] integerValue];
    }
    
    if([_data objectForKey:@"user_fans"] != nil &&
       [_data objectForKey:@"user_fans"] != [NSNull null]){
        _userFans = [[_data objectForKey:@"user_fans"] integerValue];
    }
    
    if([_data objectForKey:@"user_taglist"] != nil &&
       [_data objectForKey:@"user_taglist"] != [NSNull null]){
        NSArray *tagArray = [_data objectForKey:@"user_taglist"];
        _userTagList = [NSMutableArray array];
        for (NSDictionary *dictItem in tagArray) {
            SeedTagData *data = [[SeedTagData alloc] init];
            [data setSeedTagData:dictItem];
            [_userTagList addObject:data];
        }
    }
    
    if([_data objectForKey:@"user_showlist"] != nil &&
       [_data objectForKey:@"user_showlist"] != [NSNull null]){
        _userShowList = [_data objectForKey:@"user_showlist"];
    }
    
    if([_data objectForKey:@"user_age"] != nil &&
       [_data objectForKey:@"user_age"] != [NSNull null]){
        _userAge = [[_data objectForKey:@"user_age"] integerValue];
    }
    
    if([_data objectForKey:@"user_height"] != nil &&
       [_data objectForKey:@"user_height"] != [NSNull null]){
        _userHeigth = [[_data objectForKey:@"user_height"] integerValue];
    }
    
    if([_data objectForKey:@"user_city"] != nil &&
       [_data objectForKey:@"user_city"] != [NSNull null]){
        _userCity = [NSString stringWithFormat:@"%@", [_data objectForKey:@"user_city"]];
    }
    
    if([_data objectForKey:@"user_vocation"] != nil &&
       [_data objectForKey:@"user_vocation"] != [NSNull null]){
        _userVocation = [NSString stringWithFormat:@"%@", [_data objectForKey:@"user_vocation"]];
    }
    
    if([_data objectForKey:@"user_interests"] != nil &&
       [_data objectForKey:@"user_interests"] != [NSNull null]){
        _userInterst = [NSString stringWithFormat:@"%@", [_data objectForKey:@"user_interests"]];
    }
    
    if([_data objectForKey:@"user_description"] != nil &&
       [_data objectForKey:@"user_description"] != [NSNull null]){
        _userDescription = [NSString stringWithFormat:@"%@", [_data objectForKey:@"user_description"]];
    }
    
    if([_data objectForKey:@"user_experience"] != nil &&
       [_data objectForKey:@"user_experience"] != [NSNull null]){
        _userExperience = [[_data objectForKey:@"user_experience"] integerValue];
    }
    
    if([_data objectForKey:@"update_experience"] != nil &&
       [_data objectForKey:@"update_experience"] != [NSNull null]){
        _userUpdateExperience = [[_data objectForKey:@"update_experience"] integerValue];
    }
}

- (void)setUserDataWithUpdateData:(id)_data{
    if(_data == nil)
        return;
    
    if ([_data objectForKey:@"name"] != nil &&
        [_data objectForKey:@"name"] != [NSNull null]) {
        _userName = [NSString stringWithFormat:@"%@", [_data objectForKey:@"name"]];
    }
    
    if([_data objectForKey:@"taglist"] != nil &&
       [_data objectForKey:@"taglist"] != [NSNull null]){
        NSArray *tagArray = [_data objectForKey:@"taglist"];
        _userTagList = [NSMutableArray array];
        for (NSDictionary *dictItem in tagArray) {
            SeedTagData *data = [[SeedTagData alloc] init];
            [data setSeedTagData:dictItem];
            [_userTagList addObject:data];
        }
    }
    
    if([_data objectForKey:@"showlist"] != nil &&
       [_data objectForKey:@"showlist"] != [NSNull null]){
        _userShowList = [_data objectForKey:@"showlist"];
    }
    
    if([_data objectForKey:@"age"] != nil &&
       [_data objectForKey:@"age"] != [NSNull null]){
        _userAge = [[_data objectForKey:@"age"] integerValue];
    }
    
    if([_data objectForKey:@"height"] != nil &&
       [_data objectForKey:@"height"] != [NSNull null]){
        _userHeigth = [[_data objectForKey:@"height"] integerValue];
    }
    
    if([_data objectForKey:@"city"] != nil &&
       [_data objectForKey:@"city"] != [NSNull null]){
        _userCity = [NSString stringWithFormat:@"%@", [_data objectForKey:@"city"]];
    }
    
    if([_data objectForKey:@"vocation"] != nil &&
       [_data objectForKey:@"vocation"] != [NSNull null]){
        _userVocation = [NSString stringWithFormat:@"%@", [_data objectForKey:@"vocation"]];
    }
    
    if([_data objectForKey:@"interests"] != nil &&
       [_data objectForKey:@"interests"] != [NSNull null]){
        _userInterst = [NSString stringWithFormat:@"%@", [_data objectForKey:@"interests"]];
    }
    
    if([_data objectForKey:@"description"] != nil &&
       [_data objectForKey:@"description"] != [NSNull null]){
        _userDescription = [NSString stringWithFormat:@"%@", [_data objectForKey:@"description"]];
    }
    
}

@end
