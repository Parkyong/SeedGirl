//
//  SkimVideoView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/10/14.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeedPlayerView.h"
@interface SkimVideoView : UIView
@property (nonatomic, strong) UIViewController  *parentController;
@property (nonatomic, strong) UIImageView         *coverImageView;
@property (nonatomic, strong) SeedPlayerView       *showVideoArea;
@property (nonatomic, strong) UITapGestureRecognizer       *tapGR;
@property (nonatomic, strong) UIButton    *selectCoverImageButton;
@property (nonatomic, strong) UIButton              *returnButton;
@property (nonatomic, strong) UIButton              *finishButton;

- (void)hidePlayVideoButton:(BOOL)isHidden;
@end
