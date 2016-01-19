//
//  SeedPlayer.m
//  SeedSocial
//
//  Created by ParkHunter on 15/5/12.
//  Copyright (c) 2015年 altamob. All rights reserved.
//

#import "SeedPlayer.h"
#import <MediaPlayer/MediaPlayer.h>
#import "APPConfig.h"
#import "NetworkConfig.h"
#import "UserManager.h"
#import "UserData.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>


typedef void(^ResultBlockType)(BOOL isSuccess);

@interface SeedPlayer ()
@property (strong, nonatomic) IBOutlet            SeedPlayerView *movieView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *moviebuffer;
@property (strong, nonatomic) IBOutlet                  UIView *controlView;

@property (strong, nonatomic) IBOutlet           UILabel *currentTimeLabel;     //当前播放时间
@property (strong, nonatomic) IBOutlet              UILabel *durationLabel;     //播放总长
@property (strong, nonatomic) IBOutlet                   UIButton *PlayBTN;     //播放按钮
@property (strong, nonatomic) IBOutlet UIProgressView *movieCachedProgress;     //缓冲条
@property (strong, nonatomic) IBOutlet       UISlider *movieProgressSlider;     //进度条
@property (strong, nonatomic) IBOutlet                      UIView *upView;     //上面放button的view
@property (strong, nonatomic) IBOutlet                    UIView *downView;     //下面放button的view
@property (strong, nonatomic) IBOutlet                   UIButton *backBTN;     //退出按钮
@property (strong, nonatomic) IBOutlet                 UIButton *attention;     //关注按钮
@property (strong, nonatomic) IBOutlet                   UIButton *loopBTN;     //循环按钮
@property (strong, nonatomic) UIView                            *volumView;     //音量试图
@property (nonatomic, strong)                   MPVolumeView *myVolumeView;     //音量试图
@property (nonatomic, strong)                     AVPlayerItem *playerItem;     //AVItem
@property (nonatomic, strong) UIImageView                  *chattingWindow;     //

@property (nonatomic, assign)                              BOOL isShowView;      //控制全部icon的显隐性
@property (nonatomic, assign)                               BOOL isPlaying;      //播放状态
@property (nonatomic, assign)                                  BOOL isLoop;      //循环播放
@property (nonatomic, assign)                           BOOL isAddObserver;      //是否添加观察者
@property (nonatomic, assign)                            BOOL isFinishHide;      //是否结束隐藏动作
@property (nonatomic, assign)                   CGFloat totalMovieDuration;      //总时间
@property (nonatomic, assign)                      CGFloat currentDuration;      //当前时间
@property (nonatomic, assign)                             CGFloat upView_Y;      //上图Y
@property (nonatomic, assign)                           CGFloat downView_Y;      //下图Y
@property (nonatomic, assign)                      BOOL isFinishInspection;      //检查
@property (nonatomic, strong)                          NSTimer *closeTimmer;     //关闭timmer
@end

@implementation SeedPlayer
@synthesize movieView, movieCachedProgress, movieProgressSlider, playerItem, volumView,
currentTimeLabel, durationLabel, upView, downView, PlayBTN, myVolumeView,
loopBTN, moviebuffer, controlView, chattingWindow;

@synthesize isShowView, totalMovieDuration, currentDuration, isPlaying, isLoop, isAddObserver,
isFinishHide, isFinishInspection;

#pragma mark    viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initlization];
}

#pragma mark    初始化
- (void)initlization
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setUpUI];
    [self readyMovieContent];
    NSLog(@"%@",self);
}

