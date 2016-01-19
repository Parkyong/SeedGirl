//
//  SetupMyDiamondLCell.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SetupMyDiamondLCellProtocol;
@interface SetupMyDiamondLCell : UITableViewCell
@property (nonatomic, strong) UILabel         *contentLabel;
@property (nonatomic, strong) UIImageView    *markImageView;
@property (nonatomic, strong) UITextField     *diamondCount;
@property (nonatomic, strong) UILabel        *mentionAmount;
@property (nonatomic, assign) id <SetupMyDiamondLCellProtocol> delegate;
- (void)resignFocusAction;
@end
@protocol SetupMyDiamondLCellProtocol <NSObject>
-(void)setupMyDiamondLCellDisPlayMoneyCount:(SetupMyDiamondLCell *)cell withMoney:(NSInteger)money;
@end