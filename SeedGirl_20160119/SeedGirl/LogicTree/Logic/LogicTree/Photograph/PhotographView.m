//
//  PhotographView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/10.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "PhotographView.h"
@interface PhotographView ()
//最上面
@property (nonatomic, strong) UIView                         *upContainer;
@property (nonatomic, strong) UIView                       *downContainer;
@property (nonatomic, strong) UIView                      *photoContainer;
@property (nonatomic, strong) UIView                     *recordContainer;
@property (nonatomic, strong) PhotographAndRecordChangeView *PARChageView;
@property (nonatomic, strong) UILabel                           *tipLabel;
@property (nonatomic, strong) UIView                       *referenceView;
@property (nonatomic, strong) UISwipeGestureRecognizer       *leftSwipeGR;
@property (nonatomic, strong) UISwipeGestureRecognizer      *rightSwipeGR;
@end
@implementation PhotographView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
        self.backgroundColor = RGB(27, 27, 35);
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self addViews];
    [self addLimit];
    [self addFunction];
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.upContainer];
    [self addSubview:self.recordArea];
    [self addSubview:self.downContainer];
    
    [self.upContainer addSubview:self.viewDismissBTN];
    [self.upContainer addSubview:self.toggleCameraBTN];
    [self.upContainer addSubview:self.flashBTN];
    
    [self.downContainer addSubview:self.recordProgressView];
    [self.downContainer addSubview:self.PARChageView];
    [self.downContainer addSubview:self.photoContainer];
    [self.downContainer addSubview:self.recordContainer];
    
    [self.photoContainer addSubview:self.takePhotoButton];
    [self.photoContainer addSubview:self.importPhotoButton];
    [self.recordContainer addSubview:self.recordButton];
    [self.recordContainer addSubview:self.importVideoButton];
    [self.recordContainer addSubview:self.referenceView];
    [self.recordContainer addSubview:self.tipLabel];
    [self.recordContainer addSubview:self.videoSelectButton];
    [self.recordContainer addSubview:self.videoDeleteButton];
//    self.upContainer.backgroundColor = [UIColor blueColor];
}

#pragma mark    -
#pragma mark    添加限制
- (void)addLimit{
    WeakSelf;
    [self.upContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(20);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(@(44));
    }];
    
    [self.recordArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.upContainer.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(@([Adaptor returnAdaptorValue:346]));
    }];
    
    [self.downContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.recordArea.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.viewDismissBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(9);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.centerY.equalTo(weakSelf.upContainer.mas_centerY);
    }];
    
    [self.toggleCameraBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-9);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.centerY.equalTo(weakSelf.upContainer.mas_centerY);
    }];
    
    [self.flashBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.toggleCameraBTN.mas_left).with.offset(-4);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.centerY.equalTo(weakSelf.upContainer.mas_centerY);
    }];
    
    [self.recordProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.downContainer.mas_top);
        make.left.equalTo(weakSelf.downContainer.mas_left);
        make.right.equalTo(weakSelf.downContainer.mas_right);
        make.height.equalTo(@([Adaptor returnAdaptorValue:9]));
    }];
    
    [self.PARChageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.recordProgressView.mas_bottom).with.offset([Adaptor returnAdaptorValue:9]);
        make.left.equalTo(weakSelf.downContainer.mas_left).with.offset([Adaptor returnAdaptorValue:93]);
        make.right.equalTo(weakSelf.downContainer.mas_right).with.offset(-[Adaptor returnAdaptorValue:93]);
        make.height.equalTo(@([Adaptor returnAdaptorValue:26]));
    }];
    
    [self.photoContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.PARChageView.mas_bottom).with.offset([Adaptor returnAdaptorValue:13]);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.recordContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.PARChageView.mas_bottom).with.offset([Adaptor returnAdaptorValue:13]);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.takePhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.photoContainer.mas_top);
        make.centerX.equalTo(weakSelf.photoContainer.mas_centerX);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:74], [Adaptor returnAdaptorValue:74]));
    }];
    
    [self.recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.recordContainer.mas_top);
        make.centerX.equalTo(weakSelf.recordContainer.mas_centerX);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:74], [Adaptor returnAdaptorValue:74]));
    }];
    
    [self.importPhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.photoContainer.mas_right).with.offset(-[Adaptor returnAdaptorValue:30]);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:43], [Adaptor returnAdaptorValue:43]));
        make.centerY.equalTo(weakSelf.takePhotoButton.mas_centerY);
    }];
    
    [self.importVideoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.recordContainer.mas_right).with.offset(-[Adaptor returnAdaptorValue:30]);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:43], [Adaptor returnAdaptorValue:43]));
        make.centerY.equalTo(weakSelf.recordButton.mas_centerY);
    }];
    
    [self.referenceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.recordContainer.mas_left).with.offset([Adaptor returnAdaptorValue:30]);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:43], [Adaptor returnAdaptorValue:43]));
        make.centerY.equalTo(weakSelf.recordButton.mas_centerY);
    }];
    
    [self.videoSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.importVideoButton.mas_centerX);
        make.centerY.equalTo(weakSelf.importVideoButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:38], [Adaptor returnAdaptorValue:38]));
    }];
    
    [self.videoDeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.referenceView.mas_centerX);
        make.centerY.equalTo(weakSelf.referenceView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake([Adaptor returnAdaptorValue:38], [Adaptor returnAdaptorValue:38]));
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.recordContainer.mas_left);
        make.right.equalTo(weakSelf.recordContainer.mas_right);
        make.top.equalTo(weakSelf.recordButton.mas_bottom).with.offset([Adaptor returnAdaptorValue:13]);
        make.height.equalTo(@([Adaptor returnAdaptorValue:13]));
    }];
}

