//
//  PCBasic.m
//  RecordingTest
//
//  Created by ParkHunter on 15/8/13.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "PCBasic.h"

@interface PCBasic ()
@property (nonatomic, strong) Camera                          *cameraObject;     //摄像类
@property (nonatomic, strong) Photograph                  *photographObject;     //图片类
@property (nonatomic, assign) BOOL                              isRecording;     //是否正在拍摄
@end

@implementation PCBasic
- (instancetype)init{
    self = [super init];
    if (self) {
        self.captureSession     = [[AVCaptureSession alloc] init];
        self.captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:nil];
        self.currenArea         = PhotographArea;
        self.isRecording        = NO;
        [self switchBetweenCameraWithPhotographWithType:PhotographArea];
    }
    return self;
}

#pragma mark    更换区域
- (void)switchBetweenCameraWithPhotographWithType:(AreaType)type{
    if (type == RecordArea) {
        [self sessionStopRunning];
        if (self.photographObject != nil) {
            [self.photographObject destoryCameraSession];
            self.photographObject = nil;
        }
        if (self.cameraObject != nil) {
            [self sessionStartRunning];
            return;
        }

        self.cameraObject = [[Camera alloc] initWithSession:self.captureSession
                                     withCaptureDeviceInput:self.captureDeviceInput];
        [self.cameraObject initializeCameraSession];
        self.currenArea     = RecordArea;
        self.isRecording    = NO;
        self.cameraObject.delegate = self.delegate;
        [self sessionStartRunning];
    }else{
        [self sessionStopRunning];
        if (self.cameraObject != nil) {
            [self.cameraObject destoryCameraSession];
            self.cameraObject = nil;
        }
        if (self.photographObject != nil) {
            [self sessionStartRunning];
            return;
        }
        self.photographObject = [[Photograph alloc] initWithSession:self.captureSession
                                             withCaptureDeviceInput:self.captureDeviceInput];
        [self.photographObject initializeCameraSession];
        self.currenArea     = PhotographArea;
        self.isRecording    = NO;
        [self sessionStartRunning];
    }
}

#pragma mark    开始Session
- (void)sessionStartRunning{
    if (self.captureSession) {
        [self.captureSession startRunning];
    }
}

#pragma mark    停止Session
- (void)sessionStopRunning{
    if (self.captureSession) {
        [self.captureSession stopRunning];
    }
}

#pragma mark    设置Record区域
- (void)setRecordLayer:(UIView*)view{
    if (self.previewLayer == nil) {
        self.previewLayer  = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
        CALayer *viewLayer = [view layer];
        [viewLayer setMasksToBounds:YES];
        CGRect bounds = [view bounds];
        [self.previewLayer setFrame:bounds];
        [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        [viewLayer insertSublayer:self.previewLayer below:[[viewLayer sublayers] objectAtIndex:0]];
    }
}

#pragma mark    照相或则摄像
- (void)recordButtonPressAction{
    if (self.currenArea == PhotographArea) {
        [self.photographObject takePicktureAction];
    }else{
        if (!self.isRecording) {
            [self.cameraObject startRecording];
            self.isRecording = YES;
        }else{
            [self.cameraObject stopRecording];
            self.isRecording = NO;
        }
        if (self.recordBlock != nil) {
            self.recordBlock(self.isRecording);
        }
    }
}

//照相后调用Block
- (void)takePicktureAfterBlockAction:(TAKEPICKTUREBLOCKTYPE)copyBlock{
    if (copyBlock != nil) {
        [self.photographObject takePicktureAfterBlockAction:copyBlock];
    }
}

#pragma mark    打开闪光灯
- (void)turnTorchOn:(BOOL)on{
    [self.photographObject turnFlashOn:on];
}

#pragma mark    前置摄像头与后置摄像头切换
- (void)toggleCameraBTNAction{
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        NSError *error;
        AVCaptureDeviceInput *newVideoInput;
        AVCaptureDevicePosition position = [[self.captureDeviceInput device] position];
        
        if (position == AVCaptureDevicePositionBack)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:&error];
        else if (position == AVCaptureDevicePositionFront)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:&error];
        else
            return;
        if (newVideoInput != nil) {
            [self.captureSession beginConfiguration];
            [self.captureSession removeInput:self.captureDeviceInput];
            if ([self.captureSession canAddInput:newVideoInput]) {
                [self.captureSession addInput:newVideoInput];
                [self setCaptureDeviceInput:newVideoInput];
            } else {
                [self.captureSession addInput:self.captureDeviceInput];
            }
            [self.captureSession commitConfiguration];
        } else if (error) {
            NSLog(@"toggle carema failed, error = %@", error);
        }
    }
}

#pragma mark    获取前置摄像头
- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

#pragma mark    获取后置摄像头
- (AVCaptureDevice *)backCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

#pragma mark   - 获取摄像头
#pragma mark    获取前置摄像头与后置摄像头
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            if ([device lockForConfiguration:nil]) {
                device.activeVideoMinFrameDuration = CMTimeMake(1, 10);
                device.activeVideoMaxFrameDuration = CMTimeMake(1, 30);
                [device unlockForConfiguration];
            }
            return device;
        }
    }
    return nil;
}

#pragma mark    获取参数方法
#pragma mark    获取录制视频个数
- (NSInteger)getVideoCount{
    return [self.cameraObject getVideoCount];
}

- (NSArray *)getVideoArray{
    return [self.cameraObject getVideoArray];
}

- (void)deleteLastVideo{
    [self.cameraObject deleteLastVideo];
}

- (void)mergeVideoFiles{
    [self.cameraObject mergeVideoFiles];
}

- (void)deleteAllVideo{
    [self.cameraObject deleteAllVideo];
}
@end