#pragma mark    设置UI
- (void)setUpUI
{
    movieView.userInteractionEnabled           = YES;
    upView.userInteractionEnabled              = YES;
    downView.userInteractionEnabled            = YES;
    movieCachedProgress.userInteractionEnabled = NO;
    
    //添加缓冲指示器
    [moviebuffer setHidesWhenStopped:YES];
    [moviebuffer startAnimating];
    //    PlayBTN.hidden  = YES;
    //设置初始值
    isFinishHide    = YES;
    
    //设置音量试图
    volumView = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth - 100)/2,
                                                         (ScreenHeight -100)/2,
                                                         100,
                                                         100)];
    volumView.backgroundColor = [UIColor blueColor];
    volumView.hidden          = YES;
    [controlView addSubview:volumView];
    
    myVolumeView = [[MPVolumeView alloc] initWithFrame:volumView.bounds];
    [myVolumeView setHidden:YES];
    [myVolumeView setUserInteractionEnabled:NO];
    [volumView addSubview: myVolumeView];
    
    
    movieProgressSlider.value = 0;
    
    //设置进度条
    [movieProgressSlider setThumbImage:[UIImage imageWithContentOfFile:@"player_button_progress.png"]
                              forState:UIControlStateHighlighted];
    
    [movieProgressSlider setThumbImage:[UIImage imageWithContentOfFile:@"player_button_progress.png"]
                              forState:UIControlStateNormal];
    
    [movieProgressSlider addTarget:self action:@selector(scrubbingDidBegin)
                  forControlEvents:UIControlEventTouchDown];
    
    [movieProgressSlider addTarget:self action:@selector(scrubberIsScrolling)
                  forControlEvents:UIControlEventValueChanged];
    
    [movieProgressSlider addTarget:self action:@selector(scrubbingDidEnd)
                  forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchCancel)];
    
    //隐藏video控件
    [self showVideoControlView:NO];
    
    //添加单击事件
    UITapGestureRecognizer *oneTap = nil;
    oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showIconViews:)];
    oneTap.numberOfTapsRequired    = 1;
    oneTap.delegate                = self;
    [controlView addGestureRecognizer:oneTap];
}

#pragma mark    准备电影资料
- (void)readyMovieContent
{
    if (self.movieUrl == nil) {
        [moviebuffer stopAnimating];
        [self failedAction];
    }
    
    //准备AVURLAsset
    NSURL *moviePath = [NSURL URLWithString:[self.movieUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    AVURLAsset *anAsset = [[AVURLAsset alloc] initWithURL:moviePath options:nil];
    if (anAsset == nil) {
        [moviebuffer stopAnimating];
        [self failedAction];
        return;
    }
    
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
                // Do whatever is appropriate for cancelation.
                [self cancledAction];
                break;
        }
    }];
}

#pragma mark    更新用户接口
- (void)updateUserInterfaceForDurationWith:(AVURLAsset *)asset
{
    playerItem                  = [[AVPlayerItem alloc] initWithAsset:asset];
    AVPlayer *player            = [AVPlayer      playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer  = [AVPlayerLayer playerLayerWithPlayer:movieView.player];
    playerLayer.videoGravity    = AVLayerVideoGravityResizeAspect;
    [movieView setPlayer:player];
    [movieView setDelegate:self];
    
    isPlaying                   = YES;
    isShowView                  = YES;
    isLoop                      = NO;
    isAddObserver               = YES;
    isFinishInspection          = YES;
    [movieView.player play];
    
    NSError *error;
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    
    [self addObserver];
    [self monitorMovieProgress];
}

#pragma mark    失败
- (void)failedAction
{
    isAddObserver = NO;
    [moviebuffer stopAnimating];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showAlertViewMessage:NSLocalizedString(@"视频加载失败, 请退出重试", nil)];
    });
}

#pragma mark    cancle
- (void)cancledAction
{
    isAddObserver = NO;
}

#pragma mark    注销
- (void)destroy
{
    [movieView.player pause];
    [self destroyMovieContent];
    [self destroyUI];
}

#pragma mark    注销UI
- (void)destroyUI
{
    movieProgressSlider = nil;
    currentTimeLabel    = nil;
    durationLabel       = nil;
    PlayBTN             = nil;
    movieCachedProgress = nil;
    upView              = nil;
    downView            = nil;
}

#pragma mark    注销内容
- (void)destroyMovieContent{
    [self removeObserver];
    playerItem          = nil;
    movieView.player    = nil;
    movieView.delegate  = nil;
    movieView           = nil;
}

#pragma mark    添加观察者
- (void)addObserver
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [movieView.player.currentItem  addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [movieView.player.currentItem  addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        [movieView.player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    });
    
}