#pragma mark    -
#pragma mark    添加功能
- (void)addFunction{
    WeakSelf;
    self.PARChageView.changeBlock = ^(AreaType area){
        if (area == PhotographArea) {
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.photoContainer.alpha  = 1;
                weakSelf.recordContainer.alpha = 0;
            }];
            [weakSelf settingCameraView:YES];
        }
        
        if (area == RecordArea) {
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.photoContainer.alpha  = 0;
                weakSelf.recordContainer.alpha = 1;
            }];
            [weakSelf settingCameraView:NO];
        }

        if (weakSelf.switchAreaBlock != nil) {
            weakSelf.switchAreaBlock(area);
        }
    };
}

#pragma mark    -
#pragma mark    懒加载对象
- (UIView *)upContainer{
    if (_upContainer == nil) {
        _upContainer = [[UIView alloc] init];
        _upContainer.backgroundColor = RGB(27, 27, 35);
    }
    return _upContainer;
}

- (UIView *)recordArea{
    if (_recordArea == nil) {
        _recordArea = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [Adaptor returnAdaptorValue:355])];
        _recordArea.backgroundColor = [UIColor clearColor];
        UISwipeGestureRecognizer *leftSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(changeBetweenPhotographAndRecord:)];
        [leftSwipeGR setDirection:UISwipeGestureRecognizerDirectionLeft];
        [_recordArea addGestureRecognizer:leftSwipeGR];
        UISwipeGestureRecognizer *rightSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(changeBetweenPhotographAndRecord:)];
        [_recordArea addGestureRecognizer:rightSwipeGR];
        [rightSwipeGR setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    return _recordArea;
}

- (UIView *)downContainer{
    if (_downContainer == nil) {
        _downContainer = [[UIView alloc] init];
        _downContainer.backgroundColor = RGB(15, 15, 21);
        self.leftSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(changeBetweenPhotographAndRecord:)];
        [self.leftSwipeGR setDirection:UISwipeGestureRecognizerDirectionLeft];
        [_downContainer addGestureRecognizer:self.leftSwipeGR];
        self.rightSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(changeBetweenPhotographAndRecord:)];
        [_downContainer addGestureRecognizer:self.rightSwipeGR];
        [self.rightSwipeGR setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    return _downContainer;
}

