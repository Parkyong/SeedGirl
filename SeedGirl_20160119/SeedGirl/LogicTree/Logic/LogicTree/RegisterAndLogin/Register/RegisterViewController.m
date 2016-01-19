//
//  RegisterViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/8.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"
#import "ValidateTool.h"

@interface RegisterViewController ()
@property (nonatomic, strong) RegisterView *registerView;
@end

@implementation RegisterViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //加载子视图
    [self loadSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.registerView.contentType = self.contentType;
}

//加载子视图
- (void)loadSubviews {
    [self.view addSubview:self.registerView];
    
    WeakSelf;
    self.registerView.registerSuccessBlock = ^(){
        if (weakSelf.contentType == 0) {
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    };
}

#pragma mark - lazyload
- (RegisterView *)registerView {
    if (_registerView == nil) {
        _registerView = [[RegisterView alloc] initWithFrame:self.view.bounds];
    }
    return _registerView;
}

@end
