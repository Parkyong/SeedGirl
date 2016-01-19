//
//  Camera.m
//  RecordingTest
//
//  Created by ParkHunter on 15/8/13.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "Camera.h"
#import "CameraData.h"
#import "PathTool.h"

#define COUNT_DUR_TIMER_INTERVAL 0.05
@interface Camera ()    <AVCaptureVideoDataOutputSampleBufferDelegate>
@property (nonatomic, strong) NSTimer                           *countDurTimer;    //timer
@property (nonatomic, assign) CGFloat                          currentVideoDur;    //当前视频总长
@property (nonatomic, assign) NSURL                            *currentFileURL;    //当前视频路径
@property (nonatomic, assign) CGFloat                            totalVideoDur;    //视频播放总长
@property (nonatomic, strong) NSMutableArray               *videoFileDataArray;    //存储视频地址的数组
@property (nonatomic, strong) AVCaptureVideoDataOutput *captureVideoDataOutput;
@end

@implementation Camera
- (instancetype)initWithSession:(AVCaptureSession*)captureSession withCaptureDeviceInput:(AVCaptureDeviceInput *)captureDeviceInput
{
    self = [super init];
    if (self) {
        self.captureSession          = captureSession;
        self.captureDeviceInput      = captureDeviceInput;
        self.totalVideoDur           = 0.0f;
        self.videoFileDataArray      = [[NSMutableArray alloc] init];
        self.captureVideoDataOutput  = [[AVCaptureVideoDataOutput alloc]init];
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
    [self addAudioCaptureDevice];
    [self addVideoOutput];
    //    [self addAVCaptureVideoDataOutput];
    [self connectCameraConnect];
    [self setVideoQuality];
}

#pragma mark    删除input和output设备
- (void)removeDeviceInputAndOutput{
    [self removeCaptureDeviceInput];
    [self removeAudioCaptureDevice];
    [self removeVideoOutput];
    //    [self removeAVCaptureVideoDataOutput];
    [self disconnectCameraConnect];
}

#pragma mark    添加输入端
- (void)addCaptureDeviceInput{
    if ([self.captureSession canAddInput:self.captureDeviceInput]){
        [self.captureSession addInput:self.captureDeviceInput];
    }
}

#pragma mark    删除输入端
- (void)removeCaptureDeviceInput{
    [self.captureSession removeInput:self.captureDeviceInput];
    self.captureDeviceInput = nil;
}

#pragma mark    添加语音
-(void)addAudioCaptureDevice{
    self.audioCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    NSError *error  = nil;
    self.audioInput = [AVCaptureDeviceInput deviceInputWithDevice:self.audioCaptureDevice error:&error];
    
    if (self.audioInput != nil && error == nil){
        [self.captureSession addInput:self.audioInput];
    }
}

#pragma mark    删除语音
-(void)removeAudioCaptureDevice{
    [self.captureSession removeInput:self.audioInput];
    self.audioInput         = nil;
}

#pragma mark    添加视频输出
- (void)addVideoOutput{
    self.movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    Float64 TotalSeconds       = 60;			//Total seconds
    int32_t preferredTimeScale = 30;            //Frames per second
    CMTime maxDuration = CMTimeMakeWithSeconds(TotalSeconds, preferredTimeScale);
    //<<SET MAX DURATION
    self.movieFileOutput.maxRecordedDuration = maxDuration;
    
    self.movieFileOutput.minFreeDiskSpaceLimit = 1024 * 1024;
    //<<SET MIN FREE SPACE IN BYTES FOR RECORDING TO CONTINUE ON A VOLUME
    
    if ([self.captureSession canAddOutput:self.movieFileOutput])
        [self.captureSession addOutput:self.movieFileOutput];
}

#pragma mark    删除视频输出
- (void)removeVideoOutput{
    [self.captureSession removeOutput:self.movieFileOutput];
    self.movieFileOutput    = nil;
}


#pragma mark    添加视频输出流
- (void)addAVCaptureVideoDataOutput{
    if([self.captureSession canAddOutput:self.captureVideoDataOutput]){
        [self.captureSession addOutput:self.captureVideoDataOutput];
        dispatch_queue_t videoCaptureQueue = dispatch_queue_create("video_capture_queue_",DISPATCH_QUEUE_SERIAL);
        [self.captureVideoDataOutput setSampleBufferDelegate:self queue:videoCaptureQueue];
    }
}

#pragma mark    删除视频输出流
- (void)removeAVCaptureVideoDataOutput{
    [self.captureSession removeOutput:self.captureVideoDataOutput];
    self.captureVideoDataOutput = nil;
}

#pragma mark    设置连接
- (void)connectCameraConnect{
    //SET THE CONNECTION PROPERTIES (output properties)
    self.captureConnection = [self.movieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    //Set landscape (if required)
    if ([self.captureConnection isVideoOrientationSupported]){
        AVCaptureVideoOrientation orientation = AVCaptureVideoOrientationPortrait;
        //<<<<<SET VIDEO ORIENTATION IF LANDSCAPE
        [self.captureConnection setVideoOrientation:orientation];
    }
}

#pragma mark    断开连接
- (void)disconnectCameraConnect{
    self.captureConnection  = nil;
}

- (void)setVideoQuality{
    [self.captureSession setSessionPreset:AVCaptureSessionPresetMedium];
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPreset640x480])		//Check size based configs are supported before setting them
        [self.captureSession setSessionPreset:AVCaptureSessionPreset640x480];
}

