//
//  SkimVideoViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/14.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SkimVideoViewController.h"
#import "SkimVideoView.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>
#import "SelectCoverViewController.h"
#import "TellStoryViewController.h"
#import "NetworkImageUploader.h"
#import "VideoManagementController.h"
#import "VideoManagementView.h"
#import "IndividualViewController.h"
#import "VideoRequestInfoController.h"
#import "VideoRequestData.h"
#import "VideoRequestController.h"
#import "ImageCompressTool.h"

@interface SkimVideoViewController () <VideoDelegate>
@property (nonatomic, strong) SkimVideoView       *rootView;
@property (nonatomic, strong) AVPlayerItem      *playerItem;     //AVItem
@property (nonatomic, assign) CGFloat       currentDuration;     //当前时间
@property (nonatomic, assign) CGFloat    totalMovieDuration;     //总时间
@property (nonatomic, assign) BOOL                isPlaying;     //播放状态
@property (nonatomic, assign) BOOL            isAddObserver;     //是否添加了观察者

@end

@implementation SkimVideoViewController

- (void)loadView{
    self.rootView = [[SkimVideoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.rootView.parentController = self;
    self.view     = self.rootView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self addObserver];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self removeObserver];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self movieToImage];
    [self addFunction];
    [self readyMovieContent];
}

#pragma mark    准备电影资料
- (void)readyMovieContent
{
    //准备AVURLAsset
    AVURLAsset *anAsset = [[AVURLAsset alloc] initWithURL:self.videoUrl options:nil];
    //fix me
    
    //fix me
    
    NSArray *keys       = @[@"duration"];
    [anAsset loadValuesAsynchronouslyForKeys:keys completionHandler:^() {
        NSError *error  = nil;
        AVKeyValueStatus tracksStatus = [anAsset statusOfValueForKey:@"duration" error:&error];
        switch (tracksStatus) {
            case AVKeyValueStatusUnknown:
                break;
            case AVKeyValueStatusLoading:
                break;
            case AVKeyValueStatusLoaded:
                [self updateUserInterfaceForDurationWith:anAsset];
                break;
            case AVKeyValueStatusFailed:
                [self failedAction];
                break;
            case AVKeyValueStatusCancelled:
                [self cancledAction];
                break;
        }
    }];
}

