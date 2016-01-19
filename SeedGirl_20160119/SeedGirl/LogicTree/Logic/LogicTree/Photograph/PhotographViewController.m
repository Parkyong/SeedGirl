//
//  PhotographViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/17.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "PhotographViewController.h"
#import "UINavigationBar+BackgroundColor.h"
#import "PhotographView.h"
#import "PCBasic.h"
#import "AlbumViewController.h"
#import "EditViewController.h"
#import "SkimVideoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "TellStoryViewController.h"
#import "IndividualViewController.h"
@class TellStoryViewController;
@interface PhotographViewController ()<CameraProtocol,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) PhotographView             *rootView;
@property (nonatomic, strong) PCBasic               *pcBasicObject;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
//功能参数
@property (nonatomic, assign) BOOL           isFlashLampOn;  //闪光灯
@end

@implementation PhotographViewController
- (void)loadView{
    self.rootView = [[PhotographView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view     = self.rootView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rootView.takePhotoButton.enabled          = YES;
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
    [self addFunction];
    [self setBlockFunction];
    [self setParameters];
}

#pragma mark    设置功能
- (void)addFunction{
    [self.rootView.toggleCameraBTN addTarget:self action:@selector(toggleCameraBTNAction)
                            forControlEvents:UIControlEventTouchUpInside];
    [self.rootView.flashBTN addTarget:self action:@selector(flashButtonAction:)
                     forControlEvents:UIControlEventTouchUpInside];
    [self.rootView.takePhotoButton addTarget:self action:@selector(shutterCamera)
                            forControlEvents:UIControlEventTouchUpInside];
    [self.rootView.recordButton addTarget:self action:@selector(shutterCamera)
                         forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchDown];
    [self.rootView.importPhotoButton addTarget:self action:@selector(selectAlbumLibAction)
                              forControlEvents:UIControlEventTouchUpInside];
    [self.rootView.importVideoButton addTarget:self action:@selector(selectVideoLibAction)
                              forControlEvents:UIControlEventTouchUpInside];
    [self.rootView.videoSelectButton addTarget:self action:@selector(videoSelectButtonAction:)
                              forControlEvents:UIControlEventTouchUpInside];
    [self.rootView.videoDeleteButton addTarget:self action:@selector(videoDeleteButtonAction:)
                              forControlEvents:UIControlEventTouchUpInside];
    [self.rootView.viewDismissBTN addTarget:self action:@selector(viewDismissAction:)
                           forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark    切换照相与摄像
- (void)setBlockFunction{
    WeakSelf;
    if ([self viewType] == CAMERAANDRECORDVIEW){
        self.rootView.switchAreaBlock =^(AreaType areaType){
            if (areaType == PhotographArea) {
                if ([self.pcBasicObject getVideoCount] > 0) {
                    [weakSelf deleteAllVideo];
                }
                weakSelf.isFlashLampOn = NO;
                [weakSelf.pcBasicObject switchBetweenCameraWithPhotographWithType:PhotographArea];
            }
            if (areaType == RecordArea) {
                [weakSelf.pcBasicObject switchBetweenCameraWithPhotographWithType:RecordArea];
            }
        };
    }
    
    self.pcBasicObject.recordBlock=^(BOOL isRecording){
        if (isRecording) {
            weakSelf.rootView.videoSelectButton.alpha = 1;
            weakSelf.rootView.videoDeleteButton.alpha = 1;
            weakSelf.rootView.importVideoButton.alpha = 0;
        }
    };
    
    [self.pcBasicObject takePicktureAfterBlockAction:^(UIImage *image) {
        EditViewController *editVC = [[EditViewController alloc] init];
        editVC.isChangeHeadImage   = weakSelf.isChangeHeadImage;
        editVC.showImage           = image;
        [weakSelf.navigationController pushViewController:editVC animated:YES];
    }];
}

#pragma mark    初始化设置
- (void)initialize{
    [self.pcBasicObject setRecordLayer:self.rootView.recordArea];
}

#pragma mark    设置参数
- (void)setParameters{
    switch (self.viewType) {
        case CAMERAVIEW:
        {
            [self.rootView showOnlyCameraButtonAction];
            break;
        }
        case RECORDVIEW:{
            [self.rootView showOnlyRecordButtonAction];
            [self.pcBasicObject switchBetweenCameraWithPhotographWithType:RecordArea];
            break;
        }
        case  CAMERAANDRECORDVIEW:{
            break;
        }
        default:
            break;
    }
}

#pragma mark    闪光灯
- (void)flashButtonAction:(UIButton *)sender{
    self.isFlashLampOn = !self.isFlashLampOn;
    self.rootView.flashBTN.selected = !self.rootView.flashBTN.isSelected;
    [self.pcBasicObject turnTorchOn:self.isFlashLampOn];
}

#pragma mark    调整摄像头
- (void)toggleCameraBTNAction{
    self.rootView.toggleCameraBTN.selected = !self.rootView.toggleCameraBTN.isSelected;
    [self.pcBasicObject toggleCameraBTNAction];
}

#pragma mark    摄像功能
- (void)shutterCamera{
    UIViewController *controller = [[self.navigationController viewControllers] firstObject];
    if ([controller isKindOfClass:[TellStoryViewController class]]) {
        TellStoryViewController *tellStoryVC = (TellStoryViewController *)controller;
        if (tellStoryVC.collectionDataContainer.count > 1) {
            [self showAlertActionWithFlag:NO];
        }else{
            [self.pcBasicObject recordButtonPressAction];
        }
    }else{
        [self.pcBasicObject recordButtonPressAction];
    }
}

#pragma mark    调用相册
- (void)selectAlbumLibAction{
    UIViewController *controller = [[self.navigationController viewControllers] firstObject];
    if ([controller isKindOfClass:[TellStoryViewController class]]) {
        TellStoryViewController *tellStoryVC = (TellStoryViewController *)controller;
        if (/*[self.pcBasicObject getVideoCount] > 0 &&*/ tellStoryVC.collectionDataContainer.count > 1) {
            [self showAlertActionWithFlag:YES];
        }else{
            AlbumViewController *albumVC = [[AlbumViewController alloc] init];
            albumVC.isChangeHeadImage       = self.isChangeHeadImage;
            albumVC.isRequireMultibleButton = !self.isChangeHeadImage;
            albumVC.isPushStyle             = YES;
            [self.navigationController pushViewController:albumVC animated:YES];
        }
    }else{
        AlbumViewController *albumVC = [[AlbumViewController alloc] init];
        albumVC.isChangeHeadImage       = self.isChangeHeadImage;
        albumVC.isRequireMultibleButton = !self.isChangeHeadImage;
        albumVC.isPushStyle             = YES;
        [self.navigationController pushViewController:albumVC animated:YES];
    }
}

#pragma mark    选择视频库
- (void)selectVideoLibAction{
    UIViewController *controller = [[self.navigationController viewControllers] firstObject];
    TellStoryViewController *tellStoryVC = (TellStoryViewController *)controller;
    if (/*[self.pcBasicObject getVideoCount] > 0 &&*/ tellStoryVC.collectionDataContainer.count > 1) {
        [self showAlertActionWithFlag:YES];
    }else{
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
        [self presentViewController:self.imagePicker animated:YES completion:NULL];
    }
}

#pragma mark    懒加载对象
- (PCBasic *)pcBasicObject{
    if (_pcBasicObject == nil) {
        _pcBasicObject = [[PCBasic alloc] init];
        _pcBasicObject.delegate = self;
    }
    return _pcBasicObject;
}

#pragma mark    功能
#pragma mark    删除视频
- (void)videoDeleteButtonAction:(UIButton*)sender{
    if (self.rootView.videoDeleteButton.type == DeleteButtonStyleNormal) {//第一次按下删除按钮
        [self.rootView.recordProgressView setLastProgressToStyle:ProgressBarProgressStyleDelete];
        [self.rootView.videoDeleteButton setType:DeleteButtonStyleDelete];
    } else if (self.rootView.videoDeleteButton.type == DeleteButtonStyleDelete) {//第二次按下删除按钮
        [self deleteLastVideo];
        [self.rootView.recordProgressView deleteLastProgress];
        if ([self.pcBasicObject getVideoCount] > 0) {
            [self.rootView.videoDeleteButton setType:DeleteButtonStyleNormal];
        }else{
            [self.rootView.videoDeleteButton setType:DeleteButtonStyleDisable];
        }
    }
    if (self.pcBasicObject.getVideoCount == 0) {
        self.rootView.videoSelectButton.alpha = 0;
        self.rootView.videoDeleteButton.alpha = 0;
        self.rootView.importVideoButton.alpha = 1;
    }
}

//删除最后一段视频
- (void)deleteLastVideo{
    if ([self.pcBasicObject getVideoCount] > 0) {
        [self.pcBasicObject deleteLastVideo];
    }
}

//删除所有视频
- (void)deleteAllVideo{
    if ([self.pcBasicObject getVideoCount] > 0) {
        [self.rootView.recordProgressView deleteLastProgress];
        [self.pcBasicObject deleteAllVideo];
        self.rootView.videoSelectButton.alpha = 0;
        self.rootView.videoDeleteButton.alpha = 0;
        self.rootView.importVideoButton.alpha = 1;
    }
}

#pragma mark    选择视频
- (void)videoSelectButtonAction:(UIButton *)sender{
    UIViewController *controller = [[self.navigationController viewControllers] firstObject];
    if ([controller isKindOfClass:[TellStoryViewController class]]) {
        TellStoryViewController *tellStoryVC = (TellStoryViewController *)controller;
        if (/*[self.pcBasicObject getVideoCount] > 0 && */tellStoryVC.collectionDataContainer.count > 1) {
            [self showAlertActionWithFlag:NO];
        }else{
            [self.pcBasicObject mergeVideoFiles];
        }
    }
    if ([controller isKindOfClass:[IndividualViewController class]]) {
        [self.pcBasicObject mergeVideoFiles];
    }
}

#pragma mark    展示Actionsheet
- (void)showAlertActionWithFlag:(BOOL)isVideoLib{
    WeakSelf;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"放弃之前选择上传的照片" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"放弃"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                            [weakSelf alertCommonActionIndex:1 withFlag:isVideoLib];
                                                        }];
    [alertController addAction:albumAction];
    [alertController.view setTintColor:RGB(51, 51, 51)];
    [self presentViewController:alertController animated:YES completion:nil];
    
#else
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"放弃之前选择上传的照片" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"放弃", nil];
    if (isVideoLib) {
        alertView.tag = 1;
    }else{
        alertView.tag = 2;
    }
    [alertView showInView:self.view];
#endif
}

#pragma mark    代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        [self alertCommonActionIndex:buttonIndex withFlag:NO];
    }else{
        [self alertCommonActionIndex:buttonIndex withFlag:YES];
    }
}

