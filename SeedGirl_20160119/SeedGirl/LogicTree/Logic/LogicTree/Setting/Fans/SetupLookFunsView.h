//
//  SetupLookFunsView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/25.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FansData.h"
#import "UserManager.h"
#import "UserData.h"
#import "ChatViewController.h"

typedef void(^FansSelectedBlock)(FansData *fansData);
@interface SetupLookFunsView : UIView <ChatViewControllerDelegate>
@property (nonatomic, copy) FansSelectedBlock selectedBlock;
- (void)firstLoad;
@end
