//
//  SeedPlayerView.h
//  SeedSocial
//
//  Created by ParkHunter on 15/5/12.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol VideoDelegate <NSObject>
@optional
- (void) Touchspeed:(CGFloat)Percentage;
- (void) Touchretreat:(CGFloat)Percentage;
- (void) IncreaseTheVolume;
- (void) DecreaseTheVolume;
@end

@interface SeedPlayerView : UIView
{
    float x;
    float y;
    float volume;
}

@property (nonatomic, strong)           AVPlayer *player;
@property(nonatomic,  assign)           float     volume;
@property (nonatomic, assign) id<VideoDelegate> delegate;
@end
