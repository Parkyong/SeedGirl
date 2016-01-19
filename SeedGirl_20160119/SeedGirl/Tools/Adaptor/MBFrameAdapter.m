//
//  AdaptRect.m
//  SeedSocial
//
//  Created by Admin on 15/5/17.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import "MBFrameAdapter.h"

@interface MBFrameAdapter ()

//设计标准尺寸
@property (assign) NSInteger standardWidth;
@property (assign) NSInteger standardHeight;

//缩放比例
@property (assign) CGFloat autoSizeScaleX;
@property (assign) CGFloat autoSizeScaleY;

@end

@implementation MBFrameAdapter
@synthesize standardWidth,standardHeight,autoSizeScaleX,autoSizeScaleY;

+ (instancetype) adapter
{
    static MBFrameAdapter *sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance->standardWidth = 375;
        sharedInstance->standardHeight = 667;
        [sharedInstance setAutoSizeScale];
    });
    
    return sharedInstance;
}

//设置适配比例
- (void)setAutoSizeScale
{
    //以竖屏为标准，如果是iphone4s则按照iphone5计算
    if (ScreenHeight == standardHeight) {
        autoSizeScaleX = 1.0f;
        autoSizeScaleY = 1.0f;
    } else {
        autoSizeScaleX = floorf(ScreenWidth/standardWidth*100)/100;
        
        if (ScreenHeight < 568) {
            autoSizeScaleY = floorf(568/standardHeight*100)/100;
        } else {
            autoSizeScaleY = floorf(ScreenHeight/standardHeight*100)/100;
        }
    }
}

//rect适配
- (CGRect)rectAdaption:(CGRect)rect {
    CGFloat newX = rect.origin.x * autoSizeScaleX;
    CGFloat newY = rect.origin.y * autoSizeScaleY;
    CGFloat newWidth = rect.size.width * autoSizeScaleX;
    CGFloat newHeight = rect.size.height * autoSizeScaleY;
    return CGRectMake(newX, newY, newWidth, newHeight);
}

//size适配
- (CGSize)sizeAdaption:(CGSize)size {
    CGFloat newWidth = size.width * autoSizeScaleX;
    CGFloat newHeight = size.height * autoSizeScaleY;
    return CGSizeMake(newWidth, newHeight);
}

//宽度适配
- (CGFloat)widthAdaption:(CGFloat)width {
    return width * autoSizeScaleX;
}

//高度适配
- (CGFloat)heightAdaption:(CGFloat)height {
    return height * autoSizeScaleY;
}

@end
