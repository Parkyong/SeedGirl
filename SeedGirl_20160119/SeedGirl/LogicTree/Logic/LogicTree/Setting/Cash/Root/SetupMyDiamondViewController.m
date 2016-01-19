//
//  SetupMyDiamondViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupMyDiamondViewController.h"
#import "SetupMyDiamondView.h"
#import "BindBankCardVC.h"
#import "BankManager.h"
#import "BankRuleData.h"
#import "CashRecordVC.h"

typedef void (^RemoveBindBlockType)(BOOL isSuccess);

@interface SetupMyDiamondViewController () <UIAlertViewDelegate>
@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, strong) SetupMyDiamondView *rootView;
@property (nonatomic, copy)   RemoveBindBlockType removeBindBlock;
@end

@implementation SetupMyDiamondViewController

#pragma mark    viewWillAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rootView addObserver];
    [self settingViews];
}

#pragma mark    viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.rootView removeObserver];
}

#pragma mark    loadView
- (void)loadView{
    self.rootView = [[SetupMyDiamondView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view     = self.rootView;
}

#pragma mark    viewDidLoad
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setCustomNavigation];
    [self addFunction];
    if ([[UserManager manager] videoRequest_status]) {
        NSLog(@"yes");
    }
    if ([[UserManager manager] note_status]) {
        NSLog(@"yes");
    }
}

- (void)setCustomNavigation{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"记录" style:UIBarButtonItemStyleBordered target:self action:@selector(pushToRecordViewcontroller)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

#pragma mark    用数据设置页面
- (void)settingViews{
    WeakSelf;
    [self getBankInfomationWithResultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf.rootView refreshData];
        }
    }];
}

#pragma mark    添加功能
- (void)addFunction{
    WeakSelf;
    //绑定
    self.rootView.pushBlock = ^(BOOL isBind){
        if (isBind) {
            BindBankCardVC *bindBankVC = [[BindBankCardVC alloc] init];
            bindBankVC.title = @"绑定银行卡";
            [weakSelf.navigationController pushViewController:bindBankVC animated:YES];
        }else{
            [weakSelf presentViewController:weakSelf.alertController animated:YES completion:nil];
        }
    };
    
    //解除绑定
    self.removeBindBlock = ^(BOOL isSuccess){
        if (isSuccess){
            [weakSelf settingViews];
        }
    };
    
    //提现
    self.rootView.footerView.localBlock = ^(){
        [weakSelf.rootView endEditing:YES];
        if (weakSelf.rootView.tempMoneyContainer == 0) {
            [weakSelf.rootView endEditing:NO];
            return ;
        }
        [weakSelf fetchCashRequest:^(BOOL isFinish) {
            if (isFinish) {
                [weakSelf.rootView endEditing:NO];
                [weakSelf settingViews];
            }
        }];
    };
}

#pragma mark    获取银行规则信息
- (void)getBankInfomationWithResultBlock:(void (^)(BOOL isSuccess))result{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameters setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl]
                                        stringByAppendingString:@"user_my_diamond"] parameters:parameters  success:^(id responseObject) {
        APPLog(@"%@", responseObject);
        if (0 == userMyDiamond(responseObject)) {
            result(YES);
        }else{
            APPLog(@"评论失败");
            result(NO);
        }
    } failure:^(NSError *error) {
        result(NO);
        APPLog(@"%@", error);
    }];
}

#pragma mark    解除绑定
- (void)removeBankBind{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameters setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameters setValue:[NSNumber numberWithInt:1] forKey:@"type"];
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_bink_bank"] parameters:parameters success:^(id responseObject) {
        //拿到type后 判断是绑定还是解绑
        if (publishProtocol(responseObject) == 0) {
            APPLog(@"解除绑定成功");
            self.removeBindBlock(YES);
        }else{
            APPLog(@"解除绑定失败");
            self.removeBindBlock(NO);
        }
    } failure:^(NSError *error) {
        APPLog(@"解除绑定失败");
        self.removeBindBlock(NO);
    }];
}

#pragma mark    提现数据请求
- (void)fetchCashRequest:(void (^)(BOOL))isFinish{
    WeakSelf;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameters setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameters setValue:[NSNumber numberWithInteger:weakSelf.rootView.tempMoneyContainer] forKey:@"diamondCount"];
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl]
                                        stringByAppendingString:@"user_apply_cash"] parameters:parameters  success:^(id responseObject) {
        APPLog(@"%@", responseObject);
        if (publishProtocol(responseObject) == 0) {
            isFinish(YES);
        }else{
            APPLog(@"评论失败");
            isFinish(YES);
        }
    } failure:^(NSError *error) {
        APPLog(@"%@", error);
        isFinish(YES);
    }];
}

- (void)pushToRecordViewcontroller{
    CashRecordVC *recordVC = [[CashRecordVC alloc] init];
    recordVC.title = @"交易记录";
    [self.navigationController pushViewController:recordVC animated:YES];
}

#pragma mark    alertController
- (UIAlertController *)alertController{
    WeakSelf;
    if (_alertController == nil) {
        _alertController = [UIAlertController alertControllerWithTitle:nil message:@"是否解除绑定" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf removeBankBind];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [_alertController addAction:okAction];
        [_alertController addAction:cancelAction];
        }
    return _alertController;
}
@end