#pragma mark    添加功能
- (void)addFunction{
    [self.rootView.tapGR addTarget:self
                            action:@selector(playAndStopVideoAction)];
    
    [self.rootView.selectCoverImageButton addTarget:self
                                             action:@selector(selectCoverImageButtonAction:)
                                   forControlEvents:UIControlEventTouchUpInside];
    
    [self.rootView.returnButton addTarget:self
                                   action:@selector(returnButtonACtion:)
                         forControlEvents:UIControlEventTouchUpInside];
    
    [self.rootView.finishButton addTarget:self
                                   action:@selector(finishVideoEditing:)
                         forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark    更新用户接口
- (void)updateUserInterfaceForDurationWith:(AVURLAsset *)asset{
    self.playerItem             = [[AVPlayerItem alloc] initWithAsset:asset];
    AVPlayer *player            = [AVPlayer      playerWithPlayerItem:self.playerItem];
    AVPlayerLayer *playerLayer  = [AVPlayerLayer playerLayerWithPlayer:self.rootView.showVideoArea.player];
    playerLayer.videoGravity    = AVLayerVideoGravityResizeAspectFill;
    [self.rootView.showVideoArea setPlayer:player];
    [self.rootView.showVideoArea setDelegate:self];
    self.isPlaying = YES;
    [self.rootView.showVideoArea.player play];
}

#pragma mark    失败
- (void)failedAction{
    self.isAddObserver = NO;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"视频加载失败, 请退回重试"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma mark    取消
- (void)cancledAction{
    self.isAddObserver = NO;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"视频加载被取消, 请退回重试"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma mark    选择封面
- (void)selectCoverImageButtonAction:(UIButton *)sender{
    WeakSelf;
    [self.rootView.showVideoArea.player pause];
    SelectCoverViewController *selectCoverVC = [[SelectCoverViewController alloc] init];
    selectCoverVC.videoURL = self.videoUrl;
    //    selectCoverVC.videoDuration = self.totalMovieDuration;
    selectCoverVC.localBlock = ^(UIImage *image){
        weakSelf.coverImage  = image;
        weakSelf.rootView.coverImageView.image = image;
    };
    [self.navigationController pushViewController:selectCoverVC animated:YES];
}

#pragma mark    返回
- (void)returnButtonACtion:(UIButton*)sender{
    [self playVideo:NO];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark    完成视频录制
- (void)finishVideoEditing:(UIButton *)sender{
    [self.rootView.showVideoArea.player pause];
    UIViewController *controller = [[self.navigationController viewControllers] firstObject];
    if ([controller isKindOfClass:[TellStoryViewController class]]) {
        TellStoryViewController *storyVC = (TellStoryViewController *)controller;
        storyVC.willUploadVideoUrl = self.videoUrl;
        [storyVC refreshCollectionViewAction:@[self.coverImage] withFlag:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [progressHUD showProgressText:@"上传中"];
    
    //上传自定义视频
    if ([[self.navigationController.viewControllers objectAtIndex:1]
         isKindOfClass:[VideoRequestController class]]) {
        VideoRequestInfoController *videoRequestInfoVC = (VideoRequestInfoController *)[self.navigationController.viewControllers objectAtIndex:2];
        
        [[NetworkImageUploader manager] uploadVideoCoverImage:[ImageCompressTool compressImage:self.coverImage] withResult:^(BOOL isSuccess, NSMutableArray *iconContainer) {
            if (isSuccess) {
                [[NetworkImageUploader manager] uploadCustomVideo:self.videoUrl withResult:^(BOOL isSuccess, NSString *path) {
                    if (isSuccess) {
                        [self userAlbumVideoWithAlbumID:[iconContainer firstObject] withVideoID:path withResultBlock:^(BOOL isSuccess) {
                            if (isSuccess) {
                                [self replyVideoRequstWithType:1 withInviteID:videoRequestInfoVC.requestData.requestID withReason:nil withResultBlock:^(BOOL isSuccess) {
                                    if (isSuccess) {
                                        [progressHUD hide:YES];
                                        VideoRequestController *videoRequestVC = (VideoRequestController *)[self.navigationController.viewControllers objectAtIndex:1];
                                        [videoRequestVC.videoRequestView startDataRefresh];
                                        [self.navigationController popToViewController:videoRequestVC animated:NO];
                                    }else{
                                        [progressHUD hide:YES];
                                    }
                                }];
                            }else{
                                [progressHUD hide:YES];
                            }
                        }];
                        
                    }else{
                        [progressHUD hide:YES];
                    }
                }];
            }else{
                [progressHUD hide:YES];
            }
        }];
        
        //上传制式视频
    }else if([[self.navigationController.viewControllers objectAtIndex:1]
              isKindOfClass:[VideoManagementController class]]){
        [[NetworkImageUploader manager] uploadVideoCoverImage:[ImageCompressTool compressImage:self.coverImage] withResult:^(BOOL isSuccess, NSMutableArray *iconContainer) {
            if (isSuccess) {
                [[NetworkImageUploader manager] uploadStandardVideo:self.videoUrl withTitle:self.videoData.videoTitle withResult:^(BOOL isSuccess, NSString *path) {
                    if (isSuccess) {
                        [self userAlbumVideoWithAlbumID:[iconContainer firstObject] withVideoID:path withResultBlock:^(BOOL isSuccess) {
                            if (isSuccess) {
                                [progressHUD hide:YES];
                                UIViewController *controller = [self.navigationController.viewControllers objectAtIndex:1];
                                VideoManagementController *videoMVC = (VideoManagementController *)controller;
                                [videoMVC.videoManagementView startDataRefresh];
                                [self.navigationController popToViewController:videoMVC animated:NO];
                            }else{
                                [progressHUD hide:YES];
                            }
                        }];
                    }else{
                        [progressHUD hide:YES];
                    }
                }];
            }
        }];
    }
}

#pragma mark    - 视频方法
#pragma mark    视频播放与停止
- (void)playAndStopVideoAction{
    self.isPlaying = !self.isPlaying;
    [self playVideo:self.isPlaying];
    [self.rootView hidePlayVideoButton:self.isPlaying];
}

- (void)playVideo:(BOOL)isPlay{
    if (!isPlay) {
        [self.rootView.showVideoArea.player pause];
    }else{
        [self.rootView.showVideoArea.player play];
    }
}

#pragma mark   播放结束时
- (void)playerItemDidReachEnd:(NSNotification *)notification {
    [self.rootView.showVideoArea.player seekToTime:kCMTimeZero];
    [self.rootView hidePlayVideoButton:NO];
    self.isPlaying = NO;
}

#pragma mark    进入后台
- (void)applicationWillResignActive:(NSNotification *)notification{
    [self.rootView hidePlayVideoButton:NO];
    [self playVideo:NO];
    self.isPlaying = NO;
}

- (void)AVPlayerItemPlaybackStalledAction{
    APPLog(@"卡顿");
}

#pragma mark    视频播放失败时调用
- (void)AVPlayerStatusFailedAction{
    self.playerItem = nil;
    self.rootView.showVideoArea.player = nil;
    self.isPlaying = NO;
    [self removeObserver];
    [self readyMovieContent];
}

#pragma mark    添加观察者
- (void)addObserver{
    self.isAddObserver = YES;
    WeakSelf;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.rootView.showVideoArea.player != nil)
            
            [weakSelf.rootView.showVideoArea.player.currentItem  addObserver:self
                                                                  forKeyPath:@"status"
                                                                     options:NSKeyValueObservingOptionNew
                                                                     context:nil];
        
        
        [weakSelf.rootView.showVideoArea.player.currentItem addObserver:self
                                                             forKeyPath:@"rate"
                                                                options:NSKeyValueObservingOptionNew
                                                                context:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillResignActive:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AVPlayerItemPlaybackStalledAction)
                                                     name:AVPlayerItemPlaybackStalledNotification
                                                   object:nil];
    });
}

#pragma mark    移除观察者
- (void)removeObserver{
    if (self.isAddObserver) {
        //        [self.rootView.showVideoArea.player.currentItem removeObserver:self forKeyPath:@"status"];
        //        [self.rootView.showVideoArea.player.currentItem removeObserver:self forKeyPath:@"rate"];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AVPlayerItemDidPlayToEndTimeNotification
                                                      object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIApplicationWillResignActiveNotification
                                                      object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AVPlayerItemPlaybackStalledNotification
                                                      object:nil];
    }
}

#pragma mark    监视属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *item = (AVPlayerItem*)object;
        if (item.status == AVPlayerStatusReadyToPlay){
            //计算视频总时间
            CMTime totalTime        = item.duration;
            self.totalMovieDuration = (CGFloat)totalTime.value/totalTime.timescale;
        }
        if (item.status == AVPlayerStatusFailed) {
            APPLog(@"AVPlayerStatusFailed");
            [self AVPlayerStatusFailedAction];
        }
        
        if (item.status == AVPlayerStatusUnknown) {
            APPLog(@"AVPlayerStatusUnknown");
        }
    }
    
    //检测视频是否正在播放
    if ([keyPath isEqualToString:@"rate"]) {
        if (self.rootView.showVideoArea.player.rate != 0) {
            //            buffer rolling
        }else{
            //            buffer rolling
        }
    }
}

