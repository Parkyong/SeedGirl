//
//  LoginView.h
//  SeedGirl
//  功能描述 - 登录根视图
//  Created by ParkHunter on 15/10/9.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIScrollView
//登录block
@property (copy, nonatomic) dispatch_block_t loginSuccessBlock;
//注册block
@property (copy, nonatomic) dispatch_block_t registerBlock;
//忘记密码
@property (copy, nonatomic) dispatch_block_t resetPasswordBlock;
//qq
@property (copy, nonatomic) dispatch_block_t qqBlock;
//首次加载
- (void)firstLoad;
@end
