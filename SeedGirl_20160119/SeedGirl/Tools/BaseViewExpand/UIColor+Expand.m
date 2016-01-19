//
//  UIColor+Expand.m
//  SeedSocial
//
//  Created by Admin on 15/5/17.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import "UIColor+Expand.h"

@implementation UIColor (Expand)

//将十六进制色值转换
+ (UIColor *)colorWithHexText:(NSString *)_hexText
{
    NSString *hexText = [_hexText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(hexText.length < 6)
    {
        return [UIColor blackColor];
    }

    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[_hexText substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[_hexText substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[_hexText substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)
                           green:(float)(green/255.0f)
                            blue:(float)(blue/255.0f)
                           alpha:1.0f];
}

@end
