//
//  ProgressBar.m
//  RecordingTest
//
//  Created by ParkHunter on 15/8/14.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "ProgressBar.h"
#import "ResizeTool.h"

#define BAR_MARGIN          [Adaptor returnAdaptorValue:2]
#define BAR_H               [Adaptor returnAdaptorValue:6]
#define INDICATOR_W         [Adaptor returnAdaptorValue:9]
#define INDICATOR_H         [Adaptor returnAdaptorValue:8]
#define BAR_BG_COLOR        RGBA(38, 38, 38, 1)
#define BG_COLOR            RGBA(11, 11, 11, 1)
#define BAR_BLUE_COLOR      RGBA(68, 214, 254, 1)
#define BAR_RED_COLOR       RGBA(255, 32, 107, 1)
#define TIMER_INTERVAL      1.0f
#define ANIMATION_DURATION  1.0f

@interface ProgressBar ()
@property (nonatomic, strong) UIView               *contentView;      //里面心部分view
@property (nonatomic, strong) UIImageView            *indicator;      //指示器
@property (nonatomic, strong) NSMutableArray *progressContainer;      //装分段progress的容器
@property (nonatomic, strong) NSTimer             *shiningTimer;      //指示器
@end
@implementation ProgressBar
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = BG_COLOR;
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self initializeParameter];
    [self addViews];
}

#pragma mark    初始化参数
- (void)initializeParameter{
    self.progressContainer = [NSMutableArray array];
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.contentView];
    [self addSubview:self.indicator];
}

#pragma mark    -
#pragma mark    设置frame
#pragma mark    设置最后分段片的长度
- (void)setLastProgressToWidth:(CGFloat)width{
    UIView *lastProgressView = [self.progressContainer lastObject];
    if (!lastProgressView) {
        return;
    }
    
    [ResizeTool setView:lastProgressView toSizeWidth:width];
    [self refreshIndicatorPosition];
}

#pragma mark    设置最后分段片的状态
- (void)setLastProgressToStyle:(ProgressBarProgressStyle)style{
    UIView *lastProgressView = [self.progressContainer lastObject];
    if (!lastProgressView) {
        return;
    }
    switch (style) {
        case ProgressBarProgressStyleDelete:
        {
            lastProgressView.backgroundColor = BAR_RED_COLOR;
            self.indicator.hidden = YES;
        }
            break;
        case ProgressBarProgressStyleNormal:
        {
            lastProgressView.backgroundColor = BAR_BLUE_COLOR;
            self.indicator.hidden = NO;
        }
            break;
        default:
            break;
    }
}

#pragma mark    从新设置指示器位置
- (void)refreshIndicatorPosition{
    UIView *lastProgressView = [self.progressContainer lastObject];
    if (!lastProgressView) {
        self.indicator.center = CGPointMake(0, self.frame.size.height / 2-(BAR_MARGIN/2));
        return;
    }
    
    self.indicator.center = CGPointMake(MIN(lastProgressView.frame.origin.x + lastProgressView.frame.size.width,
                                            self.frame.size.width - self.indicator.frame.size.width / 2 + 2),
                                        self.frame.size.height / 2-(BAR_MARGIN/2));
}

#pragma mark    添加progress分段片
- (void)addProgressView{
    UIView *lastProgressView = [self.progressContainer lastObject];
    CGFloat newProgressX     = 0.0f;
    
    if (lastProgressView) {
        CGRect frame = lastProgressView.frame;
        frame.size.width -= 1;
        lastProgressView.frame = frame;
        
        newProgressX = frame.origin.x + frame.size.width + 1;
    }
    
    UIView *newProgressView = [self getContentView];
    [ResizeTool setView:newProgressView toOriginX:newProgressX];
    
    [self.contentView addSubview:newProgressView];
    
    [self.progressContainer addObject:newProgressView];
}

#pragma mark    删除progress分段片
- (void)deleteLastProgress{
    UIView *lastProgressView = [self.progressContainer lastObject];
    if (!lastProgressView) {
        return;
    }
    
    [lastProgressView removeFromSuperview];
    [self.progressContainer removeLastObject];
    
    self.indicator.hidden = NO;
    [self refreshIndicatorPosition];
}

#pragma mark    -
#pragma mark    功能
#pragma mark    指示灯开启
- (void)startShining{
    self.shiningTimer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL
                                                         target:self selector:@selector(onTimer:)
                                                       userInfo:nil repeats:YES];
}

#pragma mark    指示灯关闭
- (void)stopShining{
    [self.shiningTimer invalidate];
    self.shiningTimer    = nil;
    self.indicator.alpha = 1;
}

#pragma mark    指示器动画
- (void)onTimer:(NSTimer *)timer{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        weakSelf.indicator.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        weakSelf.indicator.alpha = 1;
        }];
    }];
}

#pragma mark    -
#pragma mark    获取progress内部的分段试图
- (UIView *)getContentView{
    UIView *progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, BAR_H)];
    progressView.backgroundColor     = BAR_BLUE_COLOR;
    progressView.autoresizesSubviews = YES;
    return progressView;
}

#pragma mark    -
#pragma mark    懒加载对象
- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BAR_H)];
        _contentView.backgroundColor = BAR_BG_COLOR;
    }
    return _contentView;
}

#pragma mark    指示器
- (UIImageView *)indicator
{
    if (_indicator == nil) {
        _indicator = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, INDICATOR_W, INDICATOR_H)];
        _indicator.backgroundColor = [UIColor clearColor];
        _indicator.image = [UIImage imageNamed:@"record_progressbar_front.png.png"];
        _indicator.center = CGPointMake(0, self.frame.size.height / 2-(BAR_MARGIN/2));
    }
    return _indicator;
}

#pragma mark    获取实例
+ (ProgressBar *)getInstance{
    ProgressBar *progressBar = [[ProgressBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BAR_H + BAR_MARGIN)];
    return progressBar;
}
@end