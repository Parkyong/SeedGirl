//
//  SetupLookFunsVC.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/25.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupLookFunsVC.h"
#import "SetupLookFunsView.h"
#import "ChatViewController.h"
@interface SetupLookFunsVC ()
@property (nonatomic, strong) SetupLookFunsView *rootView;
@end
@implementation SetupLookFunsVC
- (void)loadView{
    self.rootView = [[SetupLookFunsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view     = self.rootView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.rootView firstLoad];
    
    WeakSelf;
    self.rootView.selectedBlock=^(FansData *data){
        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:data.fansHxid isGroup:NO];
        chatVC.delelgate = weakSelf.rootView;
        chatVC.title = data.fansName;
        [weakSelf.navigationController pushViewController:chatVC animated:YES];
    };
}

//- (void)setConversationList:(NSString *)toUserHxid{ //withResult:(void(^)(BOOL isSuccess))result{
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters setValue:[[UserManager manager] userID] forKey:@"user_id"];
//    [parameters setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
//    [parameters setValue:toUserHxid forKey:@"toUserHxid"];
//    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_conversation"] parameters:parameters success:^(id responseObject) {
//        NSLog(@"responseObject:%@", responseObject);
//        if (publishProtocol(responseObject) == 0) {
//        }else{
//        }
//    } failure:^(NSError *error) {
//        APPLog(@"%@", error);
//    }];
//}

@end