#pragma mark    移除观察者
- (void)removeObserver
{
    if (isAddObserver) {
        [movieView.player.currentItem removeObserver:self forKeyPath:@"status"];
        [movieView.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [movieView.player removeObserver:self forKeyPath:@"rate"];
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                       name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
}
#pragma mark    -
#pragma mark    监视
- (void)monitorMovieProgress{
    __weak typeof(self) weakSelf = self;
    //第一个参数反应了检测的频率
    [movieView.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time){
        //获取当前时间
        CMTime currentTime                  = weakSelf.movieView.player.currentItem.currentTime;
        //转成秒数
        CGFloat currentPlayTime             = (CGFloat)currentTime.value/currentTime.timescale;
        weakSelf.movieProgressSlider.value  = currentPlayTime/weakSelf.totalMovieDuration;
        NSDate *d                           = [NSDate dateWithTimeIntervalSince1970:currentPlayTime];
        NSDateFormatter *formatter          = [[NSDateFormatter alloc] init];
        if (currentPlayTime/3600 >= 1) {
            [formatter setDateFormat:@"HH:mm:ss"];
        }
        else
        {
            [formatter setDateFormat:@"mm:ss"];
        }
        NSString *showtime             = [formatter stringFromDate:d];
        if (movieProgressSlider.value <= 0) {
            weakSelf.currentTimeLabel.text = @"00:00";
        }else{
            weakSelf.currentTimeLabel.text = showtime;
        }
    }];
}

#pragma mark    -
#pragma mark    监视属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *item = (AVPlayerItem*)object;
        if (item.status == AVPlayerStatusReadyToPlay)
        {
            [moviebuffer stopAnimating];
            PlayBTN.hidden  = NO;
            if (isPlaying) {
                PlayBTN.selected = YES;
            }else{
                PlayBTN.selected = NO;
            }
            
            if (SystemVersion >= 7.0) {
                //计算视频总时间
                CMTime totalTime            = item.duration;
                totalMovieDuration          = (CGFloat)totalTime.value/totalTime.timescale;
                NSDate *d                   = [NSDate dateWithTimeIntervalSince1970:totalMovieDuration];
                NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
                if (totalMovieDuration/3600 >= 1) {
                    [formatter setDateFormat:@"HH:mm:ss"];
                }
                else
                {
                    [formatter setDateFormat:@"mm:ss"];
                }
                NSString *showtimeNew   = [formatter stringFromDate:d];
                durationLabel.text      = showtimeNew;
            }
        }
        if (item.status == AVPlayerStatusFailed) {
            [self showAlertViewMessage:@"Player Failed"];
        }
        if (item.status == AVPlayerStatusUnknown) {
            
        }
    }
    
    //检测缓冲进度
    if ([keyPath isEqualToString:@"loadedTimeRanges"])
    {
        
        
        float bufferTime   = [self availableDuration];
        float durationTime = CMTimeGetSeconds([[movieView.player currentItem] duration]);
        [movieCachedProgress setProgress:bufferTime/durationTime animated:YES];
        if (isPlaying == NO) {
            return;
        }else{
            if (isFinishInspection) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(inspectBlog:) userInfo:nil repeats:NO];
                });
                isFinishInspection = NO;
            }
        }
    }
    
    //检测视频是否正在播放
    if ([keyPath isEqualToString:@"rate"]) {
        if (movieView.player.rate != 0) {
            PlayBTN.selected = YES;
            [moviebuffer stopAnimating];
            PlayBTN.hidden  = NO;
        }else{
            PlayBTN.selected = NO;
            //判断是否手动
            if (isPlaying == NO) {
                [moviebuffer stopAnimating];
                PlayBTN.hidden  = NO;
            }else{
                [moviebuffer startAnimating];
                PlayBTN.hidden  = YES;
            }
        }
    }
}

#pragma mark    －
#pragma mark    滑动
//按动滑块
- (void)scrubbingDidBegin
{
    
    [movieView.player pause];
}

