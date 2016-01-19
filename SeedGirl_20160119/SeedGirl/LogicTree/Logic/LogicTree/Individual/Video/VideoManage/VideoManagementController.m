//
//  VideoManagementController.m
//  SeedGirl
//
//  Created by Admin on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoManagementController.h"
#import "VideoManagementView.h"
#import "PhotographViewController.h"
#import "AlbumViewController.h"
#import "SeedPlayer.h"
#import "SkimVideoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface VideoManagementController ()<VideoManagementViewProtocol, UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) SystemVideoData               *videoData;
@property (nonatomic, strong) UIImagePickerController     *imagePicker;

@end

@implementation VideoManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //属性布局
    [self attributeLayout];
    //加载子视图
    [self loadSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.videoManagementView firstLoad];
}

//属性布局
- (void)attributeLayout {
    [self setTitle:@"管理制式视频"];
    [self.view setBackgroundColor:RGB(240, 242, 245)];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}
//加载子视图
- (void)loadSubviews {
    [self.view addSubview:self.videoManagementView];
    self.videoManagementView.viewDelegate = self;
}

#pragma mark     cell代理方法
#pragma mark    增加视频
- (void)addMovieWithCell:(VideoManagementCell *)cell
           withIndexPath:(NSIndexPath *)indexPath
                withData:(SystemVideoData *)data{
    self.videoData = data;
    [self showActionSheetAction];
}

#pragma mark    修改视频
- (void)modifyMovieWithCell:(VideoManagementCell *)cell
             withIndexPath:(NSIndexPath *)indexPath
                  withData:(SystemVideoData *)data{
    
    self.videoData = data;
    [self showActionSheetAction];
}

#pragma mark    删除视频
- (void)deleteMovieWithCell:(VideoManagementCell *)cell
              withIndexPath:(NSIndexPath *)indexPath
                   withData:(SystemVideoData *)data{
    [self deleteMovieRequestWithVideoID:data.videoID withResult:^(BOOL isSuccess) {
        if (isSuccess) {
            [self.videoManagementView refreshView];
        }else{
            NSLog(@"操作失败");
        }
    }];
}

#pragma mark    播放视频
- (void)playMoviewWithMoviePath:(NSString *)moviePath{
    if (moviePath == nil) {
        return;
    }
    SeedPlayer *player = [[SeedPlayer alloc] init];
    player.movieUrl = moviePath;
    [self presentViewController:player animated:YES completion:nil];
}

//接受
- (void)showActionSheetAction{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    WeakSelf;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    //拍摄
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍摄"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             //action
                                                             [weakSelf commonActionSheetClickedButtonAtIndex:0];
                                                         }];
    [alertController addAction:cameraAction];
    //相册
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册中选择"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                            //action
                                                            [weakSelf commonActionSheetClickedButtonAtIndex:1];
                                                        }];
    [alertController addAction:albumAction];
    [alertController.view setTintColor:RGB(51, 51, 51)];
    [self presentViewController:alertController animated:YES completion:nil];
#else
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍摄",@"从相册中选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
#endif
}

#pragma mark    actionsheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self commonActionSheetClickedButtonAtIndex:buttonIndex];
}

#pragma mark    actionsheet代理方法
- (void)commonActionSheetClickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        PhotographViewController *photographVC   = [[PhotographViewController alloc] init];
        photographVC.isPushStyle                 = YES;
        photographVC.isChangeHeadImage           = NO;
        photographVC.viewType                    = RECORDVIEW;
        photographVC.videoData                   = self.videoData;
        [self.navigationController pushViewController:photographVC animated:YES];
    }else if(buttonIndex == 1){
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
        [self presentViewController:self.imagePicker animated:YES completion:NULL];
    }
}

#pragma mark - lazyload
- (VideoManagementView *)videoManagementView {
    if (_videoManagementView == nil) {
        CGFloat y = StatusBarHeight + NavigationBarHeight;
        CGRect rect = CGRectMake(8.0f, y, CGRectGetWidth(self.view.bounds)-16.0f, CGRectGetHeight(self.view.bounds)-y);
        _videoManagementView = [[VideoManagementView alloc] initWithFrame:rect];
        _videoManagementView.backgroundColor = [UIColor clearColor];
    }
    return _videoManagementView;
}

#pragma mark    删除视频接口
- (void)deleteMovieRequestWithVideoID:(NSString *)videoID withResult:(void(^)(BOOL isSuccess))result{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameter setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameter setValue:videoID forKey:@"video_id"];
    
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_personal_video_delete"] parameters:parameter success:^(id responseObject) {
        NSLog(@"responseObject:%@", responseObject);
        if (publishProtocol(responseObject) == 0) {
            result(YES);
        }else{
            result(NO);
        }
    } failure:^(NSError *error) {
        result(NO);
    }];
}

//fix me
#pragma mark    相册
#pragma mark    视频相册
- (UIImagePickerController *)imagePicker
{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.modalPresentationStyle= UIModalPresentationOverFullScreen;
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL *videoURL = info[UIImagePickerControllerMediaURL];
        [picker dismissViewControllerAnimated:YES completion:nil];
        // video url:
        // file:///private/var/mobile/Applications/B3CDD0B2-2F19-432B-9CFA-158700F4DE8F/tmp/capture-T0x16e39100.tmp.9R8weF/capturedvideo.mp4
        // we will convert it to mp4 format
        NSURL *mp4 = [self convert2Mp4:videoURL];
        [self videoAlbumToSkimViewControllerWith:mp4];
    }
}

- (void)videoAlbumToSkimViewControllerWith:(NSURL *)videoPath{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    SkimVideoViewController *skimVC = [[SkimVideoViewController alloc] init];
    skimVC.videoData = self.videoData;
    skimVC.videoUrl  = videoPath;
    [self.navigationController pushViewController:skimVC animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - helper
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

@end