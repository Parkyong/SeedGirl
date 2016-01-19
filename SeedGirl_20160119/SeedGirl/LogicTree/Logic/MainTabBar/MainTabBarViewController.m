//
//  MainTabBarViewController.m
//  SeedGirl
//
//  Created by Admin on 15/11/18.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MainNavigationController.h"
#import "MainTabBarView.h"

#import "SquareViewController.h"
#import "IndividualViewController.h"
#import "TellStoryViewController.h"
#import "NoteViewController.h"
#import "SettingViewController.h"

#import "LoginViewController.h"
#import "PushNotificationManager.h"

@interface MainTabBarViewController () <EMChatManagerDelegate> {
    CGRect TabBarViewRect;
}

//内容视图
@property (nonatomic, strong) UIView *contentView;
//底视图
@property (nonatomic, strong) MainTabBarView *tabBarView;

//视图列表
@property (nonatomic, strong) NSArray *viewControllers;
//当前索引
@property (nonatomic, assign) NSInteger selectedIndex;
//当前视图
@property (nonatomic, strong) UIViewController *currentVC;
//最后一次点击索引
@property (nonatomic, assign) NSInteger lastClickIndex;

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //加载子视图
    [self loadSubviews];
    //加载子控制器
    [self loadSubcontrollers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //用户登录注册是否成功，成功后跳转
    [self isUserLoginRegisterSuccess];
    //添加观察
    [self addObserver];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //移除观察
    [self removeObserver];
}

//加载子视图
- (void)loadSubviews {
    [self.view addSubview:self.contentView];
    
    TabBarViewRect = CGRectMake(0, CGRectGetHeight(self.view.bounds)-MainTabBarHeight, CGRectGetWidth(self.view.bounds), MainTabBarHeight);
    [self.view addSubview:self.tabBarView];
    
    //self.tabBarView.hidden = YES;
    WeakSelf;
    self.tabBarView.selectedBlock = ^(NSInteger index){
        weakSelf.selectedIndex = index;
    };
}

//加载子控制器
- (void)loadSubcontrollers {
    //广场
    SquareViewController *squareVC = [[SquareViewController alloc] init];
    MainNavigationController *squareNC = [[MainNavigationController alloc] initWithRootViewController:squareVC];
    squareNC.tabBarVC = self;
    
    //个人
    IndividualViewController *individualVC = [[IndividualViewController alloc] init];
    MainNavigationController *individualNC = [[MainNavigationController alloc] initWithRootViewController:individualVC];
    individualNC.tabBarVC = self;
    
    //发布
    TellStoryViewController *issueVC = [[TellStoryViewController alloc] init];
    MainNavigationController *issueNC = [[MainNavigationController alloc] initWithRootViewController:issueVC];
    issueNC.tabBarVC = self;
    
    //纸条
    NoteViewController *noteVC = [[NoteViewController alloc] init];
    MainNavigationController *noteNC = [[MainNavigationController alloc] initWithRootViewController:noteVC];
    noteNC.tabBarVC = self;
    
    //设置
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    MainNavigationController *settingNC = [[MainNavigationController alloc] initWithRootViewController:settingVC];
    settingNC.tabBarVC = self;
    
    //控制器数组
    self.viewControllers = [NSArray arrayWithObjects:squareNC, individualNC, issueNC, noteNC, settingNC, nil];
    
    self.selectedIndex = 0;
    self.lastClickIndex = 0;
    [self.tabBarView setDefaultSelectedIndex:self.selectedIndex];
    
    [self addChildViewController:squareNC];
    [self.contentView addSubview:squareNC.view];
    self.currentVC = squareNC;
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

    //字条相关
    //注册为SDK的ChatManager的delegate
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNoteMessage:) name:NewNoteMessageNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNoteMessage:) name:NoNoteMessageNotification object:nil];
    
    //判断字条小红点
    if ([[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase] == 0) {
        [self.tabBarView showNewNoteMessage:NO];
    }else{
        [self.tabBarView showNewNoteMessage:YES];
    }
}
//移除观察
- (void)removeObserver {
    //视频请求相关
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NewVideoRequestMessageNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NoVideoRequestMessageNotification object:nil];
    
    //纸条相关
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NewNoteMessageNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NoNoteMessageNotification object:nil];
}

