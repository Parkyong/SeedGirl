//
//  PhotographAndRecordChangeView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/10/10.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CHANGEPHOTOGRAPHANDRECORDBLOCKTYPE)(NSInteger);
@interface PhotographAndRecordChangeView : UIView
@property (nonatomic, assign) AreaType currentArea;
@property (nonatomic, copy) CHANGEPHOTOGRAPHANDRECORDBLOCKTYPE changeBlock;
- (void)outControlChangeCameraAreaAction:(AreaType)areType;
//隐藏视频button
- (void)hideRecordButton;
- (void)hideCameraButton;
@end
