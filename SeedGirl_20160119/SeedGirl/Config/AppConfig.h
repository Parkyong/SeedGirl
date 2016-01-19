//
//  AppConfig.h
//  SeedGirl
//
//  Created by Admin on 15/10/14.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h

//系统版本
#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
//设备模式
#define SystemModal [[UIDevice currentDevice] model]
//屏幕尺寸宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//屏幕尺寸高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//是否是iphone
#define isIPhone UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone
//是否是ipad
#define isIPad UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
//是否支持拍照功能
#define hasCamera [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]

//状态栏高度
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏高度
#define NavigationBarHeight self.navigationController.navigationBar.frame.size.height
#define HeigthForNavigationBar  64
//底部标签栏高度
#define MainTabBarHeight 65
#define BottomTabBarHeight 50

//只取竖屏的宽高
#define SCREEN_WIDTH MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define SCREEN_HEIGHT MAX([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)

#define BarHeigthPY                          0               //0
#define BarHeigthYULEI                       64               //0
#define AutoScrollViewInsetsFlag             NO              //YES

//5s    568
//6     667
//6Plus 736
#define isiPhone5s       ((ScreenHeight >= 568) && (ScreenHeight < 667))
#define isiPhone6        ((ScreenHeight >= 667) && (ScreenHeight < 736))
#define isiPhone6Plus    ScreenHeight >= 736

#define IS_IPHONE_6 (SCREEN_HEIGHT == 667.0f)
#define IS_IPHONE_6_PLUS (SCREEN_HEIGHT == 736.0f)
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

//颜色
#define RGB(r, g, b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

// 日志输出
#ifdef APPLOGDEBUG
#define APPLog(format,...) NSLog((@"File:[%s]\nFunction:[%s]\nLine:[%d]:" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define APPLog(...)
#endif

//软类型
#define WeakSelf __weak typeof(self)weakSelf=self

//软件版本
#define SoftVersion @"1.0.0.0"

//文件夹类型
#define VIDEO_FOLDER @"videos"
#define MIN_VIDEO_DUR 2.0f
#define MAX_VIDEO_DUR 8.0f

//jpush
static NSString * const JPUSH_KEY = @"d66ea6d6dafcce0d558ffa48";
static NSString * const JPUSH_CHANNEL = @"iPhone";

//微信APP_ID及密码
static NSString *const kWXAPP_ID = @"wx1c04bb9e2080a623";
static NSString *const kWXAPP_SECRET = @"25658c20506de93c6b2b143a4ccadc06";

//QQAPPID及密码
static NSString *const kQQAPP_ID = @"1104869431";
static NSString *const kQQAPP_KEY = @"uisTyqB7ejUbDN3E";

#pragma mark - 通知名称
//三方登录
#define kUserLogin                 @"kUserLogin"
#define kUserLogout                @"kUserLogout"
#define kUserDatafix               @"kUserDatafix"
#define kUserInfoChange            @"kUserInfoChange"

//jpush设置别名
static NSString * const JPushAliasNotification = @"JPushAliasNotification";
//网络状态改变
static NSString * const NetworkNotifierNotification = @"NetworkReachabilityStatusChanged";
//新的视频请求
static NSString * const NewVideoRequestMessageNotification = @"NewVideoRequestMessageNotification";
//暂无新的视频请求
static NSString * const NoVideoRequestMessageNotification = @"NoVideoRequestMessageNotification";

static NSString * const NoNoteMessageNotification = @"NoNoteMessageNotification";

static NSString * const NewNoteMessageNotification = @"NewNoteMessageNotification";

#define kSetupPersonalImageCountChange @"SetupPersonalImageCountChange"

#endif /* AppConfig_h */
