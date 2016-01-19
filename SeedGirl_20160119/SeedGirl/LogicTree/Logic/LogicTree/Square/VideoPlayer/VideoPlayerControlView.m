//
//  VideoPlayerControlView.m
//  SeedGirl
//
//  Created by Admin on 15/12/14.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoPlayerControlView.h"

@interface VideoPlayerControlView ()

//点击事件
@property (nonatomic, strong) UITapGestureRecognizer *tapGR;
//关闭按钮
@property (nonatomic, strong) UIButton *b_close;
//播放按钮
@property (nonatomic, strong) UIButton *b_play;
//聊天按钮
@property (nonatomic, strong) UIButton *b_chat;

//时间区域
@property (nonatomic, strong) UIView *timeView;
//起始时间
@property (nonatomic, strong) UILabel *l_startTime;
//结束时间
@property (nonatomic, strong) UILabel *l_endTime;
//进度条
@property (nonatomic, strong) UISlider *timeSlider;

@end

@implementation VideoPlayerControlView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:self.tapGR];
    
    [self addSubview:self.b_close];
    [self addSubview:self.b_play];
    [self addSubview:self.b_chat];
    
    [self addSubview:self.timeView];
    [self.timeView addSubview:self.timeSlider];
    [self.timeView addSubview:self.l_startTime];
    [self.timeView addSubview:self.l_endTime];
    
    [self addConstraints];
}

//添加约束
- (void)addConstraints {
    WeakSelf;
    //关闭按钮
    [self.b_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(14.0f);
        make.left.equalTo(weakSelf).with.offset(9.0f);
        make.size.mas_equalTo(CGSizeMake(44.0f, 44.0f));
    }];

    //播放按钮
    [self.b_play mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(44.0f, 44.0f));
    }];
    
    //聊天按钮
    [self.b_chat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(50.0f);
        make.bottom.equalTo(weakSelf).with.offset(-60.0f);
        make.right.equalTo(weakSelf).with.offset(-50.0f);
        make.height.mas_equalTo(80.0f);
    }];
    
    //时间区域
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).with.offset(-15.0f);
        make.height.mas_equalTo(22.0f);
    }];
    
    //进度条
    [self.timeSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(weakSelf.timeView);
        make.centerX.equalTo(weakSelf.timeView.mas_centerX);
        make.width.equalTo(weakSelf.timeView).multipliedBy(0.55f);
    }];
    
    //起始时间
    [self.l_startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.equalTo(weakSelf.timeView);
        make.right.equalTo(weakSelf.timeSlider.mas_left).with.offset(-5.0f);
    }];
    
    //结束时间
    [self.l_endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.right.equalTo(weakSelf.timeView);
        make.left.equalTo(weakSelf.timeSlider.mas_right).with.offset(5.0f);
    }];
}

#pragma mark - Main

//设置显示状态，0 准备播放，1 播放，2 暂停，3 结束
- (void)setControlState:(NSInteger)state {
    NSLog(@"state is %ld",(long)state);
    switch (state) {
        case 0:
        case 2:
            [self.b_close setHidden:NO];
            [self.b_play setHidden:NO];
            [self.b_chat setHidden:YES];
//            [self.timeView setHidden:NO];
            break;
        case 1:
            [self.b_close setHidden:YES];
            [self.b_play setHidden:YES];
            [self.b_chat setHidden:YES];
//            [self.timeView setHidden:NO];
            break;
        case 3:
            [self.b_close setHidden:NO];
            [self.b_play setHidden:NO];
            [self.b_chat setHidden:NO];
//            [self.timeView setHidden:YES];
            break;
        default:
            break;
    }
}

//设置视频总时间
- (void)setVideoTotalTime:(CGFloat)time {
    self.timeSlider.maximumValue = time;
    NSLog(@"total duration is %f, maximumValue is %f ",time,self.timeSlider.maximumValue);
    NSInteger minute = 0;
    NSInteger second = 0;
    
    if (time > 60) {
        minute = (NSInteger)time/60;
        second = (NSInteger)time%60;
    } else {
        second = (NSInteger)time;
    }
    
    [self.l_endTime setText:[NSString stringWithFormat:@"%02ld:%02ld",(long)minute,(long)second]];
}

//设置视频当前时间
- (void)setVideoCurrentTime:(CGFloat)time {
    self.timeSlider.value = time;
    NSLog(@"current duration is %f, slider value is %f",time,self.timeSlider.value);
}

#pragma mark - UIResponse Event

//关闭按钮点击事件
- (void)closeButtonClick:(id)sender {
    if (self.closeBlock) {
        self.closeBlock();
    }
}

