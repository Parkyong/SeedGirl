//
//  Camera.h
//  RecordingTest
//
//  Created by ParkHunter on 15/8/13.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <OpenGLES/EAGL.h>
#import <UIKit/UIKit.h>
@class Camera;
@protocol CameraProtocol <NSObject>
//recorder开始录制一段视频时
- (void)videoRecorder:(Camera *)videoRecorder didStartRecordingToOutPutFileAtURL:(NSURL *)fileURL;

//recorder完成一段视频的录制时
- (void)videoRecorder:(Camera *)videoRecorder didFinishRecordingToOutPutFileAtURL:(NSURL *)outputFileURL
             duration:(CGFloat)videoDuration totalDur:(CGFloat)totalDur error:(NSError *)error;

//recorder正在录制的过程中
- (void)videoRecorder:(Camera *)videoRecorder didRecordingToOutPutFileAtURL:(NSURL *)outputFileURL
             duration:(CGFloat)videoDuration recordedVideosTotalDur:(CGFloat)totalDur;

//recorder删除了某一段视频
- (void)videoRecorder:(Camera *)videoRecorder didRemoveVideoFileAtURL:(NSURL *)fileURL
             totalDur:(CGFloat)totalDur error:(NSError *)error;

//recorder完成视频的合成
- (void)videoRecorder:(Camera *)videoRecorder didFinishMergingVideosToOutPutFileAtURL:(NSURL *)outputFileURL ;
@end

@interface Camera : NSObject <UINavigationControllerDelegate, UIImagePickerControllerDelegate,AVCaptureFileOutputRecordingDelegate>
@property (nonatomic, strong) AVCaptureSession              *captureSession;     //Session
@property (nonatomic, strong) AVCaptureDeviceInput      *captureDeviceInput;     //DeviceInput
@property (nonatomic, strong) AVCaptureDevice           *audioCaptureDevice;     //audioDevice
@property (nonatomic, strong) AVCaptureDeviceInput              *audioInput;     //audioDeviceInput
@property (nonatomic, strong) AVCaptureMovieFileOutput     *movieFileOutput;     //output
@property (nonatomic, strong) AVCaptureConnection        *captureConnection;     //connection
@property (nonatomic, assign) id <CameraProtocol>                  delegate;     //代理

//初始化
-(instancetype)initWithSession:(AVCaptureSession*)captureSession withCaptureDeviceInput:(AVCaptureDeviceInput *)captureDeviceInput;

//初始化Session
- (void)initializeCameraSession;

//析构Session
- (void)destoryCameraSession;

//开始录像
- (void)startRecording;

//停止录像
- (void)stopRecording;

//获取录制视频个数
- (NSInteger)getVideoCount;

//获取录制视频数组
- (NSArray *)getVideoArray;

//会调用delegate
- (void)deleteLastVideo;

//删除所有视频
- (void)deleteAllVideo;

//视频合成
- (void)mergeVideoFiles;
@end
