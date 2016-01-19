//
//  SetupMyDiamondBCell.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BindBankCardProtocol;

@interface SetupMyDiamondBCell : UITableViewCell
@property (nonatomic, strong) UILabel         *contentLabel;
@property (nonatomic, strong) UIImageView    *markImageView;
@property (nonatomic, strong) UILabel      *bankCardAccount;
@property (nonatomic, strong) UIButton       *bindingButton;
@property (nonatomic, assign) id <BindBankCardProtocol>delegate;
- (void)setSetupMyDiamondBCellData;
@end

@protocol BindBankCardProtocol <NSObject>
- (void)bindBankCardAction:(SetupMyDiamondBCell *)cell withIsBindStatus:(BOOL)isBind;
@end