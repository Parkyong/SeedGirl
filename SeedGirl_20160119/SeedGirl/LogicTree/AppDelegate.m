//
//  AppDelegate.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/17.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>

#import "JPUSHService.h"
#import "UserData.h"
#import "PushNotificationManager.h"
#import "NetworkImageUploader.h"
#import "NetworkNotifier.h"
#import "oAuthManager.h"

@interface AppDelegate ()
//jpush连接成功
@property (nonatomic, assign) BOOL isJPushConnect;
@end

@implementation AppDelegate

#pragma mark - App Config
//应用初始化配置
- (void)AppGlobalSetting {
    UIImage *navigationbarImage = [UIImage imageWithColor:RGBA(232,93,119,0.85) Size:CGSizeMake(1.0f, 1.0f)];
    [[UINavigationBar appearance] setBackgroundImage:navigationbarImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:RGBA(255, 255, 255, 0.2) Size:CGSizeMake(ScreenWidth, 1.0f)]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
}
//应用其他配置
- (void)AppOtherSetting {
    if (SystemVersion >= 8.0) {
        UIUserNotificationType types = UIUserNotificationTypeBadge |
                                       UIUserNotificationTypeSound |
                                       UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType types = UIRemoteNotificationTypeBadge |
                                         UIRemoteNotificationTypeSound |
                                         UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
}

#pragma mark - Network Status
//网络状态配置
- (void)AppNetworkStatusSetting {
    //注册网络状态改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged:) name:NetworkNotifierNotification object:nil];
    //网络状态监听
    [[NetworkNotifier manager] startNotifier];
}
//网络状态改变
- (void)networkStatusChanged:(NSNotification *)notification {
    NSLog(@"notification is %@",notification);
    //没有网络
    if (![[NetworkNotifier manager] connectServerState]) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"当前网络无连接" preferredStyle:UIAlertControllerStyleAlert];
        //确定
        UIAlertAction *confimAction = [UIAlertAction actionWithTitle:@"确定"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [alertController addAction:confimAction];
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
#else
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"当前网络无连接" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
#endif
    }
}

#pragma mark - JPush Notification
//通知设置
- (void)setJPushConfigWithOptions:(NSDictionary *)launchOptions {
    if (SystemVersion >= 8.0) {
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    //apsForProduction正式版需要改为YES
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_KEY channel:JPUSH_CHANNEL apsForProduction:NO];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    //注册成功
    [notificationCenter addObserver:self selector:@selector(jpushConnectNotificationSuccess) name:kJPFNetworkDidSetupNotification object:nil];
    //设置别名
    [notificationCenter addObserver:self selector:@selector(jpushAlias) name:JPushAliasNotification object:nil];
}
//获取设备token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken is %@",deviceToken);
    [JPUSHService registerDeviceToken:deviceToken];
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
//注册失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}
//jpush注册成功
- (void)jpushConnectNotificationSuccess {
    NSLog(@"jpushConnectNotificationSuccess");
    self.isJPushConnect = YES;
}
//设置别名
- (void)jpushAlias {
    if (self.isJPushConnect) {
        NSString *alias = [NSString stringWithFormat:@"%@",[[UserManager manager] userID]];
        NSLog(@"alias is %@",alias);
        [JPUSHService setAlias:alias callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    }
}
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet *)tags alias:(NSString *)alias {
    if (iResCode == 0) {
        NSLog(@"jpush set alias %@ success",alias);
        return ;
    }
    NSLog(@"jpush set alias error cord is %ld",(long)iResCode);
}
//获取通知推送内容
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"通知推送内容 is %@",userInfo);
    [[PushNotificationManager manager] remoteNotificationMessage:userInfo];
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
//获取自定义推送内容
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"自定义推送内容 is %@",userInfo);
    [[PushNotificationManager manager] remoteNotificationMessage:userInfo];
    [JPUSHService handleRemoteNotification:userInfo];
}

#pragma mark - 环信设置
- (void)setEaseMob:(UIApplication *)application withOption:(NSDictionary *)launchOptions{
    //registerSDKWithAppKey:注册的appKey，详细见下面注释。
    //apnsCertName:推送证书名(不需要加后缀)，详细见下面注释。ooooo#magicseed
    // 注册环信推送
    [self setupHXNotifiers];
    EMError *error = [[EaseMob sharedInstance] registerSDKWithAppKey:@"ooooo#magicseed" apnsCertName:@"reedcatkins"];
    if (!error) {
        APPLog(@"EaseMob注册成功");
    }else{
        APPLog(@"EaseMob注册失败");
    }
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}
// 监听系统生命周期回调，以便将需要的事件传给SDK
- (void)setupHXNotifiers{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidEnterBackgroundNotif:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidFinishLaunching:)
                                                 name:UIApplicationDidFinishLaunchingNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidBecomeActiveNotif:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillResignActiveNotif:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidReceiveMemoryWarning:)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillTerminateNotif:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appProtectedDataWillBecomeUnavailableNotif:)
                                                 name:UIApplicationProtectedDataWillBecomeUnavailable
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appProtectedDataDidBecomeAvailableNotif:)
                                                 name:UIApplicationProtectedDataDidBecomeAvailable
                                               object:nil];
}

