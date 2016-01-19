//
//  UIColor+Expand.h
//  SeedSocial
//  功能描述 - 颜色扩展
//  Created by Admin on 15/5/17.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Expand)

//将十六进制色值转换
+ (UIColor *)colorWithHexText:(NSString *)_hexText;

@end
