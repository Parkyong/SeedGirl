//
//  Photograph.m
//  RecordingTest
//
//  Created by ParkHunter on 15/8/13.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "Photograph.h"

@implementation Photograph

#pragma mark    初始化
-(instancetype)initWithSession:(AVCaptureSession*)captureSession withCaptureDeviceInput:(AVCaptureDeviceInput *)captureDeviceInput
{
    self = [self init];
    if (self) {
        self.captureSession     = captureSession;
        self.captureDeviceInput = captureDeviceInput;
    }
    return self;
}

#pragma mark    初始化
- (void)initializeCameraSession{
    [self addDeviceInputAndOutput];
}

#pragma mark    析构
- (void)destoryCameraSession{
    [self removeDeviceInputAndOutput];
}

#pragma mark    添加input和output设备
- (void)addDeviceInputAndOutput{
    [self addCaptureDeviceInput];
    [self addStillImageOutput];
}

#pragma mark    删除input和output设备
- (void)removeDeviceInputAndOutput{
    [self removeCaptureDeviceInput];
    [self removeStillImageOutput];
}

#pragma mark    添加输入设备
- (void)addCaptureDeviceInput
{
    if ([self.captureSession canAddInput:self.captureDeviceInput]){
        [self.captureSession addInput:self.captureDeviceInput];
    }
}

#pragma mark    删除输入设备
- (void)removeCaptureDeviceInput
{
    [self.captureSession removeInput:self.captureDeviceInput];
    self.captureDeviceInput = nil;
}

#pragma mark    添加输出设备
- (void)addStillImageOutput
{
    if (self.stillImageOutput == nil) {
        self.stillImageOutput   = [[AVCaptureStillImageOutput alloc] init];
        [self.stillImageOutput setOutputSettings:[[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil]];
        if ([self.captureSession canAddOutput:self.stillImageOutput]){
            [self.captureSession addOutput:self.stillImageOutput];
        }
    }
}

#pragma mark    删除输出设备
-(void)removeStillImageOutput{
    [self.captureSession removeOutput:self.stillImageOutput];
    self.stillImageOutput   = nil;
}

#pragma mark    照相功能
- (void)takePicktureAction{
    AVCaptureConnection * videoConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        return;
    }
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection  completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage * image = [UIImage imageWithData:imageData];
        
        if (self.takePicktureBlock != nil) {
            self.takePicktureBlock(image);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [assetsLibrary writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
                if (error) {
                    APPLog(@"%@", error);
                } else {
                    APPLog(@"%@", assetURL);
                }
            }];
        });
    }];
}

#pragma mark    打开闪光灯
- (void)turnFlashOn:(BOOL)on {
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}

- (void)takePicktureAfterBlockAction:(TAKEPICKTUREBLOCKTYPE)copyBlock{
    if (copyBlock != nil) {
        self.takePicktureBlock = nil;
        self.takePicktureBlock = [copyBlock copy];
    }
}
@end