#pragma mark    - 功能
#pragma mark    开始录像
- (void)startRecording{
    //----- START RECORDING -----
    NSLog(@"START RECORDING");
    //Create temporary URL to record to
    NSString *outputPath = [[NSString alloc] initWithFormat:@"%@%@", NSTemporaryDirectory(), @"output.mp4"];
    NSLog(@"%@", outputPath);
    NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:outputPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:outputPath])
    {
        NSError *error;
        if ([fileManager removeItemAtPath:outputPath error:&error] == NO)
        {
            //Error - handle if requried
        }
    }
    
    //Start recording
    [self.movieFileOutput startRecordingToOutputFileURL:outputURL recordingDelegate:self];
    outputURL = nil;
}

#pragma mark    停止录像
- (void)stopRecording{
    //----- STOP RECORDING -----
    NSLog(@"STOP RECORDING");
    //setUI
    [self.movieFileOutput stopRecording];
    [self stopCountDurTimer];
}

#pragma mark    代理方法
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput
didStartRecordingToOutputFileAtURL:(NSURL *)fileURL
      fromConnections:(NSArray *)connections{
    self.currentFileURL  = fileURL;
    self.currentVideoDur = 0.0f;
    
    [self startCountDurTimer];
    if ([self.delegate respondsToSelector:@selector(videoRecorder:didStartRecordingToOutPutFileAtURL:)]) {
        [self.delegate videoRecorder:self didStartRecordingToOutPutFileAtURL:fileURL];
    }
}

//********** DID FINISH RECORDING TO OUTPUT FILE AT URL **********
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput
didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL
      fromConnections:(NSArray *)connections
                error:(NSError *)error{
    NSLog(@"didFinishRecordingToOutputFileAtURL - enter");
    
    BOOL RecordedSuccessfully = YES;
    if ([error code] != noErr){
        // A problem occurred: Find out if the recording was successful.
        id value = [[error userInfo] objectForKey:AVErrorRecordingSuccessfullyFinishedKey];
        if (value){
            RecordedSuccessfully = [value boolValue];
        }
    }
    if (RecordedSuccessfully){
        //----- RECORDED SUCESSFULLY -----
        NSLog(@"didFinishRecordingToOutputFileAtURL - success");
        self.totalVideoDur += _currentVideoDur;
        APPLog(@"本段视频长度: %f", _currentVideoDur);
        APPLog(@"现在的视频总长度: %f", _totalVideoDur);
        CameraData *data = [[CameraData alloc] init];
        data.duration    = self.currentVideoDur;
        data.fileURL     = outputFileURL;
        [self.videoFileDataArray addObject:data];
        
        if ([self.delegate respondsToSelector:@selector(videoRecorder:didFinishRecordingToOutPutFileAtURL:duration:totalDur:error:)]){
            [self.delegate  videoRecorder:self didFinishRecordingToOutPutFileAtURL:outputFileURL duration:self.currentVideoDur totalDur:self.totalVideoDur error:error];
        }
    }
}

#pragma mark    视频buffer输出端
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection{
    //    OSStatus err = CMBufferQueueEnqueue(previewBufferQueue, sampleBuffer);
    NSLog(@"%@", sampleBuffer);
}

