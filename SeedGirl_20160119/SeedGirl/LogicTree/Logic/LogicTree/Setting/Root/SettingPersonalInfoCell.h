//
//  SettingPersonalInfoCell.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/22.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingPersonalInfoProtocol;
@interface SettingPersonalInfoCell : UITableViewCell
@property (nonatomic, assign) id<SettingPersonalInfoProtocol>delegate;
-(void)setSettingPersonalInfoCellData;
@end
@protocol SettingPersonalInfoProtocol <NSObject>
- (void)changeToPersonalInfoPage:(SettingPersonalInfoCell *)cell;
@end