#pragma mark    选择alertView
- (void)alertCommonActionIndex:(NSInteger)index withFlag:(BOOL)isVideoLib{
        if (index == 0) {
            return;
        }else{
            UIViewController *controller = [[self.navigationController viewControllers] firstObject];
            if ([controller isKindOfClass:[TellStoryViewController class]]) {
                [(TellStoryViewController *)controller clearContainer];
                if (self.pcBasicObject.currenArea == PhotographArea) {
                    if (isVideoLib) {
                        AlbumViewController *albumVC = [[AlbumViewController alloc] init];
                        albumVC.isChangeHeadImage       = self.isChangeHeadImage;
                        albumVC.isRequireMultibleButton = !self.isChangeHeadImage;
                        albumVC.isPushStyle             = YES;
                        [self.navigationController pushViewController:albumVC animated:YES];
                    }else{
                        [self.pcBasicObject recordButtonPressAction];
                    }
                }else{
                    if (isVideoLib) {
                        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                        self.imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
                        [self presentViewController:self.imagePicker animated:YES completion:NULL];
                    }
                }
            }
        }
}

#pragma mark   － 代理方法
#pragma mark     开始录制
- (void)videoRecorder:(Camera *)videoRecorder didStartRecordingToOutPutFileAtURL:(NSURL *)fileURL{
    APPLog(@"正在录制视频: %@", fileURL);
    

    [self.rootView.recordProgressView addProgressView];
    [self.rootView.recordProgressView stopShining];
    [self.rootView.videoDeleteButton setType:DeleteButtonStyleNormal];
}

