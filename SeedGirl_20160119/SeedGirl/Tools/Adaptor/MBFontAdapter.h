//
//  MBFontAdapter.h
//  SeedGirl
//  功能描述 - 字体基类适配
//  Created by Admin on 15/10/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    NotSolution = 0,
    SolutionScale,
    SolutionCustom
} SolutionStatus;

@interface MBFontAdapter : NSObject

//默认缩放适配
+ (UIFont *)adjustFont:(UIFont *)font;

//自定义方案适配
+ (UIFont *)adjustFont:(UIFont *)font solutionStatus:(NSInteger)status;

@end
