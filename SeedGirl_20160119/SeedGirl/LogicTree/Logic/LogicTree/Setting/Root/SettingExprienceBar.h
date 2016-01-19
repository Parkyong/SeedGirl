//
//  SettingExprienceBar.h
//  SeedGirl
//
//  Created by ParkHunter on 16/1/14.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingExprienceBar : UIView
- (void)setShowExperience:(NSInteger)currentExperience withUpdateExperience:(NSInteger)updateExperience;
+ (SettingExprienceBar *)getInstance;               //获取实例
@end
