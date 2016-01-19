//
//  RegisterViewController.h
//  SeedGirl
//  功能描述 - 注册控制器
//  Created by ParkHunter on 15/10/8.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSubViewController.h"

@interface RegisterViewController : BaseSubViewController
//内容类型，0 注册；1 找回密码
@property (nonatomic, assign) NSInteger contentType;

@end
