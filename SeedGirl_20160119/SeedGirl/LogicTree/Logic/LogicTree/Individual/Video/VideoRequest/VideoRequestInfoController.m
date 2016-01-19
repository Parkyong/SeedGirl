//
//  VideoRequestInfoController.m
//  SeedGirl
//
//  Created by Admin on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoRequestInfoController.h"
#import "VideoRequestInfoView.h"
#import "PushNotificationManager.h"
#import "PhotographViewController.h"
#import "AlbumViewController.h"

@interface VideoRequestInfoController () <UIActionSheetDelegate>
@property (nonatomic, strong) VideoRequestInfoView *videoRequestInfoView;
@end

@implementation VideoRequestInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"视频请求"];
    [self loadSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //新视频消息阅读
    [self readNewVideoRequestMessage];
}

//加载子视图
- (void)loadSubviews {
    self.view = self.videoRequestInfoView;
    [self.videoRequestInfoView setShowData:self.requestData];
    
    WeakSelf;
    //接受
    self.videoRequestInfoView.acceptBlock = ^(){
        [weakSelf videoRequestAccept];
    };
    //拒绝
    self.videoRequestInfoView.refuseBlock = ^(){
        [weakSelf videoRequestRefuse];
    };
}

#pragma mark - Main
//新视频消息阅读
- (void)readNewVideoRequestMessage {
    [[PushNotificationManager manager] removeVideoRequestID:self.requestData.requestID];
}

//拒绝
- (void)refuseWithTitle:(NSString *)title {
    [self net_videoRequestReplyWithRequestID:self.requestData.requestID
                                        type:-1
                                      reason:title
                                  completion:^(BOOL isSuccess) {
                                      if (isSuccess) {
                                          self.requestData.requestStatus = -1;
                                          [self.navigationController popViewControllerAnimated:NO];
                                          if (self.returnBlcok != nil) {
                                              self.returnBlcok();
                                          }
                                      }
                                  }];
}

#pragma mark - UIResponse Event
//接受
- (void)videoRequestAccept {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    
    //拍摄
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍摄"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             //action
                                                             [self commonActionSheetClickedButtonAtIndex:0];
                                                         }];
    [alertController addAction:cameraAction];
    
    [alertController.view setTintColor:RGB(51, 51, 51)];
    [self presentViewController:alertController animated:YES completion:nil];
    
#else
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍摄",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    actionSheet.tag = 0;
    [actionSheet showInView:self.view];
#endif
}

#pragma mark    调用方法
- (void)commonActionSheetClickedButtonAtIndex:(NSInteger)buttonIndex{
    //    if (buttonIndex == 0) {
    PhotographViewController *photographVC   = [[PhotographViewController alloc] init];
    photographVC.isPushStyle                 = YES;
    photographVC.isChangeHeadImage           = NO;
    photographVC.viewType                    = RECORDVIEW;
    [self.navigationController pushViewController:photographVC animated:YES];
    //    }
}

//拒绝
- (void)videoRequestRefuse {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    WeakSelf;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"拒绝理由" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    UIAlertAction *refuseAction1 = [UIAlertAction actionWithTitle:@"不诚恳" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf refuseWithTitle:action.title];
    }];
    [alertController addAction:refuseAction1];
    
    UIAlertAction *refuseAction2 = [UIAlertAction actionWithTitle:@"钻太少" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf refuseWithTitle:action.title];
    }];
    [alertController addAction:refuseAction2];
    
    UIAlertAction *refuseAction3 = [UIAlertAction actionWithTitle:@"心情不好" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf refuseWithTitle:action.title];
    }];
    [alertController addAction:refuseAction3];
    
    [alertController.view setTintColor:RGB(51, 51, 51)];
    [self presentViewController:alertController animated:YES completion:nil];
#else
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"拒绝理由"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"不诚恳",@"钻太少",@"心情不好",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
#endif
    
}

#pragma mark - UIActionSheet Delegate

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    for (UIView *subview in actionSheet.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            [button setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 1) {
        if (buttonIndex == actionSheet.cancelButtonIndex) {
            return ;
        }
        
        NSString *title = @"";
        switch (buttonIndex) {
            case 0:
                title = @"不诚恳";
                break;
            case 1:
                title = @"钻太少";
                break;
            case 2:
                title = @"心情不好";
                break;
        }
        [self refuseWithTitle:title];
    }else{
        [self commonActionSheetClickedButtonAtIndex:buttonIndex];
    }
}

#pragma mark - lazyload
- (VideoRequestInfoView *)videoRequestInfoView {
    if (_videoRequestInfoView == nil) {
        _videoRequestInfoView = [[VideoRequestInfoView alloc] initWithFrame:self.view.bounds];
        _videoRequestInfoView.backgroundColor = RGB(240, 242, 245);
    }
    return _videoRequestInfoView;
}

#pragma mark - Network Interface
//视频请求回复
- (void)net_videoRequestReplyWithRequestID:(NSString *)requestID
                                      type:(NSInteger)type
                                    reason:(NSString *)reason
                                completion:(void(^)(BOOL isSuccess))completion {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameter setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameter setValue:[NSNumber numberWithInteger:type] forKey:@"type"];
    [parameter setValue:requestID forKey:@"invite_id"];
    [parameter setValue:reason forKey:@"reason"];
    
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl]
                                        stringByAppendingString:@"user_video_reply"]
                            parameters:parameter success:^(id responseObject) {
                                if (publishProtocol(responseObject) == 0) {
                                    completion(YES);
                                }else{
                                    completion(NO);
                                }
                            } failure:^(NSError *error) {
                                completion(NO);
                            }];
}

@end
