//
//  VideoRequestController.m
//  SeedGirl
//
//  Created by Admin on 15/10/14.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoRequestController.h"
#import "VideoRequestInfoController.h"

@interface VideoRequestController ()
@end

@implementation VideoRequestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setTitle:@"视频请求"];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    //加载子视图
    [self loadSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.videoRequestView firstLoad];
}

//加载子视图
- (void)loadSubviews {
    //self.tableView = self.videoRequestView;
    
    [self.view addSubview:self.videoRequestView];

    WeakSelf;
    _videoRequestView.selectedblock = ^(VideoRequestData *data){
        VideoRequestInfoController *viewController = [[VideoRequestInfoController alloc] init];
        viewController.requestData = data;
        viewController.returnBlcok = ^(){
            [weakSelf.videoRequestView reloadData];
        };
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    };
}

#pragma mark - lazyload
- (VideoRequestView *)videoRequestView {
    if (_videoRequestView == nil) {
        CGFloat y = StatusBarHeight + NavigationBarHeight;
        CGRect rect = CGRectMake(0, y, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-y);
        _videoRequestView = [[VideoRequestView alloc] initWithFrame:rect];
        _videoRequestView.backgroundColor = RGB(240, 242, 245);
    }
    return _videoRequestView;
}

@end
