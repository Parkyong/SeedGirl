//
//  BaseLineView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/26.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseSubLineView :UIView
- (instancetype)initWithFrame:(CGRect)frame
                   withStartX:(CGFloat)startX
                     withEndX:(CGFloat)endX
                withLineColor:(UIColor *)lineColor;
//endX(为负数：离右边的距离)

- (void)changeColor:(UIColor *)color;
@end