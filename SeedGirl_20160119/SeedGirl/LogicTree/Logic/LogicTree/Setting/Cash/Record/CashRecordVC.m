//
//  RecordViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/26.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "CashRecordVC.h"
#import "CashRecordView.h"

@interface CashRecordVC ()
//客服按钮
@property (nonatomic, strong) UIButton *b_server;
//根视图
@property (nonatomic, strong) CashRecordView *cashRecordView;
@end

@implementation CashRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏
    [self setRightNavigationBar];
    //加载子视图
    [self loadSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.cashRecordView firstLoad];
}

#pragma mark - Main
//设置导航栏
- (void)setRightNavigationBar {
    [self setTitle:@"提现记录"];
    //客服
    UIBarButtonItem *serverItem = [[UIBarButtonItem alloc] initWithCustomView:self.b_server];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    spaceItem.width -= 15;
    self.navigationItem.rightBarButtonItems = @[spaceItem,serverItem];
}

//加载子试图
- (void)loadSubviews {
    self.tableView = self.cashRecordView;
}

#pragma mark - UIResponse Event
//客服按钮点击事件
- (void)serverButtonClick:(id)sender {
    
}

#pragma mark - lazyload
//客服按钮
- (UIButton *)b_server {
    if (_b_server == nil) {
        _b_server = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
        _b_server.backgroundColor = [UIColor clearColor];
        [_b_server setTitle:@"客服" forState:UIControlStateNormal];
        [_b_server setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _b_server.adjustsImageWhenHighlighted = NO;
        [_b_server addTarget:self action:@selector(serverButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _b_server;
}
//根视图
- (CashRecordView *)cashRecordView {
    if (_cashRecordView == nil) {
        _cashRecordView = [[CashRecordView alloc] initWithFrame:self.view.bounds];
        _cashRecordView.backgroundColor = RGB(240, 242, 245);
    }
    return _cashRecordView;
}

@end