//快进
- (void)scrubberIsScrolling
{
    
    double currentTime = floor(totalMovieDuration * movieProgressSlider.value);

    //转换成CMTime才能给player来控制播放进度
    int32_t timeScale = movieView.player.currentItem.asset.duration.timescale;
    [movieView.player seekToTime:CMTimeMakeWithSeconds(currentTime, timeScale)
                 toleranceBefore: kCMTimeZero
                  toleranceAfter: kCMTimeZero
               completionHandler: ^(BOOL finished) {
                   if (finished) {
//                       if (isPlaying == YES)
//                       {
//                           [movieView.player play];
//                       }
                       [moviebuffer stopAnimating];
                       PlayBTN.hidden  = NO;
                   }
               }];
}

- (void)scrubbingDidEnd
{
    [moviebuffer stopAnimating];
    PlayBTN.hidden  = NO;
//    [movieView.player play];
}

#pragma mark    -
#pragma mark    快进
- (void)Touchspeed:(CGFloat)Percentage
{
    //获取当前时间
    CMTime currentTime  = movieView.player.currentItem.currentTime;
    
    //转成秒数
    currentDuration     = (CGFloat)currentTime.value/currentTime.timescale;
    CGFloat offsetTime  = totalMovieDuration *Percentage;
    CGFloat newTime     = currentDuration + offsetTime;
    if (newTime >= totalMovieDuration)
    {
        return;
    }
    [self speed:offsetTime];
}

- (void)speed:(CGFloat)offset
{
    [moviebuffer startAnimating];
    PlayBTN.hidden  = YES;
    CGFloat newTime = currentDuration + offset;
    if (newTime >= totalMovieDuration)
    {
        if (isPlaying == YES)
        {
            [movieView.player play];
        }
        return;
    }
    
    //转换成CMTime才能给player来控制播放进度
    int32_t timeScale   = movieView.player.currentItem.duration.timescale;
    CMTime dragedCMTime = CMTimeMakeWithSeconds(newTime, timeScale);
    [movieView.player seekToTime: dragedCMTime
                 toleranceBefore: kCMTimeZero
                  toleranceAfter: kCMTimeZero
               completionHandler: ^(BOOL finished) {
                   if (finished){
                       [moviebuffer stopAnimating];
                       PlayBTN.hidden  = NO;
                       [movieView.player play];
                       isPlaying = YES;
                   }
               }];
    
}

#pragma mark    -
#pragma mark    快退
- (void) Touchretreat:(CGFloat)Percentage
{
    //获取当前时间
    CMTime currentTime  = movieView.player.currentItem.currentTime;
    //转成秒数
    currentDuration     = (CGFloat)currentTime.value/currentTime.timescale;
    CGFloat offsetTime  = self.totalMovieDuration *Percentage;
    CGFloat newTime     = currentDuration - offsetTime;
    if (newTime <= 0.0)
    {
        return;
    }
    [self retreat:offsetTime];
}

- (void)retreat:(CGFloat)offset
{
    [moviebuffer startAnimating];
    PlayBTN.hidden  = YES;
    CGFloat newTime = currentDuration - offset;
    if (newTime <= 0.0)
    {
        if (isPlaying == YES)
        {
            [movieView.player play];
        }
        return;
    }
    //转换成CMTime才能给player来控制播放进度
    int32_t timeScale   = movieView.player.currentItem.duration.timescale;
    CMTime dragedCMTime = CMTimeMakeWithSeconds(newTime, timeScale);
    [movieView.player seekToTime: dragedCMTime
                 toleranceBefore: kCMTimeZero
                  toleranceAfter: kCMTimeZero
               completionHandler: ^(BOOL finished) {
                   if (finished){
                       [moviebuffer stopAnimating];
                       PlayBTN.hidden  = NO;
                       [movieView.player play];
                       isPlaying = YES;
                   }
               }];
}

