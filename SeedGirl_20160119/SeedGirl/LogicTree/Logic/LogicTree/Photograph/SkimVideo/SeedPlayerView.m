//
//  SeedPlayerView.m
//  SeedSocial
//
//  Created by ParkHunter on 15/5/12.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import "SeedPlayerView.h"

#define UI_SCreen_Width         [UIScreen mainScreen].bounds.size.width
#define UI_SCreen_Height        [UIScreen mainScreen].bounds.size.height

@implementation SeedPlayerView
@synthesize volume;
@synthesize delegate;
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer*)player {
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    x = (touchPoint.x);
    y = (touchPoint.y);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    if ((touchPoint.x - x) >= 50 && (touchPoint.y - y) <= 50 && (touchPoint.y - y) >= -50)
    {
        NSLog(@"快进");
        CGFloat offSet      = touchPoint.x - x;
        CGFloat Percentage  = offSet/UI_SCreen_Width;
        if ([delegate respondsToSelector:@selector(Touchspeed:)])
        {
            [delegate Touchspeed:(Percentage)];
        }
    }
    
    if ((x - touchPoint.x) >= 50 && (y - touchPoint.y) <= 50 && (y - touchPoint.y) >= -50)
    {
        NSLog(@"快退");
        
        CGFloat offSet      = x - touchPoint.x;
        CGFloat Percentage  = offSet/UI_SCreen_Width;
        if ([delegate respondsToSelector:@selector(Touchretreat:)])
        {
            [delegate Touchretreat:Percentage];
        }
        
    }
        if ((touchPoint.y - y) >= 50 && (touchPoint.x - x) <= 50 && (touchPoint.x - x) >= -50)
        {
            NSLog(@"减小音量");
            if ([delegate respondsToSelector:@selector(DecreaseTheVolume)]) {
                [delegate DecreaseTheVolume];
            }
        }
        if ((y - touchPoint.y) >= 50)
        {
            NSLog(@"加大音量");
            if ([delegate respondsToSelector:@selector(IncreaseTheVolume)]) {
                [delegate IncreaseTheVolume];
            }
        }
}

@end
