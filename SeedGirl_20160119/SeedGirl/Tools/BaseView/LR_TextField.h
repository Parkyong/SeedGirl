//
//  LR_TextField.h
//  SeedGirl
//  功能描述 - 登录注册输入文本框
//  Created by Admin on 15/12/24.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LR_TextField : UITextField
//填充高度
@property (nonatomic, assign) CGFloat paddingHeight;
//设置头图片
- (void)setHeadImage:(UIImage *)normalImage highlightedImage:(UIImage *)lightedImage;
@end
