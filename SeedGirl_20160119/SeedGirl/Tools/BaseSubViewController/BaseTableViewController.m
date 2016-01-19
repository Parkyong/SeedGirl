//
//  BaseTableViewController.m
//  SeedGirl
//
//  Created by Admin on 15/10/16.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLeftNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLeftNavigationBar {
    //返回按钮
    UIImage *backImage = [UIImage imageWithContentOfFile:@"feedbackBack.png"];
    UIButton *button_back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button_back setImage:backImage forState:UIControlStateNormal];
    [button_back setAdjustsImageWhenHighlighted:NO];
    [button_back addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button_back];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    spaceItem.width -= 15;
    self.navigationItem.leftBarButtonItems = @[spaceItem, backItem];
}

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