#pragma mark    正在录制
- (void)videoRecorder:(Camera *)videoRecorder didRecordingToOutPutFileAtURL:(NSURL *)outputFileURL duration:(CGFloat)videoDuration recordedVideosTotalDur:(CGFloat)totalDur{
    [self.rootView.recordProgressView setLastProgressToWidth:videoDuration / MAX_VIDEO_DUR * self.rootView.recordProgressView.frame.size.width];
    //必须超过视频限定长度
    //    _okButton.enabled = (videoDuration + totalDur >= MIN_VIDEO_DUR);
}

#pragma mark    录制完毕
- (void)videoRecorder:(Camera *)videoRecorder didFinishRecordingToOutPutFileAtURL:(NSURL *)outputFileURL duration:(CGFloat)videoDuration totalDur:(CGFloat)totalDur error:(NSError *)error{
    if (error) {
        APPLog(@"录制视频错误:%@", error);
    } else {
        APPLog(@"录制视频完成: %@", outputFileURL);
    }
    
    [self.rootView.recordProgressView startShining];
    //    if (totalDur >= MAX_VIDEO_DUR) {
    //        [self pressOKButton];
    //    }
}

#pragma mark    删除录制视频
- (void)videoRecorder:(Camera *)videoRecorder didRemoveVideoFileAtURL:(NSURL *)fileURL totalDur:(CGFloat)totalDur error:(NSError *)error{
    if (error) {
        APPLog(@"删除视频错误: %@", error);
    } else {
        APPLog(@"删除了视频: %@", fileURL);
        APPLog(@"现在视频长度: %f", totalDur);
    }
    
    if ([self.pcBasicObject getVideoCount] > 0) {
        [self.rootView.videoDeleteButton setType:DeleteButtonStyleNormal];
    } else {
        [self.rootView.videoDeleteButton setType:DeleteButtonStyleDisable];
    }
    //    _okButton.enabled = (totalDur >= MIN_VIDEO_DUR);
}

