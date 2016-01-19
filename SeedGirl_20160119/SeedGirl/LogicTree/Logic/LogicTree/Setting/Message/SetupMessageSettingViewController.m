//
//  SetupMessageSettingViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupMessageSettingViewController.h"
#import "SetupMessageSettingView.h"
@interface SetupMessageSettingViewController ()
@property (nonatomic, strong) SetupMessageSettingView *rootView;
@end
@implementation SetupMessageSettingViewController
- (void)loadView{
    self.rootView = [[SetupMessageSettingView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.rootView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}
@end
