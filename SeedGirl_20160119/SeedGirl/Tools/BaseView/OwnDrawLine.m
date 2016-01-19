//
//  OwnDrawLine.m
//  SeedSocial
//
//  Created by Admin on 15/5/17.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import "OwnDrawLine.h"
#import <CoreGraphics/CoreGraphics.h>

@interface OwnDrawLine ()

@property (strong, nonatomic) UIColor *lineColor;
@property (assign) CGPoint lineStartPoint;
@property (assign) CGPoint lineLastPoint;
@property (assign) CGFloat lineWidth;

@end

@implementation OwnDrawLine

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setClipsToBounds:NO];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextMoveToPoint(context, self.lineStartPoint.x, self.lineStartPoint.y);
    CGContextAddLineToPoint(context, self.lineLastPoint.x, self.lineLastPoint.y);
    CGContextStrokePath(context);
}

//颜色，起始点，终点，线宽度
- (void)drawLineWithColor:(UIColor *)color
               StartPoint:(CGPoint)startPoint
                LastPoint:(CGPoint)lastPoint
                LineWidth:(CGFloat)lineWidth {
    self.lineColor = color;
    self.lineStartPoint = startPoint;
    self.lineLastPoint = lastPoint;
    self.lineWidth = lineWidth;
    
    [self setNeedsDisplay];
}

@end