#pragma mark - notifiers
- (void)appDidEnterBackgroundNotif:(NSNotification*)notif{
    [[EaseMob sharedInstance] applicationDidEnterBackground:notif.object];
}

- (void)appWillEnterForeground:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationWillEnterForeground:notif.object];
}

- (void)appDidFinishLaunching:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationDidFinishLaunching:notif.object];
}

- (void)appDidBecomeActiveNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationDidBecomeActive:notif.object];
}

- (void)appWillResignActiveNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationWillResignActive:notif.object];
}

- (void)appDidReceiveMemoryWarning:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationDidReceiveMemoryWarning:notif.object];
}

- (void)appWillTerminateNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationWillTerminate:notif.object];
}

- (void)appProtectedDataWillBecomeUnavailableNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationProtectedDataWillBecomeUnavailable:notif.object];
}

- (void)appProtectedDataDidBecomeAvailableNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationProtectedDataDidBecomeAvailable:notif.object];
}

#pragma mark - 快捷登录
- (void)userQuickLogin {
//    if (![[NetworkNotifier manager] connectServerState]) {
//        NSLog(@"无网络");
//        return ;
//    }
    
    NSString *userID = [[UserManager manager] loginUserID];
    NSString *sessionToken = [[UserManager manager] loginSessionToken];
    if (userID == nil || sessionToken == nil) {
        return ;
    }

    [self net_userQuickLoginCompletion:^(BOOL isSuccess) {
        if (isSuccess) {
            //登录环信
            [self loginEasemobWithResultBlock:^(BOOL isSuccess) {
                if (isSuccess) {
                    //快捷登录成功
                    [UserManager manager].isLogined = YES;
                    [self userLoginSuccess];
                    
                    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
                    options.displayStyle = ePushNotificationDisplayStyle_messageSummary;
                    if ([[UserManager manager] note_status]) {
                        options.noDisturbStatus = ePushNotificationNoDisturbStatusClose;
                    }else{
                        options.noDisturbStatus = ePushNotificationNoDisturbStatusDay;
                    }
                    [[EaseMob sharedInstance].chatManager setApnsNickname:[[[UserManager manager] userData] userName]];
                    [[EaseMob sharedInstance].chatManager updatePushOptions:options error:nil];

                } else {
                    [UserManager manager].isLogined = NO;
                    [[UserManager manager] cleanUserData];
                }
            }];
        } else {
            //快捷登录失败
            [UserManager manager].isLogined = NO;
            [[UserManager manager] cleanUserLoginInfo];
        }
    }];
}
//快捷登录成功
- (void)userLoginSuccess {
    [[UserManager manager] saveUserLoginInfo];
    [UserManager manager].isLogined = YES;
//    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogin object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:JPushAliasNotification object:nil];
}

#pragma mark - Main
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //全局设置
    [self AppGlobalSetting];
    //应用其他配置
    [self AppOtherSetting];
    
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"TARGET_IPHONE_SIMULATOR");
#else
    //JPush通知
    [self setJPushConfigWithOptions:launchOptions];
#endif
    //环信注册
    [self setEaseMob:application withOption:launchOptions];
    //微信注册
    [WXApi registerApp:kWXAPP_ID];

    //用户快捷登录
    [self userQuickLogin];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:RGB(240, 242, 245)];
    
    MainTabBarViewController *rootController = [[MainTabBarViewController alloc] init];
    self.window.rootViewController = rootController;
    [self.window makeKeyAndVisible];

    //网络状态配置
    [self AppNetworkStatusSetting];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[PushNotificationManager manager] clearIconBadgeNumer];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [[PushNotificationManager manager] clearIconBadgeNumer];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Network Inferface
//快捷登录
- (void)net_userQuickLoginCompletion:(void(^)(BOOL isSuccess))completion {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[[UserManager manager] loginUserID] forKey:@"user_id"];
    [parameter setValue:[[UserManager manager] loginSessionToken] forKey:@"session_token"];

    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_shortcut_login"]
                            parameters:parameter
                               success:^(id responseObject) {
                                   if (userLoginProtocol(responseObject) == 0) {
                                       completion(YES);
                                   } else {
                                       completion(NO);
                                   }
                               } failure:^(NSError *error) {
                                   NSLog(@"user quick login error is %@",error.localizedDescription);
                                   completion(NO);
                               }];
}
//登录环信
- (void)loginEasemobWithResultBlock:(void(^)(BOOL isSuccess))result{
    NSString *userName  = [NSString stringWithFormat:@"%@", [[UserManager manager] userHxid]];
    NSString *password  = [NSString stringWithFormat:@"seed_%@", userName];
    
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[[UserManager manager] userHxid]
                                                        password:[password MD5Hash]
                                                      completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            APPLog(@"环信登录成功");
            result(YES);
        }else{
            if (error.errorCode == EMErrorServerTooManyOperations) {
                APPLog(@"环信登录成功");
                result(YES);
            }else{
                APPLog(@"环信登录失败");
                result(NO);
            }
        }
    } onQueue:nil];
}

#pragma mark - 微信及QQ回调设置
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    //微信
    return [WXApi handleOpenURL:url delegate:[oAuthManager manager]] || [TencentOAuth HandleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //微信
    return [WXApi handleOpenURL:url delegate:[oAuthManager manager]] || [TencentOAuth HandleOpenURL:url];
}

@end
