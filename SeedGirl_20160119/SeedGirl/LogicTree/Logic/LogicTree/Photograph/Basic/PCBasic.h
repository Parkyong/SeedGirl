//
//  PCBasic.h
//  RecordingTest
//
//  Created by ParkHunter on 15/8/13.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photograph.h"
#import "Camera.h"

typedef void(^RecordBlockType)(BOOL isRecording);

@interface PCBasic : NSObject
@property (nonatomic, strong) AVCaptureSession              *captureSession;     //Session
@property (nonatomic, strong) AVCaptureDeviceInput      *captureDeviceInput;     //DeviceInput
@property (nonatomic, strong) AVCaptureVideoPreviewLayer      *previewLayer;     //previewLayer
@property (nonatomic, assign) AreaType                           currenArea;     //当前试图
@property (nonatomic, copy)   RecordBlockType                   recordBlock;
@property (nonatomic, assign) id <CameraProtocol>                  delegate;    //代理
#pragma mark    Action
//设置Record区域
- (void)setRecordLayer:(UIView*)view;

//开始Session
- (void)sessionStartRunning;

//停止Session
- (void)sessionStopRunning;

//更换区域
- (void)switchBetweenCameraWithPhotographWithType:(AreaType)type;

//前置摄像头与后置摄像头切换
- (void)toggleCameraBTNAction;

//闪光灯开关
- (void)turnTorchOn:(BOOL)on;

//照相或者录像
- (void)recordButtonPressAction;

//获取录制视频个数
- (NSInteger)getVideoCount;

//获取录制视频数组
- (NSArray *)getVideoArray;

//删除最后一片视频
- (void)deleteLastVideo;

//删除所有视频
- (void)deleteAllVideo;

//视频合成
- (void)mergeVideoFiles;

//照相后调用Block
- (void)takePicktureAfterBlockAction:(TAKEPICKTUREBLOCKTYPE)copyBlock;
@end
