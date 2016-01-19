//
//  MBFontAdapter.m
//  SeedGirl
//
//  Created by Admin on 15/10/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "MBFontAdapter.h"

#define IPHONE6_INCREMENT 2
#define IPHONE6PLUS_INCREMENT 3

@implementation MBFontAdapter

//默认缩放适配
+ (UIFont *)adjustFont:(UIFont *)font {
    return [self adjustFont:font solutionStatus:SolutionScale];
}

//自定义方案适配
+ (UIFont *)adjustFont:(UIFont *)font solutionStatus:(NSInteger)status {
    UIFont *newFont = nil;
    switch (status) {
        case SolutionCustom:
            if (IS_IPHONE_6) {
                newFont = [UIFont fontWithName:font.fontName size:font.pointSize+IPHONE6_INCREMENT];
            } else if (IS_IPHONE_6_PLUS) {
                newFont = [UIFont fontWithName:font.fontName size:font.pointSize+IPHONE6PLUS_INCREMENT];
            } else {
                newFont = font;
            }
            break;
        case SolutionScale:
            if (IS_IPHONE_6_PLUS) {
                newFont = [UIFont fontWithName:font.fontName size:font.pointSize*1.5];
            } else {
                newFont = font;
            }
            break;
        case NotSolution:
        default:
            newFont = font;
            break;
    }
    return newFont;
}

@end
