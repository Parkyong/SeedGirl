//
//  SeedPlayer.h
//  SeedSocial
//
//  Created by ParkHunter on 15/5/12.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeedPlayerView.h"
typedef void(^readMSGBlockType)(BOOL isSuccess);

@interface SeedPlayer : UIViewController <VideoDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, copy)    NSString *movieUrl;
@end
