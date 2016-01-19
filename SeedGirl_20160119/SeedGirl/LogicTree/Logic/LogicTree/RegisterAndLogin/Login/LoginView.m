//
//  LoginView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/9.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "LoginView.h"
#import "LR_TextField.h"
#import "oAuthManager.h"
#import "ValidateTool.h"
#import "UserData.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"

@interface LoginView () <UITextFieldDelegate,oAuthManagerDelegate>
@property (strong, nonatomic) OwnProgressHUD *loginProgressHUD;
//手机号文本框
@property (strong, nonatomic) LR_TextField *tf_phone;
//密码文本框
@property (strong, nonatomic) LR_TextField *tf_password;
//登录按钮
@property (strong, nonatomic) UIButton *b_login;
//注册按钮
@property (strong, nonatomic) UIButton *b_register;
//重置密码按钮
@property (strong, nonatomic) UIButton *b_resetPassword;
//其他登录方式提示
@property (strong, nonatomic) UILabel *l_otherLogin;
//qq登录按钮
@property (strong, nonatomic) UIButton *b_qqLogin;
@property (strong, nonatomic) UILabel *l_qqLogin;
//微信登录按钮
@property (strong, nonatomic) UIButton *b_webchatLogin;
@property (strong, nonatomic) UILabel *l_webchatLogin;
@property (nonatomic, strong) UITapGestureRecognizer *viewTapGR;
@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //属性布局
        [self attributeLayout];
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//属性布局
- (void)attributeLayout {
    [oAuthManager manager].delegate = self;
    
    self.backgroundColor = RGB(240, 242, 245);
    self.scrollsToTop = YES;
    self.scrollEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
}
//加载子视图
- (void)loadSubviews {
    [self addSubview:self.tf_phone];
    [self addSubview:self.tf_password];
    [self addSubview:self.b_login];
    [self addSubview:self.b_register];
    [self addSubview:self.b_resetPassword];
    
    [self addSubview:self.l_otherLogin];
    [self addSubview:self.b_qqLogin];
    [self addSubview:self.l_qqLogin];
    [self addSubview:self.b_webchatLogin];
    [self addSubview:self.l_webchatLogin];

    [self addGestureRecognizer:self.viewTapGR];
    [self addConstraints];
}
//添加约束
- (void)addConstraints {
    WeakSelf;
    //手机号文本框
    [self.tf_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(24.0f);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.equalTo(weakSelf).with.offset(-44.0f);
        make.height.mas_equalTo(48.0f);
    }];
    //密码文本框
    [self.tf_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tf_phone.mas_bottom).with.offset(18.0f);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.equalTo(weakSelf.tf_phone.mas_width);
        make.height.mas_equalTo(48.0f);
    }];
    //登录按钮
    [self.b_login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tf_password.mas_bottom).with.offset(34.0f);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.equalTo(weakSelf.tf_password.mas_width);
        make.height.mas_equalTo(47.0f);
    }];
    //注册按钮
    [self.b_register mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.b_login.mas_bottom).with.offset(18.0f);
        make.left.equalTo(weakSelf.b_login);
        make.height.mas_equalTo(44.0f);
    }];
    //重置密码按钮
    [self.b_resetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(weakSelf.b_register.mas_left).with.offset(2.0f);
        make.right.equalTo(weakSelf.b_login);
        make.centerY.equalTo(weakSelf.b_register);
        make.height.equalTo(weakSelf.b_register);
    }];
    //其他登录方式
    [self.l_otherLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.b_register.mas_bottom).with.offset(45.0f);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.lessThanOrEqualTo(weakSelf.b_register.mas_width);
    }];
    //qq登录按钮
    [self.b_qqLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.l_otherLogin.mas_bottom).with.offset(20.0f);
        make.centerX.equalTo(weakSelf.mas_centerX).with.offset(-50.0f);
        make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
    }];
    [self.l_qqLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.b_qqLogin.mas_bottom).with.offset(10.0f);
        make.centerX.equalTo(weakSelf.b_qqLogin);
    }];
    //微信登录按钮
    [self.b_webchatLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.b_qqLogin);
        make.centerX.equalTo(weakSelf.mas_centerX).with.offset(50.0f);
        make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
    }];
    [self.l_webchatLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.b_webchatLogin.mas_bottom).with.offset(10.0f);
        make.centerX.equalTo(weakSelf.b_webchatLogin);
    }];
}

