//
//  BaseLineView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/26.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "BaseSubLineView.h"
@interface BaseSubLineView ()
@property (nonatomic, assign) CGFloat     startX;       //离左边的距离
@property (nonatomic, assign) CGFloat       endX;       //离右边的距离（负数）
@property (nonatomic, strong) UIColor *lineColor;       //线条颜色
@end
@implementation BaseSubLineView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                   withStartX:(CGFloat)startX
                     withEndX:(CGFloat)endX
                withLineColor:(UIColor *)lineColor
{
    _startX     = startX;
    _endX       = endX;
    _lineColor  = lineColor;
    return [self initWithFrame:frame];
}

#pragma mark    代理方法
- (void)drawRect:(CGRect)rect{
    CGContextRef context    = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGColorRef strokeColor  = _lineColor.CGColor;
    CGContextSetStrokeColorWithColor(context, strokeColor);
    CGContextMoveToPoint(context, _startX, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width - _endX, rect.size.height);
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
    CGContextStrokePath(context);
}

- (void)changeColor:(UIColor *)color{
    _lineColor = color;
    [self setNeedsDisplay];
}
@end
