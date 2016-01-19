//
//  SetupMyDiamondFooter.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SetupMyDiamondFooterTakeCashBlockType)();
@interface SetupMyDiamondFooter : UIView
@property (nonatomic, copy)SetupMyDiamondFooterTakeCashBlockType localBlock;
@end