#pragma mark - Main
//首次加载
- (void)firstLoad {
    if ([TencentOAuth iphoneQQInstalled]) {
        self.b_qqLogin.hidden = NO;
        self.l_qqLogin.hidden = NO;
    }else{
        self.b_qqLogin.hidden = YES;
        self.l_qqLogin.hidden = YES;
    }
    
    if ([WXApi isWXAppInstalled]) {
        self.b_webchatLogin.hidden = NO;
        self.l_webchatLogin.hidden  = NO;
    }else{
        self.b_webchatLogin.hidden = YES;
        self.l_webchatLogin.hidden  = YES;
    }
}
//取消键盘焦点
- (void)resignKeyboardResponder {
    if ([self.tf_phone isFirstResponder]) {
        [self.tf_phone resignFirstResponder];
    }
    if ([self.tf_password isFirstResponder]) {
        [self.tf_password resignFirstResponder];
    }
}
//用户登录
- (void)userLoginNetworkData:(NSDictionary *)userInfo {
    if (_loginProgressHUD == nil) {
        _loginProgressHUD = [OwnProgressHUD showAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    [_loginProgressHUD showProgressText:@"登录中..."];
    
    [self net_userLoginWithUserInfo:userInfo completion:^(BOOL isSuccess) {
        if (isSuccess) {
            //登录环信
            [self loginEasemobWithResultBlock:^(BOOL isSuccess) {
                if (isSuccess) {
                    [self showMessage:@"登录成功"];
                    //登录成功
                    [self userLoginSuccess];
                } else {
                    [self showMessage:@"登录失败"];
                    [self userLoginFailure];
                }
            }];
        } else {
            [self showMessage:@"登录失败"];
            //登录失败
            [self userLoginFailure];
        }
    }];
}
//第三方登录
- (void)oAuthLoginNetworkData:(NSDictionary *)userInfo {
    if (_loginProgressHUD == nil) {
        _loginProgressHUD = [OwnProgressHUD showAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    [_loginProgressHUD showProgressText:@"登录中..."];
    
    [self net_oauthLoginWithUserInfo:userInfo completion:^(BOOL isSuccess) {
        [_loginProgressHUD hide:YES];
        if (isSuccess) {
            //登录环信
            [self loginEasemobWithResultBlock:^(BOOL isSuccess) {
                if (isSuccess) {
                    [self showMessage:@"登录成功"];
                    //登录成功
                    [self userLoginSuccess];
                } else {
                    [self showMessage:@"登录失败"];
                    [self userLoginFailure];
                }
            }];
        } else {
            [self showMessage:@"登录失败"];
        }
    }];
}
//登录成功
- (void)userLoginSuccess {
    [UserManager manager].isLogined = YES;
    [[UserManager manager] saveUserLoginInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:JPushAliasNotification object:nil];
    
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    options.displayStyle = ePushNotificationDisplayStyle_messageSummary;
    if ([[UserManager manager] note_status]) {
        options.noDisturbStatus = ePushNotificationNoDisturbStatusClose;
    }else{
        options.noDisturbStatus = ePushNotificationNoDisturbStatusDay;
    }
    [[EaseMob sharedInstance].chatManager setApnsNickname:[[[UserManager manager] userData] userName]];
    [[EaseMob sharedInstance].chatManager updatePushOptions:options error:nil];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (self.loginSuccessBlock) {
            self.loginSuccessBlock();
        }
    });
}
//登录失败
- (void)userLoginFailure {
    [UserManager manager].isLogined = NO;
    [[UserManager manager] cleanUserLoginInfo];
}
//提示信息
- (void)showMessage:(NSString *)message {
    if (_loginProgressHUD != nil) {
        [_loginProgressHUD hide:YES];
        _loginProgressHUD = nil;
    }
    
    OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:self animated:YES];
    [progressHUD setCenterYOffset:self.contentOffset.y];
    [progressHUD showText:message];
    [progressHUD hide:YES afterDelay:2];
}

#pragma mark - oAuthManagerDelegate
//qq授权
- (void)oAuthDidReceiveQQUserInfo:(NSDictionary *)userInfo {
    NSLog(@"userinfo us %@",userInfo);
    [self oAuthLoginNetworkData:userInfo];
}
//qq授权取消
- (void)oAuthQQAuthCancel {
    if (_loginProgressHUD != nil) {
        [_loginProgressHUD hide:YES];
        _loginProgressHUD = nil;
    }
}
//qq授权失败
- (void)oAuthQQAuthFailure {
    [self showMessage:@"获取信息失败"];
}
//微信授权
- (void)oAuthDidReceiveWebChatUserInfo:(NSDictionary *)userInfo {
    NSLog(@"userinfo us %@",userInfo);
    [self oAuthLoginNetworkData:userInfo];
}
//微信授权取消
- (void)oAuthWebchatAuthCancel {
    if (_loginProgressHUD != nil) {
        [_loginProgressHUD hide:YES];
        _loginProgressHUD = nil;
    }
}
//微信授权失败
- (void)oAuthWebchatAuthFailure {
    [self showMessage:@"获取信息失败"];
}

#pragma mark - UIResponse Event
//视图空白区域点击事件
- (void)viewTapGRAction:(UITapGestureRecognizer *)tapGR {
    //取消键盘焦点
    [self resignKeyboardResponder];
}
//登录按钮点击事件
- (void)loginButtonClick:(id)sender {
    //取消键盘焦点
    [self resignKeyboardResponder];

    if (self.tf_phone.text == nil || self.tf_phone.text.length == 0) {
        [self showMessage:@"请输入手机号"];
        return ;
    }
    if(![ValidateTool validateMobile:self.tf_phone.text]){
        [self showMessage:@"手机号格式不正确"];
        return ;
    }
    if (self.tf_password.text == nil || self.tf_password.text.length == 0) {
        [self showMessage:@"请输入密码"];
        return ;
    }
    
    NSDictionary *parameters = @{@"phone":self.tf_phone.text,
                                 @"password":self.tf_password.text};
    [self userLoginNetworkData:parameters];
}
//注册按钮点击事件
- (void)registerButtonClick:(id)sender {
    //取消键盘焦点
    [self resignKeyboardResponder];
    
    if (self.registerBlock) {
        self.registerBlock();
    }
}
//找回密码按钮点击事件
- (void)resetPasswordButtonClick:(id)sender {
    //取消键盘焦点
    [self resignKeyboardResponder];
    
    if (self.resetPasswordBlock) {
        self.resetPasswordBlock();
    }
}
//qq按钮点击事件
- (void)qqButtonClick:(id)sender {
    //取消键盘焦点
    [self resignKeyboardResponder];
    
    [[oAuthManager manager] sendTencentAuthRequest];
    
}
//微信按钮点击事件
- (void)webchatButtonClick:(id)sender {
    //取消键盘焦点
    [self resignKeyboardResponder];
    
    [[oAuthManager manager] sendWebchatAuthRequest];
}

#pragma mark - lazyload
//手机号文本框
- (LR_TextField *)tf_phone {
    if (_tf_phone == nil) {
        _tf_phone = [[LR_TextField alloc] init];
        _tf_phone.backgroundColor = [UIColor whiteColor];
        _tf_phone.paddingHeight = 48.0f;
        [_tf_phone setHeadImage:[UIImage imageWithContentOfFile:@"user_icon.png"]
               highlightedImage:[UIImage imageWithContentOfFile:@"user_icon_s.png"]];
        _tf_phone.keyboardType = UIKeyboardTypeNumberPad;
        _tf_phone.placeholder = @"请输入11位手机号";
        _tf_phone.font = [UIFont systemFontOfSize:15.0f];
    }
    return _tf_phone;
}
//密码文本框
- (LR_TextField *)tf_password {
    if (_tf_password== nil) {
        _tf_password = [[LR_TextField alloc] init];
        _tf_password.backgroundColor = [UIColor whiteColor];
        _tf_password.paddingHeight = 48.0f;
        [_tf_password setHeadImage:[UIImage imageWithContentOfFile:@"lock.png"]
                  highlightedImage:[UIImage imageWithContentOfFile:@"lock_s.png"]];
        _tf_password.keyboardType = UIKeyboardTypeDefault;
        _tf_password.returnKeyType = UIReturnKeyDone;
        _tf_password.secureTextEntry = YES;
        _tf_password.placeholder = @"密码，区分大小写";
        _tf_password.font = [UIFont systemFontOfSize:15.0f];
    }
    return _tf_password;
}
//登录按钮
- (UIButton *)b_login{
    if (_b_login == nil) {
        _b_login = [[UIButton alloc] init];
        _b_login.backgroundColor = [UIColor clearColor];
        _b_login.layer.cornerRadius = 4.0f;
        _b_login.layer.masksToBounds = YES;
        [_b_login setTitle:@"登录" forState:UIControlStateNormal];
        _b_login.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_b_login setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        UIImage *normalImage = [UIImage imageWithColor:RGB(255, 122, 147) Size:CGSizeMake(1.0f, 1.0f)];
        UIImage *lightImage = [UIImage imageWithColor:RGB(235, 113, 136) Size:CGSizeMake(1.0f, 1.0f)];
        [_b_login setBackgroundImage:normalImage forState:UIControlStateNormal];
        [_b_login setBackgroundImage:lightImage forState:UIControlStateHighlighted];
        [_b_login addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _b_login;
}
//注册按钮
- (UIButton *)b_register {
    if (_b_register == nil) {
        _b_register = [[UIButton alloc] init];
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"没有账号，免费注册"];
        NSRange titleRange = {0,[title length]};
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:titleRange];
        [title addAttribute:NSForegroundColorAttributeName value:RGB(30, 178, 254) range:titleRange];
        [_b_register setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_b_register setAttributedTitle:title forState:UIControlStateNormal];
        [_b_register addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _b_register;
}
//重置密码按钮
- (UIButton *)b_resetPassword {
    if (_b_resetPassword == nil) {
        _b_resetPassword = [[UIButton alloc] init];
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"忘记密码？"];
        NSRange titleRange = {0,[title length]};
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:titleRange];
        [title addAttribute:NSForegroundColorAttributeName value:RGB(30, 178, 254) range:titleRange];
        [_b_resetPassword setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_b_resetPassword setAttributedTitle:title forState:UIControlStateNormal];
        [_b_resetPassword addTarget:self action:@selector(resetPasswordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _b_resetPassword;
}
//其他登录方式
- (UILabel *)l_otherLogin{
    if (_l_otherLogin == nil) {
        _l_otherLogin = [[UILabel alloc] init];
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"其他登录方式"];
        NSRange titleRange = {0,[title length]};
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:titleRange];
        [title addAttribute:NSForegroundColorAttributeName value:RGB(51, 51, 51) range:titleRange];
        [_l_otherLogin setAttributedText:title];
    }
    return _l_otherLogin;
}
//qq登录按钮
- (UIButton *)b_qqLogin{
    if (_b_qqLogin == nil) {
        _b_qqLogin = [[UIButton alloc] init];
        _b_qqLogin.backgroundColor = [UIColor clearColor];
        [_b_qqLogin setImage:[UIImage imageWithContentOfFile:@"qqIcon.png"] forState:UIControlStateNormal];
        _b_qqLogin.adjustsImageWhenHighlighted = NO;
        [_b_qqLogin addTarget:self action:@selector(qqButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _b_qqLogin;
}
- (UILabel *)l_qqLogin{
    if (_l_qqLogin == nil) {
        _l_qqLogin = [[UILabel alloc] init];
        _l_qqLogin.backgroundColor = [UIColor clearColor];
        _l_qqLogin.textAlignment = NSTextAlignmentCenter;
        _l_qqLogin.font = [UIFont systemFontOfSize:15.0f];
        _l_qqLogin.textColor = RGB(51, 51, 51);
        _l_qqLogin.text = @"QQ登录";
    }
    return _l_qqLogin;
}
//微信登录按钮
- (UIButton *)b_webchatLogin{
    if (_b_webchatLogin == nil) {
        _b_webchatLogin = [[UIButton alloc] init];
        _b_webchatLogin.backgroundColor = [UIColor clearColor];
        [_b_webchatLogin setImage:[UIImage imageWithContentOfFile:@"wechatIcon.png"] forState:UIControlStateNormal];
        _b_webchatLogin.adjustsImageWhenHighlighted = NO;
        [_b_webchatLogin addTarget:self action:@selector(webchatButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _b_webchatLogin;
}
- (UILabel *)l_webchatLogin{
    if (_l_webchatLogin == nil) {
        _l_webchatLogin = [[UILabel alloc] init];
        _l_webchatLogin.backgroundColor = [UIColor clearColor];
        _l_webchatLogin.textAlignment = NSTextAlignmentCenter;
        _l_webchatLogin.font = [UIFont systemFontOfSize:15.0f];
        _l_webchatLogin.textColor = RGB(51, 51, 51);
        _l_webchatLogin.text = @"微信登录";
    }
    return _l_webchatLogin;
}
//点击事件
- (UITapGestureRecognizer *)viewTapGR {
    if (_viewTapGR == nil) {
        _viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGRAction:)];
    }
    return _viewTapGR;
}

#pragma mark - Network Interface
//用户登录
- (void)net_userLoginWithUserInfo:(NSDictionary *)parameters
                       completion:(void(^)(BOOL isSuccess))completion {
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_login"]
                            parameters:parameters
                               success:^(id responseObject) {
                                   if (userLoginProtocol(responseObject) == 0) {
                                       completion(YES);
                                   } else {
                                       completion(NO);
                                   }
                               }
                               failure:^(NSError *error) {
                                   NSLog(@"user login error is %@",error.localizedDescription);
                                   completion(NO);
                               }];
    
}
//第三方用户登录
- (void)net_oauthLoginWithUserInfo:(NSDictionary *)parameters
                        completion:(void(^)(BOOL isSuccess))completion {
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_third_login"]
                            parameters:parameters
                               success:^(id responseObject) {
                                   if (oauthLoginProtocol(responseObject) == 0) {
                                       completion(YES);
                                   } else {
                                       completion(NO);
                                   }
                               }
                               failure:^(NSError *error) {
                                   NSLog(@"oauth login error is %@",error.localizedDescription);
                                   completion(NO);
                               }];
}
//登录环信
- (void)loginEasemobWithResultBlock:(void(^)(BOOL isSuccess))result{
    NSString *userName  = [NSString stringWithFormat:@"%@", [[UserManager manager] userHxid]];//@"user_7";
    NSString *password  = [NSString stringWithFormat:@"seed_%@", userName];

    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[[UserManager manager] userHxid] password:[password MD5Hash] completion:^(NSDictionary *loginInfo, EMError *error) {
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

@end