#pragma mark    -
#pragma mark    快进
- (void)Touchspeed:(CGFloat)Percentage
{
    //获取当前时间
    CMTime currentTime  = self.rootView.showVideoArea.player.currentItem.currentTime;
    
    //转成秒数
    self.currentDuration = (CGFloat)currentTime.value/currentTime.timescale;
    CGFloat offsetTime   = self.totalMovieDuration *Percentage;
    CGFloat newTime      = self.currentDuration + offsetTime;
    if (newTime >= self.totalMovieDuration)
    {
        return;
    }
    [self speed:offsetTime];
}

- (void)speed:(CGFloat)offset{
    CGFloat newTime = self.currentDuration + offset;
    if (newTime >= self.totalMovieDuration){
        if (self.isPlaying == YES)
        {
            [self.rootView.showVideoArea.player play];
        }
        return;
    }
    
    //转换成CMTime才能给player来控制播放进度
    int32_t timeScale   = self.rootView.showVideoArea.player.currentItem.duration.timescale;
    CMTime dragedCMTime = CMTimeMakeWithSeconds(newTime, timeScale);
    [self.rootView.showVideoArea.player seekToTime: dragedCMTime
                                   toleranceBefore: kCMTimeZero
                                    toleranceAfter: kCMTimeZero
                                 completionHandler: ^(BOOL finished) {
                                     if (finished){
                                         self.isPlaying = YES;
                                         [self.rootView.showVideoArea.player play];
                                     }
                                 }];
}

