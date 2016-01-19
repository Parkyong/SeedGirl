//
//  DynamicViewController.m
//  SeedGirl
//
//  Created by Admin on 15/10/27.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SquareViewController.h"
#import "NavigationSegmentedBar.h"
#import "SquareView.h"
#import "RecordInfoViewController.h"
#import "VideoPlayerController.h"
#import "SeedPlayer.h"

#import "VideoData.h"
#import "MainTabBarViewController.h"

@interface SquareViewController ()

//导航分段控制器
@property (nonatomic, strong) NavigationSegmentedBar *segmentedBar;
//发布动态按钮
@property (nonatomic, strong) UIButton *button_issue;
//滑动试图
@property (nonatomic, strong) SquareView *squareView;

@end

@implementation SquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setAutomaticallyAdjustsScrollViewInsets:AutoScrollViewInsetsFlag];
    //设置导航栏
    [self setNavigationBar];
    //加载子视图
    [self loadSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //更新广场数据
    [self.squareView updateSquareData];
}

//设置导航栏
- (void)setNavigationBar{
    WeakSelf;
    self.segmentedBar.selectedBlock = ^(NSInteger index) {
        [weakSelf.squareView showSubViewAtIndex:index];
    };
    self.navigationItem.titleView = self.segmentedBar;
    
    //发布动态
    UIBarButtonItem *releasedItem = [[UIBarButtonItem alloc] initWithCustomView:self.button_issue];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    spaceItem.width -= 15;
    self.navigationItem.rightBarButtonItems = @[spaceItem,releasedItem];
}

//加载子视图
- (void)loadSubviews {
    //加载滑动试图
    [self.view addSubview:self.squareView];

    WeakSelf;
    //设置导航栏分段控制器状态
    _squareView.scrollBlock = ^(NSInteger index){
        [weakSelf.segmentedBar setSelectedSegmentIndex:index];
    };

    //动态block
    _squareView.dynamicBlock = ^(RecordData *recordData) {
        RecordInfoViewController *recordInfoVC = [[RecordInfoViewController alloc] init];
        recordInfoVC.recordData = recordData;
        recordInfoVC.automaticallyAdjustsScrollViewInsets = NO;
        [weakSelf.navigationController pushViewController:recordInfoVC animated:YES];
    };
    
    //视频block
    _squareView.videoBlock = ^(VideoData *videoData) {
//        VideoPlayerController *videoPlayerVC = [[VideoPlayerController alloc] init];
//        videoPlayerVC.videoData = videoData;
//        [weakSelf presentViewController:videoPlayerVC animated:YES completion:nil];
//        
        SeedPlayer *player = [[SeedPlayer alloc] init];
        player.movieUrl = videoData.videoURL;
        player.modalPresentationStyle = UIModalPresentationFullScreen;
        [weakSelf presentViewController:player animated:YES completion:nil];
    };
    
    [self.squareView showSubViewAtIndex:self.segmentedBar.selectedSegmentIndex];
}

#pragma mark - UIResponse Event
//发布按钮点击事件
- (void)issueButtonClick:(id)sender {
    UIViewController *vc = self.navigationController.parentViewController;
    if ([vc isKindOfClass:[MainTabBarViewController class]]) {
        [(MainTabBarViewController *)vc showIssueController];
    }
}

#pragma mark - lazyload
//导航分段控制器
- (NavigationSegmentedBar *)segmentedBar {
    if (_segmentedBar == nil) {
        CGRect segmentControlRect = CGRectMake(0, 0, ScreenWidth-110.0f, 27.0f);
        _segmentedBar = [[NavigationSegmentedBar alloc] initWithFrame:segmentControlRect
                                                                Items:@[NSLocalizedString(@"DongTai", nil),NSLocalizedString(@"ShiPin", nil)]];
    }
    return _segmentedBar;
}
//发布按钮
- (UIButton *)button_issue {
    if (_button_issue == nil) {
        _button_issue = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
        _button_issue.backgroundColor = [UIColor clearColor];
        [_button_issue setImage:[UIImage imageWithContentOfFile:@"square_issue.png"] forState:UIControlStateNormal];
        [_button_issue setAdjustsImageWhenHighlighted:NO];
        [_button_issue addTarget:self action:@selector(issueButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_issue;
}
//滑动试图
- (SquareView *)squareView {
    if (_squareView == nil) {
        CGFloat y = StatusBarHeight + NavigationBarHeight;
        CGRect squareViewRect = CGRectMake(0, BarHeigthYULEI, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-y-BottomTabBarHeight);
        //ppp
        _squareView = [[SquareView alloc] initWithFrame:squareViewRect];
        _squareView.backgroundColor = [UIColor clearColor];
    }
    return _squareView;
}

@end
