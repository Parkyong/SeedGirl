//
//  NSString+Expand.h
//  SeedSocial
//  功能描述 - NSString扩展
//  Created by Admin on 15/4/27.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Expand)

//计算字体size
- (CGSize)sizeWithFont:(UIFont *)font WithMaxSize:(CGSize)maxSize ByLineBreakMode:(NSLineBreakMode)lineBreakMode;

//判断字符串是否相等
+ (BOOL)isEqualWithFromString:(NSString *)fromString
                 WithToString:(NSString *)toString;

//判断字符串是否为空
- (BOOL)isEmptyString;

//md5
- (NSString *)MD5Hash;

@end