//播放按钮点击事件
- (void)playButtonClick:(id)sender {
    [self setControlState:1];
    
    if (self.playBlock) {
        self.playBlock();
    }
}

//暂停按钮点击事件
- (void)pauseButtonClick:(id)sender {
    [self setControlState:2];
    
    if (self.pauseBlock) {
        self.pauseBlock();
    }
}

//点击事件
- (void)clickHandle:(UITapGestureRecognizer *)sender {
    BOOL hidden = self.b_play.hidden;
    if (hidden) {
        [self pauseButtonClick:nil];
    }
}

//聊天按钮点击事件
- (void)chatButtonClick:(id)sender {
    if (self.chatBlock) {
        self.chatBlock();
    }
}

//进度条控制
- (void)sliderValueChangeHandle:(UISlider *)slider {
    if (self.sliderBlock) {
        self.sliderBlock(slider.value);
    }
}

#pragma makr - lazyload

//点击事件
- (UITapGestureRecognizer *)tapGR {
    if (_tapGR == nil) {
        _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHandle:)];
    }
    return _tapGR;
}

//关闭按钮
- (UIButton *)b_close {
    if (_b_close == nil) {
        _b_close = [[UIButton alloc] init];
        _b_close.backgroundColor = [UIColor clearColor];
        [_b_close setImage:[UIImage imageWithContentOfFile:@"video_close.png"] forState:UIControlStateNormal];
        [_b_close setImage:[UIImage imageWithContentOfFile:@"video_close_down.png"] forState:UIControlStateHighlighted];
        [_b_close addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _b_close;
}

//播放按钮
- (UIButton *)b_play {
    if (_b_play == nil) {
        _b_play = [[UIButton alloc] init];
        _b_play.backgroundColor = [UIColor clearColor];
        [_b_play setImage:[UIImage imageWithContentOfFile:@"video_play.png"] forState:UIControlStateNormal];
        [_b_play setImage:[UIImage imageWithContentOfFile:@"video_play_down.png"] forState:UIControlStateHighlighted];
        [_b_play addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _b_play;
}

//聊天按钮
- (UIButton *)b_chat {
    if (_b_chat == nil) {
        _b_chat = [[UIButton alloc] init];
        _b_chat.backgroundColor = [UIColor clearColor];
        
        UIImage *chatImage = [UIImage imageWithContentOfFile:@"video_chat.png"];
        [_b_chat setBackgroundImage:[chatImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 75.0f, 0, 10) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        [_b_chat setTitle:@"和她聊聊天" forState:UIControlStateNormal];
        [_b_chat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _b_chat.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _b_chat.titleEdgeInsets = UIEdgeInsetsMake(0, 75.0f, 0, 10.0f);
        [_b_chat addTarget:self action:@selector(chatButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _b_chat;
}

//时间区域
- (UIView *)timeView {
    if (_timeView == nil) {
        _timeView = [[UIView alloc] init];
        _timeView.backgroundColor = [UIColor clearColor];
        _timeView.userInteractionEnabled = YES;
    }
    return _timeView;
}

//起始时间
- (UILabel *)l_startTime {
    if (_l_startTime == nil) {
        _l_startTime = [[UILabel alloc] init];
        _l_startTime.backgroundColor = [UIColor clearColor];
        _l_startTime.textAlignment = NSTextAlignmentRight;
        _l_startTime.font = [UIFont systemFontOfSize:14.0f];
        _l_startTime.textColor = [UIColor whiteColor];
        _l_startTime.text = @"00:00";
    }
    return _l_startTime;
}

//结束时间
- (UILabel *)l_endTime {
    if (_l_endTime == nil) {
        _l_endTime = [[UILabel alloc] init];
        _l_endTime.backgroundColor = [UIColor clearColor];
        _l_endTime.textAlignment = NSTextAlignmentLeft;
        _l_endTime.font = [UIFont systemFontOfSize:14.0f];
        _l_endTime.textColor = [UIColor whiteColor];
        _l_endTime.text = @"00:00";
    }
    return _l_endTime;
}

//进度条
- (UISlider *)timeSlider {
    if (_timeSlider == nil) {
        _timeSlider = [[UISlider alloc] init];
        _timeSlider.backgroundColor = [UIColor clearColor];
        _timeSlider.minimumValue = 0;
        _timeSlider.maximumValue = 0;
        _timeSlider.minimumTrackTintColor = [UIColor whiteColor];
        _timeSlider.maximumTrackTintColor = RGB(46, 46, 46);
        _timeSlider.continuous = NO;
        [_timeSlider addTarget:self action:@selector(sliderValueChangeHandle:) forControlEvents:UIControlEventValueChanged];
    }
    return _timeSlider;
}

@end
