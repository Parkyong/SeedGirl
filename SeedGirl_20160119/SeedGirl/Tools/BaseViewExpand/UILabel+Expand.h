//
//  UILabel+Expand.h
//  SeedSocial
//  功能描述 - UILabel扩展
//  Created by Admin on 15/4/27.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Expand)

//计算文本尺寸
- (CGSize)contentSizeWithMaxSize:(CGSize)maxSize;

//添加阴影
- (void)addShadowEffect;

@end