- (UIButton *)viewDismissBTN{
    if (_viewDismissBTN == nil) {
        _viewDismissBTN = [[UIButton alloc] init];
        [_viewDismissBTN setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"viewDismiss.png"]] forState:UIControlStateNormal];
        [_viewDismissBTN setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"viewDismiss_s.png"]] forState:UIControlStateHighlighted];
    }
    return _viewDismissBTN;
}

- (UIButton *)toggleCameraBTN{
    if (_toggleCameraBTN == nil) {
        _toggleCameraBTN = [[UIButton alloc] init];
        [_toggleCameraBTN setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"toggleCamera.png"]] forState:UIControlStateNormal];
        [_toggleCameraBTN setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"toggleCamera_s.png"]] forState:UIControlStateHighlighted];
        [_toggleCameraBTN setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"toggleCamera_s.png"]] forState:UIControlStateSelected];
    }
    return _toggleCameraBTN;
}

- (UIButton *)flashBTN{
    if (_flashBTN == nil) {
        _flashBTN = [[UIButton alloc] init];
        [_flashBTN setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"flash.png"]] forState:UIControlStateNormal];
        [_flashBTN setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"flash_s.png"]] forState:UIControlStateHighlighted];
        [_flashBTN setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"flash_s.png"]] forState:UIControlStateSelected];
    }
    return _flashBTN;
}

- (PhotographAndRecordChangeView *)PARChageView{
    if (_PARChageView == nil) {
        CGFloat width = ScreenWidth - 2*[Adaptor returnAdaptorValue:93];
        _PARChageView = [[PhotographAndRecordChangeView alloc] initWithFrame:CGRectMake(0, 0, width, [Adaptor returnAdaptorValue:26])];
        _PARChageView.userInteractionEnabled = YES;
    }
    return _PARChageView;
}

- (UIView *)photoContainer{
    if (_photoContainer == nil) {
        _photoContainer = [[UIView alloc] init];
    }
    return _photoContainer;
}

- (UIButton *)importPhotoButton{
    if (_importPhotoButton == nil) {
        _importPhotoButton = [[UIButton alloc] init];
        [_importPhotoButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"improtPhoto.png"]] forState:UIControlStateNormal];
        [_importPhotoButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"improtPhoto.png"]] forState:UIControlStateSelected];
        [_importPhotoButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"improtPhoto.png"]] forState:UIControlStateHighlighted];
    }
    return _importPhotoButton;
}

- (UIButton *)importVideoButton{
    if (_importVideoButton == nil) {
        _importVideoButton = [[UIButton alloc] init];
        [_importVideoButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"importVideo.png"]] forState:UIControlStateNormal];
        [_importVideoButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"importVideo.png"]] forState:UIControlStateSelected];
        [_importVideoButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"importVideo.png"]] forState:UIControlStateHighlighted];
    }
    return _importVideoButton;
}

- (UIButton *)videoSelectButton{
    if (_videoSelectButton == nil) {
        _videoSelectButton = [[UIButton alloc] init];
        [_videoSelectButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"rightMark.png"]] forState:UIControlStateNormal];
        [_videoSelectButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"rightMark.png"]] forState:UIControlStateSelected];
        [_videoSelectButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"rightMark.png"]] forState:UIControlStateHighlighted];
        _videoSelectButton.alpha = 0;
    }
    return _videoSelectButton;
}

- (RecordDeleteButton *)videoDeleteButton{
    if (_videoDeleteButton == nil) {
        _videoDeleteButton = [[RecordDeleteButton alloc] init];
        [_videoDeleteButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"btn_del_a.png"]] forState:UIControlStateNormal];
        [_videoDeleteButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"btn_del_a.png"]] forState:UIControlStateSelected];
        [_videoDeleteButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"btn_del_a.png"]] forState:UIControlStateHighlighted];
        _videoDeleteButton.alpha = 0;
    }
    return _videoDeleteButton;
}

- (UIButton *)takePhotoButton{
    if (_takePhotoButton == nil) {
        _takePhotoButton = [[UIButton alloc] init];
        [_takePhotoButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"takePhoto.png"]] forState:UIControlStateNormal];
        [_takePhotoButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"takePhoto.png"]] forState:UIControlStateSelected];
        [_takePhotoButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"takePhoto.png"]] forState:UIControlStateHighlighted];
    }
    return _takePhotoButton;
}

