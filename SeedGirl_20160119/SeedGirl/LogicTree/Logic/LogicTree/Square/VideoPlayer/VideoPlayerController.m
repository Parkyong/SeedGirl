//
//  VideoPlayerController.m
//  SeedGirl
//
//  Created by Admin on 15/12/10.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoPlayerController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VideoPlayerControlView.h"
#import "VideoData.h"

@interface VideoPlayerController ()

//播放器
@property (nonatomic, strong) MPMoviePlayerViewController *playerVC;
//控制视图
@property (nonatomic, strong) VideoPlayerControlView *controlView;
//提示
@property (nonatomic, strong) OwnProgressHUD *progressHUD;
//时间
@property (nonatomic, strong) NSTimer *videoTimer;

@end

@implementation VideoPlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载播放器
    [self loadVideoPlayer];
    //加载控制视图
    [self loadControlView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //添加观察
    [self addVideoObserver];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //移除观察
    [self removeVideoObserver];
}

#pragma mark - main
//加载播放器
- (void)loadVideoPlayer {
    if (self.videoData == nil) {
        return ;
    }
    
    //播放器
    NSLog(@"video url is %@",self.videoData.videoURL);
    NSURL *videoURL = [NSURL URLWithString:self.videoData.videoURL];
   
    self.playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
    self.playerVC.view.backgroundColor = [UIColor whiteColor];

    MPMoviePlayerController *player = [self.playerVC moviePlayer];
    player.controlStyle = MPMovieControlStyleNone;
    player.scalingMode = MPMovieScalingModeAspectFit;
    player.repeatMode = MPMovieRepeatModeNone;
    player.shouldAutoplay = YES;
    
//    [player prepareToPlay];
    
    [self.view addSubview:self.playerVC.view];
}

//加载控制视图
- (void)loadControlView {
    //控制视图
    [self.view addSubview:self.controlView];
    [self.controlView setControlState:0];
    
    WeakSelf;
    //关闭
    self.controlView.closeBlock = ^(){
        [weakSelf videoClose];
    };
    //播放
    self.controlView.playBlock = ^(){
        [weakSelf videoPlay];
    };
    //暂停
    self.controlView.pauseBlock = ^(){
        [weakSelf videoPause];
    };
    //聊天
    self.controlView.chatBlock = ^(){
        [weakSelf chat];
    };
    //进度
    self.controlView.sliderBlock = ^(float value){
        NSLog(@"slider value is %f",value);

        MPMoviePlayerController *player = [weakSelf.playerVC moviePlayer];
        player.currentPlaybackTime = value;
        if (player.playbackState != MPMoviePlaybackStatePlaying) {
            [player play];
        }
    };
    
    //提示
//    self.progressHUD = [OwnProgressHUD showAddedTo:self.view animated:YES];
//    [self.progressHUD showProgressText:@"正在加载..."];
}

//添加观察
- (void)addVideoObserver {
    //定时器
    self.videoTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(videoTimerSchedule) userInfo:nil repeats:YES];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    //加载
    [notificationCenter addObserver:self selector:@selector(movieLoadStateChangeCallback:) name:MPMoviePlayerLoadStateDidChangeNotification object:[self.playerVC moviePlayer]];
    //视频总时长
    [notificationCenter addObserver:self selector:@selector(movieDurationCallback:) name:MPMovieDurationAvailableNotification object:[self.playerVC moviePlayer]];
    //播放准备
    [notificationCenter addObserver:self selector:@selector(moviePreparedToPlayChangeCallback:) name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object:[self.playerVC moviePlayer]];
    //播放状态
    [notificationCenter addObserver:self selector:@selector(movieStateChangeCallback:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:[self.playerVC moviePlayer]];
    //结束
    [notificationCenter addObserver:self selector:@selector(movieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:[self.playerVC moviePlayer]];
}

//移除观察
- (void)removeVideoObserver {
    
    [self.videoTimer invalidate];
    self.videoTimer = nil;
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    //加载
    [notificationCenter removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:[self.playerVC moviePlayer]];
    //视频总时长
    [notificationCenter removeObserver:self name:MPMovieDurationAvailableNotification object:[self.playerVC moviePlayer]];
    //播放准备
    [notificationCenter removeObserver:self name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object:[self.playerVC moviePlayer]];
    //播放状态
    [notificationCenter removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:[self.playerVC moviePlayer]];
    //结束
    [notificationCenter removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:[self.playerVC moviePlayer]];
}

//显示信息
- (void)showMessage:(NSString *)message{
    OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:self.view animated:YES];
    [progressHUD showText:message];
    [progressHUD hide:YES afterDelay:2];
}