#pragma mark    -
#pragma mark    快退
- (void) Touchretreat:(CGFloat)Percentage
{
    //获取当前时间
    CMTime currentTime  = self.rootView.showVideoArea.player.currentItem.currentTime;
    //转成秒数
    self.currentDuration = (CGFloat)currentTime.value/currentTime.timescale;
    CGFloat offsetTime   = self.totalMovieDuration *Percentage;
    CGFloat newTime      = self.currentDuration - offsetTime;
    if (newTime <= 0.0){
        return;
    }
    [self retreat:offsetTime];
}

#pragma mark    快后
- (void)retreat:(CGFloat)offset{
    CGFloat newTime = self.currentDuration - offset;
    if (newTime <= 0.0)
    {
        if (self.isPlaying == YES)
        {
            [self.rootView.showVideoArea.player play];
        }
        return;
    }
    //转换成CMTime才能给player来控制播放进度
    int32_t timeScale   = self.rootView.showVideoArea.player.currentItem.duration.timescale;
    CMTime dragedCMTime = CMTimeMakeWithSeconds(newTime, timeScale);
    [self.rootView.showVideoArea.player seekToTime: dragedCMTime
                                   toleranceBefore: kCMTimeZero
                                    toleranceAfter: kCMTimeZero
                                 completionHandler: ^(BOOL finished) {
                                     if (finished){
                                         self.isPlaying = YES;
                                         [self.rootView.showVideoArea.player play];
                                     }
                                 }];
}

#pragma mark    调用工具函数
#pragma mark    截取第一帧
- (void)movieToImage{
    AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:self.videoUrl options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform=TRUE;
    asset = nil;
    CMTime thumbTime = CMTimeMakeWithSeconds(0,30);
    
    AVAssetImageGeneratorCompletionHandler handler =
    ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
        if (result != AVAssetImageGeneratorSucceeded) {       }//没成功
        
        UIImage *thumbImg = [UIImage imageWithCGImage:im];
        [self performSelectorOnMainThread:@selector(movieImage:) withObject:thumbImg waitUntilDone:YES];
    };
    
    generator.maximumSize = CGSizeMake(ScreenWidth, [Adaptor returnAdaptorValue:346]);
    [generator generateCGImagesAsynchronouslyForTimes:
     [NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
}

#pragma makr    给封面赋予图片
- (void)movieImage:(UIImage *)image{
    self.rootView.coverImageView.image = image;
    self.coverImage = image;
}

#pragma mark    viewDidAppear
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

#pragma mark    隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
- (void)replyVideoRequstWithType:(NSInteger)type
                    withInviteID:(NSString *)inviteID
                      withReason:(NSString *)reason
                 withResultBlock:(void(^)(BOOL isSuccess))result{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameter setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameter setValue:[NSNumber numberWithInteger:type] forKey:@"type"];
    [parameter setValue:inviteID forKey:@"invite_id"];
    [parameter setValue:reason forKey:@"reason"];
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl]
                                        stringByAppendingString:@"user_video_reply"]
                            parameters:parameter success:^(id responseObject) {
                                if (publishProtocol(responseObject) == 0) {
//                                    NSInteger rewardCount = 0;
//                                    id reward_balance = [responseObject objectForKey:@"reward_balance"];
//                                    if(reward_balance != nil && reward_balance != [NSNull null]) {
//                                        rewardCount = [reward_balance integerValue];
//                                        reward_balance = nil;
//                                    }
//                                    
//                                    id user_balance = [responseObject objectForKey:@"user_balance"];
//                                    if(user_balance != nil && user_balance != [NSNull null]) {
//                                        [UserManager manager].userBalance = [user_balance integerValue];
//                                        user_balance = nil;
//                                    }
                                    result(YES);
                                }else{
                                    result(NO);
                                }
                            } failure:^(NSError *error) {
                                result(NO);
                            }];
}

#pragma mark    图片和视频关联
- (void)userAlbumVideoWithAlbumID:(NSString *)albumID
                      withVideoID:(NSString *)videoID
                  withResultBlock:(void(^)(BOOL isSuccess))result{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:albumID forKey:@"album_id"];
    [parameter setValue:videoID forKey:@"video_id"];
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl]
                                        stringByAppendingString:@"user_album_video"]
                            parameters:parameter success:^(id responseObject) {
                                if (publishProtocol(responseObject) == 0) {
                                    result(YES);
                                }else{
                                    result(NO);
                                }
                            } failure:^(NSError *error) {
                                result(NO);
                            }];
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
