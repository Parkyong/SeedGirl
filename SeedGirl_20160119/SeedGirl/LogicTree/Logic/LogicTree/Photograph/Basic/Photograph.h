//
//  Photograph.h
//  RecordingTest
//
//  Created by ParkHunter on 15/8/13.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>
typedef void (^TAKEPICKTUREBLOCKTYPE)(UIImage *image);
@interface Photograph : NSObject
@property (nonatomic, strong) AVCaptureSession              *captureSession;     //Session
@property (nonatomic, strong) AVCaptureDeviceInput      *captureDeviceInput;     //DeviceInput
@property (nonatomic, strong) AVCaptureStillImageOutput   *stillImageOutput;     //DeviceOutput
@property (nonatomic, copy)   TAKEPICKTUREBLOCKTYPE       takePicktureBlock;
//初始化photo类
-(instancetype)initWithSession:(AVCaptureSession*)captureSession withCaptureDeviceInput:(AVCaptureDeviceInput *)captureDeviceInput;

//初始化Session
- (void)initializeCameraSession;

//析构Session
- (void)destoryCameraSession;

//控制闪光灯
- (void)turnFlashOn:(BOOL)on;

//照相功能
- (void)takePicktureAction;

//照相完后调用Block
- (void)takePicktureAfterBlockAction:(TAKEPICKTUREBLOCKTYPE)copyBlock;
@end
