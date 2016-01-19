//
//  LoginViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/9.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegisterViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) LoginView *loginView;
@end

@implementation LoginViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setTitle:@"登录"];
    //加载子视图
    [self loadSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.loginView firstLoad];
}

//加载子视图
- (void)loadSubviews {
    [self.view addSubview:self.loginView];
    
    WeakSelf;
    //登录block
    self.loginView.loginSuccessBlock = ^(){
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    };
    //注册block
    self.loginView.registerBlock = ^(){
        RegisterViewController *registerVC = [[RegisterViewController alloc] init];
        registerVC.title = @"注册";
        registerVC.contentType = 0;
        [weakSelf.navigationController pushViewController:registerVC animated:YES];
    };
    //忘记密码
    self.loginView.resetPasswordBlock = ^(){
        RegisterViewController *registerVC = [[RegisterViewController alloc] init];
        registerVC.title = @"找回密码";
        registerVC.contentType = 1;
        [weakSelf.navigationController pushViewController:registerVC animated:YES];
    };
}

#pragma mark - Main
//返回
- (void)popCurrentPageAction {
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - lazyload
- (LoginView *)loginView {
    if (_loginView == nil) {
        _loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
    }
    return _loginView;
}

@end
