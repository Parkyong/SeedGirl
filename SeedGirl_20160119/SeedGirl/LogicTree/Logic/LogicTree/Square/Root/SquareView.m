//
//  SquareView.m
//  SeedGirl
//
//  Created by Admin on 15/10/29.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "SquareView.h"
#import "SquareDynamicView.h"
#import "OwnTipView.h"
#import "SquareVideoView.h"
#import "SquareVideoViewLayout.h"

@interface SquareView () <UIScrollViewDelegate>
//当前视图索引
@property (nonatomic, assign) NSInteger selectedIndex;
//动态视图
@property (nonatomic, strong) SquareDynamicView *dynamicView;
//是否显示视频列表
@property (nonatomic, assign) BOOL isShowVideoView;
//视频提示视图
@property (nonatomic, strong) OwnTipView *tipView;
//视频视图
@property (nonatomic, strong) SquareVideoViewLayout *layout;
@property (nonatomic, strong) SquareVideoView *videoView;
@end

@implementation SquareView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //属性布局
        [self attributeLayout];
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//属性布局
- (void)attributeLayout {
    self.scrollsToTop = NO;
    self.scrollEnabled = YES;
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.contentSize = CGSizeMake(CGRectGetWidth(self.bounds)*2, 0);
    self.delegate = self;
    
    self.isShowVideoView = NO;
    self.selectedIndex = 0;
}

//加载子视图
- (void)loadSubviews {
    [self addSubview:self.dynamicView];
    [self addSubview:self.tipView];
}

#pragma mark - Main
//显示指定视图
- (void)showSubViewAtIndex:(NSInteger)_index {
    [self showSubViewAtIndex:_index animated:YES];
}
- (void)showSubViewAtIndex:(NSInteger)_index animated:(BOOL)animated {
    if (self.selectedIndex != _index) {
        self.selectedIndex = _index;
        [self setContentOffset:CGPointMake(CGRectGetWidth(self.bounds)*_index, self.contentOffset.y) animated:animated];
        [self firstLoadWithIndex:self.selectedIndex];
    }
}
//更新动态及视频数据
- (void)updateSquareData {
    //更新视频视图
    [self updateVideoView];
    [self firstLoadWithIndex:self.selectedIndex];
}
//更新视频视图
- (void)updateVideoView {
    if (self.isShowVideoView) {
        return ;
    }
    if (![[UserManager manager] isLogined]) {
        [self.tipView setTipText:@"您还未登录"];
        return;
    }
//    [UserManager manager].videoValidatedStatus = YES;
    if (![[UserManager manager] videoValidatedStatus]) {
        [self.tipView setTipText:@"您还未通过验证，无法查看视频广场\n请在个人—视频中上传制式视频完成验证"];
        return;
    }         
    
    self.isShowVideoView = YES;
    
    [self.tipView removeFromSuperview];
    self.tipView = nil;
    
    [self addSubview:self.videoView];
}
//首次加载
- (void)firstLoadWithIndex:(NSInteger)_index {
    switch (_index) {
        case 0:
            self.dynamicView.scrollsToTop = YES;
            [self.dynamicView firstLoad];
            
            if (self.isShowVideoView) {
                self.videoView.scrollsToTop = NO;
            }
            break;
        case 1:
            self.dynamicView.scrollsToTop = NO;
            
            if (self.isShowVideoView) {
                self.videoView.scrollsToTop = YES;
                [self.videoView firstLoad];
            break;
        }
    }
}

#pragma mark    Block setter
- (void)setDynamicBlock:(DynamicBlock)dynamicBlock{
    if (dynamicBlock != nil) {
        self.dynamicView.selectedBlock = [dynamicBlock copy];
    }
}
- (void)setVideoBlock:(VideoBlock)videoBlock{
    if (videoBlock != nil) {
        self.videoView.selectedBlock = [videoBlock copy];
    }
}

#pragma mark - UIScrollView Delegate
//滑动停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame);
    self.selectedIndex = currentPage;
    [self firstLoadWithIndex:currentPage];
    
    if (self.scrollBlock) {
        self.scrollBlock(currentPage);
    }
}

#pragma mark - lazyload
//动态视图
- (SquareDynamicView *)dynamicView {
    if (_dynamicView == nil) {
        _dynamicView = [[SquareDynamicView alloc] initWithFrame:self.bounds];
        _dynamicView.backgroundColor = [UIColor clearColor];
    }
    return _dynamicView;
}
//提示视图
- (OwnTipView *)tipView {
    if (_tipView == nil) {
        _tipView = [[OwnTipView alloc] initWithFrame:self.bounds];
        [_tipView setX:CGRectGetWidth(self.bounds)];
    }
    return _tipView;
}
//视频视图
- (SquareVideoViewLayout *)layout {
    if (_layout == nil) {
        _layout = [[SquareVideoViewLayout alloc] init];
    }
    return _layout;
}
- (SquareVideoView *)videoView {
    if (_videoView == nil) {
        _videoView = [[SquareVideoView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        [_videoView setX:CGRectGetWidth(self.bounds)];
        _videoView.backgroundColor = [UIColor clearColor];
    }
    return _videoView;
}

@end
