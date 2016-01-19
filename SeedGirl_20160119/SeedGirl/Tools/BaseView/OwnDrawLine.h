//
//  OwnDrawLine.h
//  SeedSocial
//  功能描述 - 画线
//  Created by Admin on 15/5/17.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwnDrawLine : UIView

//颜色，起始点，终点，线宽度
- (void)drawLineWithColor:(UIColor *)color
               StartPoint:(CGPoint)startPoint
                LastPoint:(CGPoint)lastPoint
                LineWidth:(CGFloat)lineWidth;

@end
