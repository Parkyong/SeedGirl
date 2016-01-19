//
//  oAuthManager.m
//  SeedGirl
//
//  Created by Admin on 16/1/15.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "oAuthManager.h"

@interface oAuthManager ()
@property (strong, nonatomic) TencentOAuth *tencentOAuth;
@property (strong, nonatomic) NSArray *tencentPermissions;
@end

@implementation oAuthManager

+ (instancetype)manager {
    static oAuthManager *manager = nil;
    static dispatch_once_t predict;
    
    dispatch_once(&predict, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

#pragma mark - QQ相关
//发起QQ授权
- (void)sendTencentAuthRequest {
    self.tencentPermissions = @[kOPEN_PERMISSION_GET_USER_INFO,kOPEN_PERMISSION_GET_SIMPLE_USER_INFO];
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:kQQAPP_ID andDelegate:self];
    
    [self.tencentOAuth authorize:self.tencentPermissions inSafari:NO];
}

#pragma mark - TencentLoginDelegate
//登录成功
- (void)tencentDidLogin {
    if (self.tencentOAuth.accessToken && [[self.tencentOAuth accessToken] length] != 0) {
        [self.tencentOAuth getUserInfo];
    } else {
        if (self.delegate) {
            [self.delegate oAuthQQAuthFailure];
        }
    }
}
//非网络错误导致登录失败
- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (cancelled) {
        if (self.delegate) {
            [self.delegate oAuthQQAuthCancel];
        }
    } else {
        if (self.delegate) {
            [self.delegate oAuthQQAuthFailure];
        }
    }
}
//网络错误导致登录失败
- (void)tencentDidNotNetWork {
    if (self.delegate) {
        [self.delegate oAuthQQAuthFailure];
    }
}

#pragma mark - TencentSessionDelegate
- (void)getUserInfoResponse:(APIResponse *)response {
    if (response.retCode == URLREQUEST_SUCCEED &&
        response.detailRetCode == kOpenSDKErrorSuccess) {
        NSLog(@"qq response is %@",response.jsonResponse);
        
        NSInteger sex = [[response.jsonResponse objectForKey:@"gender"] isEqualToString:@"男"]?1:0;
        NSDictionary *userInfo = @{@"openid":[self.tencentOAuth openId],
                                   @"from":@"QQ",
                                   @"name":[response.jsonResponse objectForKey:@"nickname"],
                                   @"icon":[response.jsonResponse objectForKey:@"figureurl_qq_2"],
                                   @"sex":[NSNumber numberWithInteger:sex]};
        if (self.delegate) {
            [self.delegate oAuthDidReceiveQQUserInfo:userInfo];
        }
    } else {
        if (self.delegate) {
            [self.delegate oAuthQQAuthFailure];
        }
    }
}

#pragma mark - 微信相关
//发起微信授权
- (void)sendWebchatAuthRequest {
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"com.feymob.reedcatkins" ;
    
    [WXApi sendReq:req];
}
//获取微信access_token
- (void)webchatAccessToken:(NSString *)code {
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWXAPP_ID,kWXAPP_SECRET,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                NSString *access_token = [dict objectForKey:@"access_token"];
                NSString *openID = [dict objectForKey:@"openid"];
                [self webchatUserInfoWithAccessToken:access_token OpenID:openID];
            } else {
                if (self.delegate) {
                    [self.delegate oAuthWebchatAuthFailure];
                }
            }
        });
    });
}
//微信获得用户信息
- (void)webchatUserInfoWithAccessToken:(NSString *)access_token OpenID:(NSString *)openID {
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openID];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSDictionary *userInfo = @{@"openid":[dict objectForKey:@"openid"],
                                             @"from":@"webchat",
                                             @"name":[dict objectForKey:@"nickname"],
                                             @"icon":[dict objectForKey:@"headimgurl"],
                                             @"sex":[dict objectForKey:@"sex"]};
                if (self.delegate) {
                    [self.delegate oAuthDidReceiveWebChatUserInfo:userInfo];
                }
            } else {
                if (self.delegate) {
                    [self.delegate oAuthWebchatAuthFailure];
                }
            }
        });
    });
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseReq *)resp {
    SendAuthResp *authResp = (SendAuthResp *)resp;
    if (authResp.errCode != WXSuccess && self.delegate) {
        if (authResp.errCode == WXErrCodeUserCancel) {
            [self.delegate oAuthWebchatAuthCancel];
        } else {
            [self.delegate oAuthWebchatAuthFailure];
        }
    } else {
        [self webchatAccessToken:authResp.code];
    }
}

@end
