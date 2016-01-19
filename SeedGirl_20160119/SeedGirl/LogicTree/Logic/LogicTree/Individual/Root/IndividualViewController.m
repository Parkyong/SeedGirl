//
//  IndividualViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/17.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "IndividualViewController.h"
#import "NavigationSegmentedBar.h"
#import "PushNotificationManager.h"

#import "IndividualView.h"
#import "RecordInfoViewController.h"
#import "VideoManagementController.h"
#import "VideoRequestController.h"

#import "RecordData.h"
#import "VideoSummaryData.h"

@interface IndividualViewController () <UIScrollViewDelegate>

//个人试图
@property (nonatomic, strong) IndividualView *individualView;
//导航分段控制器
@property (strong, nonatomic) NavigationSegmentedBar *segmentedBar;

@end

@implementation IndividualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = AutoScrollViewInsetsFlag;
    //设置导航栏
    [self setNavigationBar];
    //加载子视图
    [self loadSubviews];
    
    self.individualView.parentsController = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //更新个人数据
    [self.individualView updateIndividualData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //添加观察
    [self addObserver];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //移除观察
    [self removeObserver];
}

//设置导航栏
- (void)setNavigationBar{
    WeakSelf;
    self.segmentedBar.selectedBlock = ^(NSInteger index) {
        [weakSelf.individualView showSubViewAtIndex:index];
    };
    self.navigationItem.titleView = self.segmentedBar;
}

//加载子试图
- (void)loadSubviews {
    //加载滑动试图
    [self.view addSubview:self.individualView];
    
    WeakSelf;
    //设置导航栏分段控制器状态
    _individualView.scrollBlock = ^(NSInteger index) {
        //设置
        [weakSelf.segmentedBar setSelectedSegmentIndex:index];
    };

    //动态block
    _individualView.dynamicBlock = ^(RecordData *recordData) {
        RecordInfoViewController * recordInfoVC = [[RecordInfoViewController alloc] init];
        recordInfoVC.automaticallyAdjustsScrollViewInsets = AutoScrollViewInsetsFlag;
        recordInfoVC.recordData = recordData;
        [weakSelf.navigationController pushViewController:recordInfoVC animated:YES];
    };
    
    //视频block
    _individualView.videoBlock = ^(NSInteger index) {
        if (index == 0) {
            VideoManagementController *videoManagementVC = [[VideoManagementController alloc] init];
            [weakSelf.navigationController pushViewController:videoManagementVC animated:YES];
        } else if (index == 1) {
            VideoRequestController *videoRequestVC = [[VideoRequestController alloc] init];
            [weakSelf.navigationController pushViewController:videoRequestVC animated:YES];
        }
    };
    [self.individualView showSubViewAtIndex:self.segmentedBar.selectedSegmentIndex];
}

//添加观察
- (void)addObserver {
    //视频请求相关
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveVideoRequestMessage:) name:NewVideoRequestMessageNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRemoveVideoRequestMessage:) name:NoVideoRequestMessageNotification object:nil];
    
    if ([[PushNotificationManager manager] hasNewVideoRequestMessage]) {
        [self didReceiveVideoRequestMessage:nil];
    } else {
        [self didRemoveVideoRequestMessage:nil];
    }
}
//移除观察
- (void)removeObserver {
    //视频请求相关
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NewVideoRequestMessageNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NoVideoRequestMessageNotification object:nil];
}

#pragma mark - 视频请求
- (void)didReceiveVideoRequestMessage:(NSNotification *)notification {
    [self.segmentedBar showNewMessage:YES];
    [self.individualView showNewVideoRequestMessage:YES];
}
- (void)didRemoveVideoRequestMessage:(NSNotification *)notification {
    [self.segmentedBar showNewMessage:NO];
    [self.individualView showNewVideoRequestMessage:NO];
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
//滑动试图
- (IndividualView *)individualView {
    if (_individualView == nil) {
        CGFloat y = StatusBarHeight + NavigationBarHeight;
        CGRect sindividualViewRect = CGRectMake(0, BarHeigthYULEI, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-y-BottomTabBarHeight);
        _individualView = [[IndividualView alloc] initWithFrame:sindividualViewRect];
        _individualView.backgroundColor = [UIColor clearColor];
    }
    return _individualView;
}

@end
