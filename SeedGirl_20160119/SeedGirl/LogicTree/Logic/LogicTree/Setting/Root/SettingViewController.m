//
//  SetupViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/17.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SettingViewController.h"
#import "SetupView.h"
#import "UINavigationBar+BackgroundColor.h"
#import "SetupFeedbackController.h"
#import "SetupMessageSettingViewController.h"
#import "SetupMyDiamondViewController.h"
#import "SetupLookFunsVC.h"
#import "SetupPersonalInfoViewController.h"
#import "LoginViewController.h"
#import "UserData.h"
#import "ExperienceAndLevelReferenceVC.h"
#import "MainTabBarViewController.h"

@interface SettingViewController ()

@property (nonatomic, strong) SetupView *rootView;

@end

@implementation SettingViewController

- (void)loadView{
    self.rootView = [[SetupView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view     = self.rootView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setTitle:@"设置"];
    [self addObserver];
    [self addFunction];
}

- (void)addFunction{
    WeakSelf;
    self.rootView.changePageBlock=^(NSInteger currentPage){
        if (![[UserManager manager] isLogined] &&
            currentPage != LOGINANDLOGOUTPAGE) {
            NSLog(@"请登录后，操作");
            return ;
        }
        
        switch (currentPage) {
            case SINGUPPAGE:
            {
                OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                [weakSelf userSignWithResultBlock:^(BOOL isSuccess) {
                    if (isSuccess) {
                        [progressHUD showText:@"签到成功"];
                        [progressHUD hide:YES];
                        [weakSelf.rootView.tableView reloadData];
                    }else{
                        [progressHUD showText:@"签到失败"];
                        [progressHUD hide:YES];
                    }

                }];
                break;
            }
            case LOOKFUNSPAGE:
            {
                SetupLookFunsVC *lookFunsVC = [[SetupLookFunsVC alloc] init];
                lookFunsVC.title = @"查看粉丝";
                [weakSelf.navigationController pushViewController:lookFunsVC animated:NO];
                break;
            }
            case MYDIAMONDPAGE:
            {
                SetupMyDiamondViewController *myDiamondVC = [[SetupMyDiamondViewController alloc] init];
                myDiamondVC.title = @"我的钻石";
                [weakSelf.navigationController pushViewController:myDiamondVC animated:NO];
                break;
            }
            case MESSAGESETTING:
            {
                SetupMessageSettingViewController *setupMessageSettingVC = [[SetupMessageSettingViewController alloc] init];
                setupMessageSettingVC.title = @"消息设置";
                [weakSelf.navigationController pushViewController:setupMessageSettingVC animated:NO];
                break;
            }
            case EXPERIENCEREFERENCEPAGE:{
                ExperienceAndLevelReferenceVC *expVC = [[ExperienceAndLevelReferenceVC alloc] init];
                expVC.title = @"经验等级说明";
                expVC.automaticallyAdjustsScrollViewInsets = NO;
                [weakSelf.navigationController pushViewController:expVC animated:NO];
                break;
            }
            case FEEDBACKPAGE:
            {
                SetupFeedbackController *feedbackController = [[SetupFeedbackController alloc] init];
                feedbackController.title = @"意见反馈";
                feedbackController.automaticallyAdjustsScrollViewInsets = AutoScrollViewInsetsFlag;
                [weakSelf.navigationController pushViewController:feedbackController animated:NO];
                break;
            }
            case PERSONALINFOPAGE:
            {
                SetupPersonalInfoViewController *personalInfoVC = [[SetupPersonalInfoViewController alloc] init];
                personalInfoVC.title = @"资料";
                personalInfoVC.automaticallyAdjustsScrollViewInsets = AutoScrollViewInsetsFlag;
                [weakSelf.navigationController pushViewController:personalInfoVC animated:NO];
                break;
            }
            case LOGINANDLOGOUTPAGE:
            {
//                [weakSelf.mainTabbar showTabbarAnimated:YES];
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                loginVC.title = @"登录";
                UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
                [weakSelf presentViewController:loginNC animated:YES completion:nil];
            }
        }
    };
    
    //退出block
    self.rootView.logoutBlock = ^(){
        UIViewController *vc = weakSelf.navigationController.parentViewController;
        if ([vc isKindOfClass:[MainTabBarViewController class]]) {
            [(MainTabBarViewController *)vc showSquareController];
        }
    };
}

#pragma mark    添加观察者
- (void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableViewAction:) name:kUserLogin object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableViewAction:) name:kUserInfoChange object:nil];
}

- (void)refreshTableViewAction:(NSNotification*)notification{
    [self.rootView.tableView reloadData];
    [self.rootView footerRefresh];
}

//
//#pragma mark    刷新setting 页面
//- (void)refreshTableViewAction:(NSNotification *)notification{
//    if ([notification.name isEqualToString:kUserDatafix]) {
//        [self networkDataRequest:^(BOOL isFinish) {
//            if (isFinish) {
//                [self.rootView.tableView reloadData];
//                [self.rootView footerRefresh];
//            }
//        }];
//    }else{
//        [self.rootView.tableView reloadData];
//        [self.rootView footerRefresh];
//    }
//}

- (void)userSignWithResultBlock:(void (^)(BOOL isSuccess))result{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameters setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_qiandao"]
                            parameters:parameters success:^(id responseObject) {
        APPLog(@"%@", responseObject);
        if (publishProtocol(responseObject) == 0) {
            [UserManager manager].isSign = YES;
            APPLog(@"设置成功");
            result(YES);
        }else{
            APPLog(@"设置失败");
            result(NO);
        }
    } failure:^(NSError *error) {
        APPLog(@"%@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
