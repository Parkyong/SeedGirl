//
//  SettingSignUpCell.h
//  SeedGirl
//
//  Created by ParkHunter on 16/1/13.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingSignUpCell : UITableViewCell
@property (nonatomic, strong) UIImageView   *symbolImageView;       //第一个图标
@property (nonatomic, strong) UILabel          *contentLabel;       //标题
@property (nonatomic, assign) BOOL                  isSignUp;       //是否签到
@end