#pragma mark - 视频请求
- (void)didReceiveVideoRequestMessage:(NSNotification *)notification {
    [self.tabBarView showNewVideoRequestMessage:YES];
}
- (void)didRemoveVideoRequestMessage:(NSNotification *)notification {
    [self.tabBarView showNewVideoRequestMessage:NO];
}

#pragma mark - Ease设置
- (void)didReceiveMessage:(EMMessage *)message {
    [[PushNotificationManager manager] addIconBadgeNumber];
    [self.tabBarView showNewNoteMessage:YES];
}
- (void)didReceiveOfflineMessages:(NSArray *)offlineMessages {
    [[PushNotificationManager manager] addIconBadgeNumber];
    [self.tabBarView showNewNoteMessage:YES];
}

#pragma mark - 纸条
- (void)didReceiveNoteMessage:(NSNotification *)notification{
    if ([notification.name isEqualToString:NewNoteMessageNotification]) {
        [self.tabBarView showNewNoteMessage:YES];
    }else if([notification.name isEqualToString:NoNoteMessageNotification]){
        [self.tabBarView showNewNoteMessage:NO];
    }
}

#pragma mark - Main
//是否动画隐藏标签栏
- (void)tabBarHiddenStatus:(BOOL)hidden Animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            if (hidden) {
                CGRect rect = TabBarViewRect;
                rect.origin.y = CGRectGetHeight(self.view.bounds);
                [self.tabBarView setFrame:rect];
            } else {
                [self.tabBarView setFrame:TabBarViewRect];
            }
        }];
    } else {
        if (hidden) {
            CGRect rect = TabBarViewRect;
            rect.origin.y = CGRectGetHeight(self.view.bounds);
            [self.tabBarView setFrame:rect];
        } else {
            [self.tabBarView setFrame:TabBarViewRect];
        }
    }
}

//跳转广场视图
- (void)showSquareController {
    [self setSelectedIndex:0];
}
//跳转个人视图
- (void)showIndividualController {
    [self setSelectedIndex:1];
}
//跳转发布视图
- (void)showIssueController {
    [self setSelectedIndex:2];
}

//设置选择索引
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    self.lastClickIndex = selectedIndex;
    if (_selectedIndex == selectedIndex) {
        return ;
    }
    
    if (selectedIndex > 0) {
        if (![[UserManager manager] isLogined]) {
            [self userLogin];
            return ;
        }
    }
    
    UIViewController *toVC = [self.viewControllers objectAtIndex:selectedIndex];
    if (toVC && _currentVC != toVC) {
        _selectedIndex = selectedIndex;
        [_tabBarView setSelectedIndex:selectedIndex];
        [self transitionFromViewController:_currentVC toViewController:toVC];
    }
}
//视图转换
- (void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController {
    [self addChildViewController:toViewController];
    [self.contentView addSubview:toViewController.view];
    [toViewController didMoveToParentViewController:self];
    
    [fromViewController willMoveToParentViewController:nil];
    [fromViewController.view removeFromSuperview];
    [fromViewController removeFromParentViewController];
    _currentVC = toViewController;
}
//显示信息
- (void)showMessage:(NSString *)message{
    OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:self.view animated:YES];
    [progressHUD showText:message];
    [progressHUD hide:YES afterDelay:2];
}

#pragma mark - UIView Segue
//用户登录
- (void)userLogin {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:navigationVC animated:YES completion:nil];
}
//用户登录注册是否成功，成功后跳转
- (void)isUserLoginRegisterSuccess {
    if (self.lastClickIndex != self.selectedIndex) {
        if ([[UserManager manager] isRegisted] == YES) {
            [UserManager manager].isRegisted = NO;
            self.lastClickIndex = 4;
            [self setSelectedIndex:self.lastClickIndex];
        } else if ([[UserManager manager] isLogined] == YES) {
            [self setSelectedIndex:self.lastClickIndex];
        }
    }
}

#pragma mark - lazyload
//底部视图
- (MainTabBarView *)tabBarView {
    if (_tabBarView == nil) {
        _tabBarView = [[MainTabBarView alloc] initWithFrame:TabBarViewRect];
        _tabBarView.backgroundColor = [UIColor clearColor];
    }
    return _tabBarView;
}
- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

@end
