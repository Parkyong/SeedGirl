//
//  RegisterView.h
//  SeedGirl
//  功能描述 - 注册根视图
//  Created by ParkHunter on 15/10/8.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIScrollView
//注册成功block
@property (nonatomic, copy) dispatch_block_t registerSuccessBlock;
//内容类型，0 注册；1 找回密码
@property (nonatomic, assign) NSInteger contentType;

@end
