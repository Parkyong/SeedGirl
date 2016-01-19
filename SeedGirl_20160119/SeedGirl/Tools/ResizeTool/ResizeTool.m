//
//  ResizeTool.m
//  RecordingTest
//
//  Created by ParkHunter on 15/8/14.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "ResizeTool.h"

@implementation ResizeTool
+ (void)setView:(UIView *)view toSizeWidth:(CGFloat)width
{
    CGRect frame = view.frame;
    frame.size.width = width;
    view.frame = frame;
}

+ (void)setView:(UIView *)view toOriginX:(CGFloat)x
{
    CGRect frame = view.frame;
    frame.origin.x = x;
    view.frame = frame;
}

+ (void)setView:(UIView *)view toOriginY:(CGFloat)y
{
    CGRect frame = view.frame;
    frame.origin.y = y;
    view.frame = frame;
}

+ (void)setView:(UIView *)view toOrigin:(CGPoint)origin
{
    CGRect frame = view.frame;
    frame.origin = origin;
    view.frame = frame;
}
@end