- (BOOL)shouldAutorotate {
    return YES;
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscape;
//}

#pragma mark - Control View

//视频关闭
- (void)videoClose {
    MPMoviePlayerController *player = [self.playerVC moviePlayer];
    if (player.playbackState != MPMoviePlaybackStateStopped) {
        [player stop];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//视频播放
- (void)videoPlay {
    MPMoviePlayerController *player = [self.playerVC moviePlayer];
    [player play];
}

//视频暂停
- (void)videoPause {
    MPMoviePlayerController *player = [self.playerVC moviePlayer];
    [player pause];
}

//聊天
- (void)chat {

}

//视频时间定时器
- (void)videoTimerSchedule {
    [self.controlView setVideoCurrentTime:[[self.playerVC moviePlayer] currentPlaybackTime]];
}

#pragma mark - Movie Notification

//加载状态改变
- (void)movieLoadStateChangeCallback:(NSNotification *)notification {
    NSLog(@"movieLoadStateChangeCallback");
    MPMoviePlayerController *player = [notification object];
    switch (player.loadState) {
        case MPMovieLoadStateUnknown:
            NSLog(@"未知");
            break;
        case MPMovieLoadStatePlayable:
            NSLog(@"首次加载或前后拖动");
            break;
        case MPMovieLoadStatePlaythroughOK:
            NSLog(@"加载正常");
            break;
        case MPMovieLoadStateStalled:
            NSLog(@"加载缓冲");
            break;
        default:
            break;
    }
}

//视频总时长
- (void)movieDurationCallback:(NSNotification *)notification {
    MPMoviePlayerController *player = [notification object];
    [self.controlView setVideoTotalTime:player.duration];
}

//播放准备
- (void)moviePreparedToPlayChangeCallback:(NSNotification *)notification {
    NSLog(@"moviePreparedToPlayChanageCallback");
}

//播放状态改变
- (void)movieStateChangeCallback:(NSNotification *)notification {
    NSLog(@"movieStateChangeCallback");
    MPMoviePlayerController *player = [notification object];
    switch (player.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放");
            [self.controlView setControlState:1];
            [self.videoTimer setFireDate:[NSDate distantPast]];
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停");
            [self.controlView setControlState:2];
            [self.videoTimer setFireDate:[NSDate distantFuture]];
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止");
            [self.controlView setControlState:3];
            [self.videoTimer setFireDate:[NSDate distantFuture]];
            break;
        default:
            break;
    }
}

//播放结束
- (void)movieFinishedCallback:(NSNotification *)notification {
    NSLog(@"movieFinishedCallback");
    MPMoviePlayerController *player = [notification object];
    
    [self.controlView setControlState:3];
    [self.videoTimer setFireDate:[NSDate distantFuture]];
    [self.controlView setVideoCurrentTime:player.duration];
}

#pragma mark - lazyload

//控制视图
- (VideoPlayerControlView *)controlView {
    if (_controlView == nil) {
        _controlView = [[VideoPlayerControlView alloc] initWithFrame:self.view.bounds];
        _controlView.backgroundColor = [UIColor clearColor];
    }
    return _controlView;
}

@end
