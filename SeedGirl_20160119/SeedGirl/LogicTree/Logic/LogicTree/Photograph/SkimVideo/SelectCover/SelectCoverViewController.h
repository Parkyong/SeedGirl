//
//  SelectCoverViewController.h
//  SeedGirl
//
//  Created by ParkHunter on 15/10/16.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SELECTCOVERIMAGEBLOCKTYPE)(UIImage * coverImage);
@interface SelectCoverViewController : UIViewController
@property (nonatomic, strong) NSURL                    *videoURL;
//@property (nonatomic, assign) CGFloat              videoDuration;
@property (nonatomic, copy) SELECTCOVERIMAGEBLOCKTYPE localBlock;
@end
