//
//  CommonEditView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/10/8.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGTextField.h"

@interface CommonEditView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UIButton  *headButton;
@property (nonatomic, strong) SGTextField *editArea;

@end