#pragma mark    增加音量
- (void)IncreaseTheVolume
{
    volumView.hidden = NO;
    UISlider* volumeViewSlider = nil;
    MPVolumeView *firstView = volumView.subviews.firstObject;
    for (UIView *view in [firstView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            volumeViewSlider = (UISlider*)view;
            break;
        }
    }
    
    // retrieve system volume
    float systemVolume = volumeViewSlider.value;
    
    systemVolume       = systemVolume + 0.05;
    // change system volume, the value is between 0.0f and 1.0f
    [volumeViewSlider setValue:systemVolume animated:NO];
    
    // send UI control event to make the change effect right now.
    [volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
    volumView.hidden = YES;
}

#pragma mark    减小音量
-(void)DecreaseTheVolume
{
    volumView.hidden = NO;
    UISlider* volumeViewSlider = nil;
    MPVolumeView *firstView = volumView.subviews.firstObject;
    for (UIView *view in [firstView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            volumeViewSlider = (UISlider*)view;
            break;
        }
    }
    
    // retrieve system volume
    float systemVolume = volumeViewSlider.value;
    systemVolume       = systemVolume - 0.05;
    // change system volume, the value is between 0.0f and 1.0f
    [volumeViewSlider setValue:systemVolume animated:NO];
    
    // send UI control event to make the change effect right now.
    [volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
    volumView.hidden = YES;
}

#pragma mark   -
#pragma mark   播放结束时
- (void)playerItemDidReachEnd:(NSNotification *)notification {
    [movieView.player seekToTime:kCMTimeZero];
    if (isLoop) {
        isPlaying = YES;
        [movieView.player play];
    }else{
        isPlaying = NO;
        [controlView addSubview:self.chattingWindow];
        [self showVideoControlView:YES];
        
    }
    [moviebuffer stopAnimating];
    [self.closeTimmer invalidate];
    self.closeTimmer = nil;
    PlayBTN.hidden   = NO;
    isFinishHide     = YES;
}

#pragma mark    -
#pragma mark    手动播放与暂停
- (IBAction)PlayAndStopBtn:(id)sender {
    if (isPlaying == YES)
    {
        [sender setSelected:NO];
        isPlaying = NO;
        [movieView.player pause];
    }
    else
    {
        [sender setSelected:YES];
        isPlaying = YES;
        [movieView.player play];
        //移除聊天窗口
        [chattingWindow removeFromSuperview];
        chattingWindow = nil;
    }
    
    if (isFinishHide == YES) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.closeTimmer fire];
        });
        isFinishHide = NO;
    }
}

//#pragma mark    关注行为
//- (IBAction)attentionAction:(UIButton *)sender {
//    [movieView.player pause];
//    NSString *chatter = self.seedID;
//    ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:chatter conversationType:eConversationTypeChat];
//
//    chatController.delelgate = self;
//    chatController.title     = self.seedNickname;
//    [self.navigationController pushViewController:chatController animated:YES];
//}

#pragma mark    退回按钮
- (IBAction)backAction:(UIButton *)sender {
    [self destroy];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark    循环按钮
- (IBAction)loopAction:(UIButton *)sender {
    if (isLoop) {
        [sender setSelected:NO];
        isLoop = NO;
    }else{
        [sender setSelected:YES];
        isLoop = YES;
    }
}

#pragma mark    -
#pragma mark    加载进度
- (float)availableDuration
{
    NSArray *loadedTimeRanges   = [[movieView.player currentItem] loadedTimeRanges];
    if ([loadedTimeRanges count] > 0) {
        CMTimeRange timeRange   = [[loadedTimeRanges objectAtIndex:0] CMTimeRangeValue];
        float startSeconds      = CMTimeGetSeconds(timeRange.start);
        float durationSeconds   = CMTimeGetSeconds(timeRange.duration);
        return (startSeconds + durationSeconds);
    } else {
        return 0.0f;
    }
}

#pragma mark    -
#pragma mark    显示控制栏
- (void)showIconViews:(UITapGestureRecognizer*)tapGR
{
    [self.closeTimmer invalidate];
    self.closeTimmer = nil;
    
    [self showVideoControlView:isShowView];
    isShowView = !isShowView;
    
    if (isShowView == NO) {
        if (isFinishHide == YES) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.closeTimmer invalidate];
                self.closeTimmer = nil;
                [self.closeTimmer fire];
            });
            isFinishHide = NO;
        }
    }
}

#pragma mark    检查是否卡克
- (void)inspectBlog:(NSTimer *)time
{
    if (isPlaying == YES) {
        [movieView.player play];
    }
    isFinishInspection = YES;
}