#pragma mark    删除最后一个视频
- (void)deleteLastVideo{
    if ([_videoFileDataArray count] == 0) {
        return;
    }
    
    CameraData *data = (CameraData *)[self.videoFileDataArray lastObject];
    NSURL *videoFileURL   = data.fileURL;
    CGFloat videoDuration = data.duration;
    
    [self.videoFileDataArray removeLastObject];
    self.totalVideoDur -= videoDuration;
    
    //delete
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *filePath = [[videoFileURL absoluteString] stringByReplacingOccurrencesOfString:@"file://" withString:@""];

        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:filePath]) {
            NSError *error = nil;
            [fileManager removeItemAtPath:filePath error:&error];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //delegate
                if ([self.delegate respondsToSelector:@selector(videoRecorder:didRemoveVideoFileAtURL:totalDur:error:)]) {
                    [self.delegate videoRecorder:self didRemoveVideoFileAtURL:videoFileURL totalDur:self.totalVideoDur error:error];
                }
            });
        }
    });
}

#pragma mark    删除所有视频
- (void)deleteAllVideo{
    for (CameraData *data in _videoFileDataArray) {
        NSURL *videoFileURL = data.fileURL;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *filePath = [[videoFileURL absoluteString] stringByReplacingOccurrencesOfString:@"file://" withString:@""];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:filePath]) {
                NSError *error = nil;
                [fileManager removeItemAtPath:filePath error:&error];
                if (error) {
                    NSLog(@"deleteAllVideo删除视频文件出错:%@", error);
                }
            }
        });
    }
}

#pragma mark    视频合成
- (void)mergeVideoFiles{
    NSMutableArray *fileURLArray = [[NSMutableArray alloc] init];
    for (CameraData *data in _videoFileDataArray) {
        [fileURLArray addObject:data.fileURL];
    }
    [self mergeAndExportVideosAtFileURLs:fileURLArray];
}

