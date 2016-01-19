//
//  UIImage+Expand.h
//  SeedSocial
//  功能描述 - 图片扩展
//  Created by Admin on 15/5/17.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Expand)

//从文件内容读取图片
+ (UIImage *)imageWithContentOfFile:(NSString *)path;

//创建图片指定颜色和大小
+ (UIImage *)imageWithColor:(UIColor *)color Size:(CGSize)size;

- (UIImage *)fixOrientation;

//添加毛玻璃效果
+ (UIImage *)imageBlur:(UIImage *)image;

@end
