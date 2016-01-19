//
//  SetupFeedbackController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/24.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupFeedbackController.h"
#import "SetupFeedbackView.h"
@interface SetupFeedbackController ()
@property (nonatomic, strong) SetupFeedbackView *rootView;
@end
@implementation SetupFeedbackController

- (void)loadView{
    self.rootView = [[SetupFeedbackView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view     = self.rootView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //add somethingelse
    [self setRightBarButton];
}

- (void)setRightBarButton{
    //rightbarButtonitem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleBordered target:self action:@selector(uploadFeedbackAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

#pragma mark    上传意见
- (void)uploadFeedbackAction{
    APPLog(@"%@", self.rootView.feedbackTextView.text);
    if (self.rootView.feedbackTextView.text.length == 0) {
        OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:self.view animated:YES];
        [progressHUD showText:@"添加内容后发表"];
        [progressHUD hide:YES afterDelay:1];
        return;
    }
    OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [progressHUD showProgressText:@"发表中"];
    NSMutableDictionary *messageDict = [NSMutableDictionary dictionary];
    NSString* message = [self.rootView.feedbackTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [messageDict setValue:message forKey:@"message"];
    [messageDict setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [messageDict setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_feedback"] parameters:messageDict success:^(id responseObject) {
        APPLog(@"%@", responseObject);
        if (publishProtocol(responseObject) == 0) {
            NSLog(@"评论成功");
            [progressHUD showText:@"评论成功"];
            [progressHUD hide:YES afterDelay:1];
            [self performSelector:@selector(popCurrentPageAction) withObject:nil afterDelay:1];
        }else{
            APPLog(@"评论失败");
            [progressHUD showText:@"评论失败"];
            [progressHUD hide:YES afterDelay:1];
        }
    } failure:^(NSError *error) {
        APPLog(@"%@", error);
    }];
}
@end
