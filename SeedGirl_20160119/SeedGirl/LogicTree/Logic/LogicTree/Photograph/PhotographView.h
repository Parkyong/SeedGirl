//
//  PhotographView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/10/10.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotographAndRecordChangeView.h"
#import "ProgressBar.h"
#import "RecordDeleteButton.h"
typedef void (^switchAreaBlockType) (AreaType);
@interface PhotographView : UIView
@property (nonatomic, strong) UIView                    *recordArea;
@property (nonatomic, strong) UIButton              *viewDismissBTN;
@property (nonatomic, strong) UIButton             *toggleCameraBTN;
@property (nonatomic, strong) UIButton                    *flashBTN;
@property (nonatomic, strong) UIButton             *takePhotoButton;
@property (nonatomic, strong) UIButton                *recordButton;
@property (nonatomic, strong) UIButton           *importPhotoButton;
@property (nonatomic, strong) UIButton           *importVideoButton;
@property (nonatomic, strong) UIButton           *videoSelectButton;
@property (nonatomic, strong) RecordDeleteButton *videoDeleteButton;
@property (nonatomic, strong) ProgressBar       *recordProgressView;
@property (nonatomic, copy)   switchAreaBlockType   switchAreaBlock;

- (void)hideRecordButton;
- (void)hideCameraButton;
- (void)showOnlyCameraButtonAction;                      //只显示照相
- (void)showOnlyRecordButtonAction;                      //只显示摄像
@end
