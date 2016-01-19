//
//  SetupMyDiamondHeader.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetupMyDiamondHeader : UIView
@property (nonatomic, strong) UILabel   *mentionedCountLabel;
@property (nonatomic, strong) UILabel         *nickNameLabel;
@property (nonatomic, strong) UILabel *haveDiamondCountLabel;
- (void)setSetupMyDiamondHeaderData;
@end
