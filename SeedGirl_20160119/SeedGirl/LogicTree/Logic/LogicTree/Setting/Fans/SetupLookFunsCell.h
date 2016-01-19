//
//  SetupLookFunsCell.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/25.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FansData.h"
@interface SetupLookFunsCell : UITableViewCell
@property (nonatomic, strong) UIImageView     *headImageView;
@property (nonatomic, strong) UILabel         *nickNameLabel;
@property (nonatomic, strong) UILabel     *spendDiamondLabel;
@property (nonatomic, strong) UIButton           *noteButton;
-(void)setCellData:(FansData *)data;
@end