#pragma mark    隐藏
- (void)afterSomeTimeHideVideoView
{
    [self showVideoControlView:NO];
    isFinishHide = YES;
}

#pragma mark    显示控件
- (void)showVideoControlView:(BOOL)isShow
{
    if (isShow) {
        [UIView animateWithDuration:1 animations:^{
            upView.alpha   = 1;
            downView.alpha = 1;
            PlayBTN.alpha  = 1;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            upView.alpha   = 0;
            downView.alpha = 0;
            PlayBTN.alpha  = 0;
        }];
    }
}

#pragma mark    -
#pragma mark    提示错误信息
- (void)showAlertViewMessage:(NSString *)content
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:content delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes", nil];
    [alertView addSubview:self.view];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self backAction:nil];
    }
}

#pragma mark    进入后台
- (void)applicationWillResignActive:(NSNotification *)notification
{
    isPlaying = NO;
}

#pragma mark    手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UISlider class]])
        return NO;
    else
        return YES;
}

//- (void) restrictRotation:(BOOL)restriction
//{
//    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    appDelegate.restrictRotation = restriction;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark    判断视频方向
/*
- (BOOL)isPortrait:(AVURLAsset *)asset
{
    AVAssetTrack *FirstAssetTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    
    UIImageOrientation FirstAssetOrientation_  = UIImageOrientationUp;
    
    BOOL  isFirstAssetPortrait_  = NO;
    
    CGAffineTransform firstTransform = [FirstAssetTrack preferredTransform];
    
    if(firstTransform.a == 0 && firstTransform.b == 1.0 && firstTransform.c == -1.0 && firstTransform.d == 0)
    {
        FirstAssetOrientation_= UIImageOrientationRight;
        isFirstAssetPortrait_ = YES;
    }
    if(firstTransform.a == 0 && firstTransform.b == -1.0 && firstTransform.c == 1.0 && firstTransform.d == 0)
    {
        FirstAssetOrientation_ =  UIImageOrientationLeft;
        isFirstAssetPortrait_ = YES;
    }
    if(firstTransform.a == 1.0 && firstTransform.b == 0 && firstTransform.c == 0 && firstTransform.d == 1.0)
    {
        FirstAssetOrientation_ =  UIImageOrientationUp;
    }
    if(firstTransform.a == -1.0 && firstTransform.b == 0 && firstTransform.c == 0 && firstTransform.d == -1.0)
    {
        FirstAssetOrientation_ = UIImageOrientationDown;
    }
    
    if(isFirstAssetPortrait_)
    {
        return YES;
    }
    else{
        return NO;
    }
}
 */

//- (UIImageView *)chattingWindow
//{
//    if (chattingWindow == nil) {
//        chattingWindow = [[UIImageView alloc] initWithFrame:CGRectMake(
//                                                                      (self.view.bounds.size.width - 274)/2,
//                                                                      CGRectGetMaxY(PlayBTN.frame) + 80, 274,
//                                                                       95)];
//        chattingWindow.image = [UIImage imageWithContentOfFile:@"player_button_chat_up.png"];
//        chattingWindow.userInteractionEnabled = YES;
//        
//        UITapGestureRecognizer *chattingTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(attentionAction:)];
//        [chattingWindow addGestureRecognizer:chattingTapGR];
//        
//        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(chattingWindow.frame)/2 - 20, (CGRectGetHeight(chattingWindow.frame) - 60)/2, 120, 60)];
//        contentLabel.text                   = @"和她聊聊天";
//        contentLabel.textAlignment          = NSTextAlignmentLeft;
//        contentLabel.font                   = [UIFont boldSystemFontOfSize:20];
//        contentLabel.textColor              = [UIColor whiteColor];
//        contentLabel.userInteractionEnabled = YES;
//        [chattingWindow addSubview:contentLabel];
//        
//        
//    }
//    return chattingWindow;
//}

- (NSTimer *)closeTimmer
{
    if (_closeTimmer == nil) {
        _closeTimmer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(afterSomeTimeHideVideoView) userInfo:nil repeats:NO];
        [[NSRunLoop  currentRunLoop] addTimer:_closeTimmer forMode:NSDefaultRunLoopMode];
    }
    return _closeTimmer;
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
