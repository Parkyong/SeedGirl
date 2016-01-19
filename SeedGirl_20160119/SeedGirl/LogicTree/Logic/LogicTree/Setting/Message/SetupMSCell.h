//
//  SetupMSCell.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SetupMessageSettingProtocol;

typedef NS_ENUM(NSInteger, SETUPMESSAGESETTING){
    SETUPMESSAGESETTING_NOTE,
    SETUPMESSAGESETTING_VIDEOREQUEST
};

typedef void (^SwitchMessageSettingBlockType)(SETUPMESSAGESETTING, BOOL);
@interface SetupMSCell : UITableViewCell
@property (nonatomic, strong) UILabel   *contentLabel;
@property (nonatomic, strong) UISwitch *settingSwitch;
@property (nonatomic, assign) id <SetupMessageSettingProtocol>delegate;
@end

@protocol SetupMessageSettingProtocol <NSObject>
- (void)changeMessageSettingWithSetupMSCell:(SetupMSCell *)cell withSwitch:(BOOL)on;
@end
