//
//  BaseSubViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/25.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "BaseSubViewController.h"

@implementation BaseSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavigationBar {
    //返回按钮
    UIImage *backImage = [UIImage imageWithContentOfFile:@"feedbackBack.png"];
    UIButton *button_back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button_back setImage:backImage forState:UIControlStateNormal];
    [button_back setAdjustsImageWhenHighlighted:NO];
    [button_back addTarget:self action:@selector(popCurrentPageAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_back];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    spaceItem.width -= 15;
    self.navigationItem.leftBarButtonItems = @[spaceItem, backButtonItem];
}

#pragma mark    退出当前页面
- (void)popCurrentPageAction {
    [self.navigationController popViewControllerAnimated:YES];
}
@end