//
//  BindBankCard_M.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/25.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BaseLineView.h"
typedef void (^BindBankCard_MBlockType)();
@interface BindBankCard_M :UIView
@property (nonatomic, strong) UILabel           *inputTitleLabel;
@property (nonatomic, strong) UITextField *inputContentTextFiled;
@property (nonatomic, strong) BindBankCard_MBlockType  bankBlock;
@end
