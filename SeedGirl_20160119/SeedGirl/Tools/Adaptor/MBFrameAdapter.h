//
//  AdaptRect.h
//  SeedSocial
//  功能描述 - 坐标适配
//  Created by Admin on 15/5/17.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

@interface MBFrameAdapter : NSObject

+ (instancetype)adapter;

//rect适配
- (CGRect)rectAdaption:(CGRect)rect;

//size适配
- (CGSize)sizeAdaption:(CGSize)size;

//宽度适配
- (CGFloat)widthAdaption:(CGFloat)width;

//高度适配
- (CGFloat)heightAdaption:(CGFloat)height;

@end
