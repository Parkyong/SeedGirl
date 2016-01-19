//
//  IndividualView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/19.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "IndividualView.h"
#import "IndividualDynamicView.h"
#import "IndividualVideoView.h"

@interface IndividualView () <UIScrollViewDelegate>
//当前视图索引
@property (nonatomic, assign) NSInteger selectedIndex;
//动态
@property (strong, nonatomic) IndividualDynamicView *dynamicView;
//视频
@property (strong, nonatomic) IndividualVideoView *videoView;

@end

@implementation IndividualView

- (instancetype)initWithFrame:(CGRect)frame{
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
    
    self.selectedIndex = 0;
}

//加载子视图
- (void)loadSubviews {
    [self addSubview:self.dynamicView];
    [self addSubview:self.videoView];
}

#pragma mark - Main
//显示
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
//更新广场数据
- (void)updateIndividualData {
    //强制更新动态列表
    if ([[CacheDataManager sharedInstance] isForcedUpdateIndividualDynamic]) {
        [CacheDataManager sharedInstance].isForcedUpdateIndividualDynamic = NO;
        [CacheDataManager sharedInstance].individualDynamicList = nil;
        
        if (self.scrollBlock) {
            self.scrollBlock(0);
        }
        [self showSubViewAtIndex:0 animated:NO];
        [self.dynamicView firstLoad];
    } else {
        [self firstLoadWithIndex:self.selectedIndex];
    }
}
//显示视频请求新消息提醒
- (void)showNewVideoRequestMessage:(BOOL)status {
    if (self.selectedIndex == 1) {
        [self.videoView showNewVideoRequestMessage:status];
    }
}
//首次加载
- (void)firstLoadWithIndex:(NSInteger)_index {
    switch (_index) {
        case 0:
            [self.dynamicView firstLoad];
            break;
        case 1:
            [self.videoView firstLoad];
            break;
    }
}

#pragma mark - Block setter
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
- (IndividualDynamicView *)dynamicView {
    if (_dynamicView == nil) {
        _dynamicView = [[IndividualDynamicView alloc] initWithFrame:self.bounds];
        _dynamicView.backgroundColor = [UIColor clearColor];
    }
    return _dynamicView;
}
//视频视图
- (IndividualVideoView *)videoView {
    if (_videoView == nil) {
        CGRect videoViewRect = CGRectMake(CGRectGetWidth(self.bounds)+8.0f, 0, CGRectGetWidth(self.bounds)-16.0f, CGRectGetHeight(self.bounds));
        _videoView = [[IndividualVideoView alloc] initWithFrame:videoViewRect];
        _videoView.backgroundColor = [UIColor clearColor];
    }
    return _videoView;
}

#pragma mark    设置view的controller
- (void)setParentsController:(UIViewController *)parentsController{
    _parentsController = parentsController;
    _videoView.parentsViewController = parentsController;
}
@end
