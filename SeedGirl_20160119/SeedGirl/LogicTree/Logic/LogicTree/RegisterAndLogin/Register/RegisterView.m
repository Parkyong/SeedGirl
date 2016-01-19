//
//  RegisterView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/8.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "RegisterView.h"
#import "LR_TextField.h"
#import "ValidateTool.h"
#import "UserData.h"

@interface RegisterView () <UITextFieldDelegate>
@property (strong, nonatomic) OwnProgressHUD *registerProgressHUD;
//手机号文本框
@property (nonatomic, strong) LR_TextField *tf_phone;
//密码文本框
@property (nonatomic, strong) LR_TextField *tf_password;
//验证码文本框
@property (nonatomic, strong) UITextField *tf_code;
//验证码按钮
@property (nonatomic, strong) UIButton *b_code;
//注册按钮
@property (nonatomic, strong) UIButton *b_register;
@end

@implementation RegisterView
@synthesize contentType = _contentType;

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
    [self addSubview:self.tf_code];
    [self addSubview:self.b_code];
    [self addSubview:self.b_register];
    
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
    //验证码文本框
    [self.tf_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tf_password.mas_bottom).with.offset(18.0f);
        make.left.equalTo(weakSelf.tf_phone.mas_left);
        make.size.mas_equalTo(CGSizeMake(143.0f, 32.0f));
    }];
    //验证码按钮
    [self.b_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.tf_code.mas_right).with.offset(20.0f);
        make.centerY.equalTo(weakSelf.tf_code.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(95.0f, 25.0f));
    }];
    //注册按钮
    [self.b_register mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tf_code.mas_bottom).with.offset(18.0f);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.equalTo(weakSelf.tf_phone.mas_width);
        make.height.mas_equalTo(47.0f);
    }];
}

#pragma mark - Main
//设置内容类型，0 注册；1 找回密码
- (void)setContentType:(NSInteger)contentType {
    _contentType = contentType;
    if (contentType == 1) {
        [self.b_register setTitle:@"找回密码" forState:UIControlStateNormal];
    } else {
        [self.b_register setTitle:@"注册" forState:UIControlStateNormal];
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
    if ([self.tf_code isFirstResponder]) {
        [self.tf_code resignFirstResponder];
    }
}
//用户注册
- (void)userRegisterNetworkData:(NSDictionary *)userInfo {
    if (_registerProgressHUD == nil) {
        _registerProgressHUD = [OwnProgressHUD showAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    [_registerProgressHUD showProgressText:@"数据提交中..."];
    
    [self net_registerWithUserInfo:userInfo completion:^(BOOL isSuccess) {
        if (isSuccess) {
            //登录环信
            [self loginEasemobWithResultBlock:^(BOOL isSuccess) {
                if (isSuccess) {
                    [self showMessage:@"注册成功"];
                    //注册成功
                    [self userRegisterSuccess];
                } else {
                    [self showMessage:@"注册失败"];
                    //注册
                    [self userRegisterFailure];
                }
            }];
        } else {
            [self showMessage:@"注册失败"];
            //注册失败
            [self userRegisterFailure];
        }
    }];
}
//用户重设密码
- (void)resetPasswordNetworkData:(NSDictionary *)userInfo {
    if (_registerProgressHUD == nil) {
        _registerProgressHUD = [OwnProgressHUD showAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    [_registerProgressHUD showProgressText:@"数据提交中..."];
    
    [self net_resetPasswordWithUserInfo:userInfo completion:^(BOOL isSuccess) {
        if (isSuccess) {
            [self showMessage:@"密码重置成功"];
            //重设密码成功
            [self resetPasswordSuccess];
        } else {
            [self showMessage:@"密码重置失败"];
        }
    }];
}
//重设密码成功
- (void)resetPasswordSuccess {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (self.registerSuccessBlock) {
            self.registerSuccessBlock();
        }
    });
}
//注册成功
- (void)userRegisterSuccess {
    [[UserManager manager] saveUserLoginInfo];
    [UserManager manager].isLogined = YES;
    [UserManager manager].isRegisted = YES;
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
        if (self.registerSuccessBlock) {
            self.registerSuccessBlock();
        }
    });
}
//注册失败
- (void)userRegisterFailure {
    [UserManager manager].isLogined = NO;
    [UserManager manager].isRegisted = NO;
    [[UserManager manager] cleanUserLoginInfo];
}
//提示信息
- (void)showMessage:(NSString *)message {
    if (_registerProgressHUD != nil) {
        [_registerProgressHUD hide:YES];
        _registerProgressHUD = nil;
    }
    
    OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:self animated:YES];
    [progressHUD setCenterYOffset:self.contentOffset.y];
    [progressHUD showText:message];
    [progressHUD hide:YES afterDelay:2];
}

#pragma mark    代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.tf_code.layer.borderColor = [RGB(255, 122, 147) CGColor];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.tf_code.layer.borderColor = [RGB(183, 186, 191) CGColor];
    return YES;
}