#pragma mark    视频合成
- (void)mergeAndExportVideosAtFileURLs:(NSArray *)fileURLArray{
    NSError *error                        = nil;
    CGSize renderSize                     = CGSizeMake(0, 0);
    NSMutableArray *layerInstructionArray = [[NSMutableArray alloc] init];
    AVMutableComposition *mixComposition  = [[AVMutableComposition alloc] init];
    CMTime totalDuration                  = kCMTimeZero;
    
    //先去assetTrack 也为了取renderSize
    NSMutableArray *assetTrackArray = [[NSMutableArray alloc] init];
    NSMutableArray *assetArray      = [[NSMutableArray alloc] init];
    for (NSURL *fileURL in fileURLArray) {
        AVAsset *asset = [AVAsset assetWithURL:fileURL];
        if (!asset) {
            continue;
        }
        
        [assetArray addObject:asset];
        
        AVAssetTrack *assetTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
        [assetTrackArray addObject:assetTrack];
        
        renderSize.width  = MAX(renderSize.width, assetTrack.naturalSize.height);
        renderSize.height = MAX(renderSize.height, assetTrack.naturalSize.width);
    }
    
    CGFloat renderW = MIN(renderSize.width, renderSize.height);
    
    for (int i = 0; i < [assetArray count] && i < [assetTrackArray count]; i++) {
        AVAsset *asset           = [assetArray objectAtIndex:i];
        AVAssetTrack *assetTrack = [assetTrackArray objectAtIndex:i];
        //添加声音
        AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                            preferredTrackID:kCMPersistentTrackID_Invalid];
        [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                            ofTrack:[[asset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0]
                             atTime:totalDuration
                              error:nil];
        
        //添加视频
        AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
        
        //添加音乐入手
        [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                            ofTrack:assetTrack
                             atTime:totalDuration
                              error:&error];
        
        //fix orientationissue
        AVMutableVideoCompositionLayerInstruction *layerInstruciton = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
        
        totalDuration = CMTimeAdd(totalDuration, asset.duration);
        
        CGFloat rate;
        rate = renderW / MIN(assetTrack.naturalSize.width, assetTrack.naturalSize.height);
        
        CGAffineTransform layerTransform = CGAffineTransformMake(assetTrack.preferredTransform.a,
                                                                 assetTrack.preferredTransform.b,
                                                                 assetTrack.preferredTransform.c,
                                                                 assetTrack.preferredTransform.d,
                                                                 assetTrack.preferredTransform.tx * rate,
                                                                 assetTrack.preferredTransform.ty * rate);
        
        CGAffineTransform  offsetTransform = CGAffineTransformMake(1,
                                                                   0,
                                                                   0,
                                                                   1,
                                                                   0,
                                                                   -(assetTrack.naturalSize.width - assetTrack.naturalSize.height) / 2.0);
//        CGAffineTransform  offsetTransform = CGAffineTransformMake(1,
//                                                                   0,
//                                                                   0,
//                                                                   1,
//                                                                   0,
//                                                                   0);
        //向上移动取中部影响
        layerTransform = CGAffineTransformConcat(layerTransform,
                                                 offsetTransform);
        //放缩，解决前后摄像结果大小不对称
        layerTransform = CGAffineTransformScale(layerTransform, rate, rate);
        
        [layerInstruciton setTransform:layerTransform atTime:kCMTimeZero];
        [layerInstruciton setOpacity:0.0 atTime:totalDuration];
        
        //data
        [layerInstructionArray addObject:layerInstruciton];
    }
    
    //get save path
    NSString *filePath = [PathTool documentFolder];
    unlink([filePath UTF8String]);
    NSURL *mergeFileURL = [NSURL fileURLWithPath:filePath];
    
    //export
    //生成指令
    AVMutableVideoCompositionInstruction *mainInstruciton = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruciton.timeRange         = CMTimeRangeMake(kCMTimeZero, totalDuration);    //设置总播放时间
    mainInstruciton.layerInstructions = layerInstructionArray;                          //矩阵
    
    //设置输出端
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    mainCompositionInst.instructions  = @[mainInstruciton];                 //设置指令
    mainCompositionInst.frameDuration = CMTimeMake(1, 30);                  //设置帧

    
    mainCompositionInst.renderSize    = CGSizeMake(renderW, renderW);;//CGSizeMake(ScreenWidth, [Adaptor returnAdaptorValue:346.5]);       //设置播放区域
    NSLog(@"%f", renderSize.height);
    NSLog(@"%f", renderSize.width);
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                      presetName:AVAssetExportPresetMediumQuality];
    exporter.videoComposition            = mainCompositionInst;
    exporter.outputURL                   = mergeFileURL;
    exporter.outputFileType              = AVFileTypeMPEG4;
    exporter.shouldOptimizeForNetworkUse = YES;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        AVAssetExportSessionStatus status = exporter.status;
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case AVAssetExportSessionStatusFailed:{
                    NSLog(@"exporting failed %@",[exporter error]);
                    break;
                }
                case AVAssetExportSessionStatusCompleted:{
                    NSLog(@"exporting completed");
                    if ([self.delegate respondsToSelector:@selector(videoRecorder:didFinishMergingVideosToOutPutFileAtURL:)]) {
                        [self.delegate videoRecorder:self didFinishMergingVideosToOutPutFileAtURL:mergeFileURL];
                    }
                    break;
                }
                case AVAssetExportSessionStatusCancelled:{
                    NSLog(@"export cancelled");
                    break;
                }
                default:{
                    NSLog(@"default");
                }
            }
        });
    }];
}

#pragma mark    方法
#pragma mark    开启定时器
- (void)startCountDurTimer{
    self.countDurTimer = [NSTimer scheduledTimerWithTimeInterval:COUNT_DUR_TIMER_INTERVAL target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}

#pragma mark    关闭定时器
- (void)stopCountDurTimer{
    [self.countDurTimer invalidate];
    self.countDurTimer = nil;
}

#pragma mark    定时器调用函数
- (void)onTimer:(NSTimer *)timer{
    self.currentVideoDur += COUNT_DUR_TIMER_INTERVAL;
    
    if ([self.delegate respondsToSelector:@selector(videoRecorder:didRecordingToOutPutFileAtURL:duration:recordedVideosTotalDur:)]) {
        [self.delegate videoRecorder:self didRecordingToOutPutFileAtURL:self.currentFileURL duration:self.currentVideoDur recordedVideosTotalDur:self.totalVideoDur];
    }
    
    if (self.totalVideoDur + self.currentVideoDur >= MAX_VIDEO_DUR) {
        [self stopCountDurTimer];
        [self stopRecording];
    }
}

#pragma mark    获取参数方法
#pragma mark    获取录制视频个数
- (NSInteger)getVideoCount{
    return  self.videoFileDataArray.count;
}

#pragma mark   获取录制视频数组
- (NSArray *)getVideoArray{
    return self.videoFileDataArray;
}
@end