- (UIButton *)recordButton{
    if (_recordButton == nil) {
        _recordButton = [[UIButton alloc] init];
        [_recordButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"record.png"]] forState:UIControlStateNormal];
        [_recordButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"record.png"]] forState:UIControlStateSelected];
        [_recordButton setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"record.png"]] forState:UIControlStateHighlighted];
    }
    return _recordButton;
}

- (UIView *)recordContainer{
    if (_recordContainer == nil) {
        _recordContainer = [[UIView alloc] init];
        _recordContainer.alpha = 0;
    }
    return _recordContainer;
}

- (UILabel *)tipLabel{
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"按住录制";
        _tipLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (ProgressBar *)recordProgressView{
    if (_recordProgressView == nil) {
        _recordProgressView = [ProgressBar getInstance];
        [_recordProgressView startShining];
        _recordProgressView.alpha = 0;
    }
    return _recordProgressView;
}

- (UIView *)referenceView{
    if (_referenceView == nil) {
        _referenceView = [[UIView alloc] init];
    }
    return _referenceView;
}

#pragma mark    -
#pragma mark    方法
- (void)changeBetweenPhotographAndRecord:(UISwipeGestureRecognizer *)swipeGR{
    switch (swipeGR.direction) {
        case UISwipeGestureRecognizerDirectionRight:
        {
            if (self.PARChageView.currentArea == RecordArea) {
                [self settingCameraView:YES];
                [self.PARChageView outControlChangeCameraAreaAction:PhotographArea];
                if (self.switchAreaBlock != nil) {
                    self.switchAreaBlock(PhotographArea);
                }
            }
            break;
        }
        case UISwipeGestureRecognizerDirectionLeft:
        {
            if (self.PARChageView.currentArea == PhotographArea) {
                [self settingCameraView:NO];
                [self.PARChageView outControlChangeCameraAreaAction:RecordArea];
                if (self.switchAreaBlock != nil) {
                    self.switchAreaBlock(RecordArea);
                }
            }
            break;
        }
        case UISwipeGestureRecognizerDirectionUp:{
            break;
            
        }
        case UISwipeGestureRecognizerDirectionDown:{
            
            break;
        }
    }
}

#pragma mark    -
#pragma mark    主页显示
#pragma mark    隐藏录像按钮
- (void)hideRecordButton{
    [self.PARChageView hideRecordButton];
}

#pragma mark    隐藏照相按钮
- (void)hideCameraButton{
    [self.PARChageView hideCameraButton];
}

#pragma mark    只显示摄像
- (void)showOnlyRecordButtonAction{
    if (self.switchAreaBlock != nil) {
        self.switchAreaBlock(RecordArea);
    }
    self.recordArea.userInteractionEnabled    = NO;
    [self.downContainer removeGestureRecognizer:self.leftSwipeGR];
    [self.downContainer removeGestureRecognizer:self.rightSwipeGR];
    [self settingCameraView:NO];
    [self hideCameraButton];
}

#pragma mark    只显示照相
- (void)showOnlyCameraButtonAction{
    if (self.switchAreaBlock != nil) {
        self.switchAreaBlock(PhotographArea);
    }
    self.recordArea.userInteractionEnabled    = NO;
    [self.downContainer removeGestureRecognizer:self.leftSwipeGR];
    [self.downContainer removeGestureRecognizer:self.rightSwipeGR];
    [self settingCameraView:YES];
    [self hideRecordButton];
}

#pragma mark    是否设置成拍照区域
- (void)settingCameraView:(BOOL)isCamera{
    if (isCamera) {
        [UIView animateWithDuration:0.5 animations:^{
            self.recordProgressView.alpha  = 0;
            self.flashBTN.hidden           = NO;
            self.flashBTN.selected         = NO;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.recordProgressView.alpha  = 1;
            self.flashBTN.hidden           = YES;
        }];
    }
}
@end