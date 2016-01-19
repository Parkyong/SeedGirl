//
//  ResizeTool.h
//  RecordingTest
//
//  Created by ParkHunter on 15/8/14.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ResizeTool : NSObject
+ (void)setView:(UIView *)view toSizeWidth:(CGFloat)width;
+ (void)setView:(UIView *)view toOriginX:(CGFloat)x;
+ (void)setView:(UIView *)view toOriginY:(CGFloat)y;
+ (void)setView:(UIView *)view toOrigin:(CGPoint)origin;
@end