#pragma mark    视频合成
- (void)videoRecorder:(Camera *)videoRecorder didFinishMergingVideosToOutPutFileAtURL:(NSURL *)outputFileURL{
    SkimVideoViewController *skimVideoVC = [[SkimVideoViewController alloc] init];
    skimVideoVC.videoData = self.videoData;
    skimVideoVC.videoUrl = outputFileURL;
    [self.navigationController pushViewController:skimVideoVC animated:YES];
}

- (void)viewDismissAction:(UIButton *)sender{
    if (self.isPushStyle) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark    viewDidAppear
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }

    [self.pcBasicObject sessionStartRunning];
}

#pragma mark    隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark    viewDidDisappear
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
//    [self.pcBasicObject sessionStopRunning];
}

#pragma mark    视频相册
- (UIImagePickerController *)imagePicker{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.modalPresentationStyle= UIModalPresentationOverFullScreen;
        _imagePicker.navigationBar.tintColor = [UIColor whiteColor];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}

#pragma mark    代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL *videoURL = info[UIImagePickerControllerMediaURL];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        // we will convert it to mp4 format
        NSURL *mp4 = [self convert2Mp4:videoURL];
        [self videoAlbumToSkimViewControllerWith:mp4];
    }
}

#pragma mark    切换到视频库
- (void)videoAlbumToSkimViewControllerWith:(NSURL *)videoPath{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    SkimVideoViewController *skimVC = [[SkimVideoViewController alloc] init];
    skimVC.videoData = self.videoData;
    skimVC.videoUrl  = videoPath;
    [self.navigationController pushViewController:skimVC animated:YES];
}

#pragma mark    隐藏视频库
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark    - MOV格式切换到mp4格式
- (NSURL *)convert2Mp4:(NSURL *)movUrl {
    NSURL *mp4Url = nil;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetHighestQuality];
        mp4Url = [movUrl copy];
        mp4Url = [mp4Url URLByDeletingPathExtension];
        mp4Url = [mp4Url URLByAppendingPathExtension:@"mp4"];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        dispatch_semaphore_t wait = dispatch_semaphore_create(0l);
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    NSLog(@"failed, error:%@.", exportSession.error);
                } break;
                case AVAssetExportSessionStatusCancelled: {
                    NSLog(@"cancelled.");
                } break;
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"completed.");
                } break;
                default: {
                    NSLog(@"others.");
                } break;
            }
            dispatch_semaphore_signal(wait);
        }];
        long timeout = dispatch_semaphore_wait(wait, DISPATCH_TIME_FOREVER);
        if (timeout) {
            NSLog(@"timeout.");
        }
        if (wait) {
            //dispatch_release(wait);
            wait = nil;
        }
    }
    return mp4Url;
}

#pragma mark    回收机制
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