#pragma mark - UIResponse Event
//验证码点击事件
- (void)codeButtonClick:(id)sender {
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
    
    if (_registerProgressHUD == nil) {
        _registerProgressHUD = [OwnProgressHUD showAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    [_registerProgressHUD showProgressText:@"验证码获取中..."];
    
    [self net_sendSMSWithPhone:self.tf_phone.text
                    completion:^(BOOL isSuccess) {
                        if (isSuccess) {
                            [self showMessage:@"验证码已发往手机，注意查收"];
                        } else {
                            [self showMessage:@"验证码发送失败"];
                        }
                    }];
}
//注册点击事件
- (void)registerButtonClick:(id)sender {
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
        [self showMessage:@"请输入新密码"];
        return ;
    }
    if (self.tf_code.text == nil || self.tf_code.text.length == 0) {
        [self showMessage:@"请输入验证码"];
        return ;
    }

    NSDictionary *userInfo = @{@"phone":self.tf_phone.text,
                                 @"password":self.tf_password.text,
                                 @"captcha":self.tf_code.text
                                 };
    if (self.contentType == 1) {
        //重设密码
        [self resetPasswordNetworkData:userInfo];
    } else {
        //用户注册
        [self userRegisterNetworkData:userInfo];
    }
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
        _tf_password.placeholder = @"新密码，区分大小写";
        _tf_password.font = [UIFont systemFontOfSize:15.0f];
    }
    return _tf_password;
}
//验证码文本框
- (UITextField *)tf_code{
    if (_tf_code == nil) {
        _tf_code = [[UITextField alloc] init];
        _tf_code.placeholder = @"短信验证码";
        _tf_code.keyboardType = UIKeyboardTypeNumberPad;
        _tf_code.textAlignment = NSTextAlignmentCenter;
        _tf_code.layer.borderWidth  = 1;
        _tf_code.layer.cornerRadius = 3;
        _tf_code.layer.borderColor  = [RGB(183, 186, 191) CGColor];
        _tf_code.backgroundColor    = [UIColor whiteColor];
        _tf_code.delegate = self;
    }
    return _tf_code;
}
//验证码按钮
- (UIButton *)b_code{
    if (_b_code == nil) {
        _b_code = [[UIButton alloc] init];
        _b_code.backgroundColor = RGB(0, 165, 244);
        _b_code.layer.cornerRadius = 4.0f;
        _b_code.layer.masksToBounds = YES;
        [_b_code setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_b_code setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        _b_code.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_b_code addTarget:self action:@selector(codeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _b_code;
}
//注册按钮
- (UIButton *)b_register {
    if (_b_register == nil) {
        _b_register = [[UIButton alloc] init];
        _b_register.backgroundColor = RGB(255, 122, 147);
        _b_register.layer.cornerRadius = 4.0f;
        _b_register.layer.masksToBounds = YES;
        [_b_register setTitle:@"注册" forState:UIControlStateNormal];
        [_b_register setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _b_register.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [_b_register addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _b_register;
}

#pragma mark - Network Interface
//发送验证码
- (void)net_sendSMSWithPhone:(NSString *)phone
                  completion:(void(^)(BOOL isSuccess))completion {
    NSDictionary *parameters = @{@"phone_number":phone,
                                 @"country_code":@"+86"};
    
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_sendsms"]
                            parameters:parameters
                               success:^(id responseObject) {
                                   if (publishProtocol(responseObject) == 0) {
                                       completion(YES);
                                   } else {
                                       completion(NO);
                                   }
                               }
                               failure:^(NSError *error) {
                                   NSLog(@"send sms error is %@",error.localizedDescription);
                                   completion(NO);
                               }];
}
//用户注册
- (void)net_registerWithUserInfo:(NSDictionary *)parameters
                      completion:(void(^)(BOOL isSuccess))completion {
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_register"]
                            parameters:parameters
                               success:^(id responseObject) {
                                   if (userRegisterProtocol(responseObject) == 0) {
                                       completion(YES);
                                   } else {
                                       completion(NO);
                                   }
                               }
                               failure:^(NSError *error) {
                                   NSLog(@"user register error is %@",error.localizedDescription);
                                   completion(NO);
                               }];
}
//用户重设密码
- (void)net_resetPasswordWithUserInfo:(NSDictionary *)parameters
                           completion:(void(^)(BOOL isSuccess))completion {
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_reset_password"]
                            parameters:parameters
                               success:^(id responseObject) {
                                   if (userResetPassword(responseObject) == 0) {
                                       completion(YES);
                                   } else {
                                       completion(NO);
                                   }
                               }
                               failure:^(NSError *error) {
                                   NSLog(@"user register error is %@",error.localizedDescription);
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
            } else {
                APPLog(@"环信登录失败");
                result(NO);
            }
        }
    } onQueue:nil];
}

@end
