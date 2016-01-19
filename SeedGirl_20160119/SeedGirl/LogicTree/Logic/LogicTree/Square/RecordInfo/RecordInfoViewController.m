//
//  RecordInfoViewController.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/4.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "RecordInfoViewController.h"
#import "RecordInfoView.h"

#import "CommentData.h"
#import "RecordData.h"

#import "RecordInfoShowImageVC.h"
#import "RecordInfoCommentVC.h"
#import "ChatViewController.h"
#import "UserData.h"
#import "SeedPlayer.h"

@interface RecordInfoViewController ()<ChatViewControllerDelegate>
@property (nonatomic, strong) RecordInfoView *rootView;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation RecordInfoViewController
- (void)loadView{
    self.rootView = [[RecordInfoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.rootView.parentController = self;
    self.view     = self.rootView;
    self.title    = @"动态详情";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setParameter];
    [self loadingData];
    [self addBlockFunction];
}

- (void)setParameter{
    self.array = [NSMutableArray array];
}

- (void)loadingData{
    [self.array addObject:self.recordData];
    [self loadData];
}

#pragma mark    添加Block功能
- (void)addBlockFunction{
    WeakSelf;
    //查看图片
    self.rootView.showImageBlock = ^(NSArray *recordData, NSInteger currentIndex){
        RecordInfoShowImageVC *showImageVC = [[RecordInfoShowImageVC alloc] init];
        showImageVC.localData = recordData;
        showImageVC.currenIndex = currentIndex;
        showImageVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [weakSelf presentViewController:showImageVC animated:YES completion:nil];
    };
    
    //回复
    self.rootView.commentBlock = ^(BOOL isHeaderReview, NSString *commentID){
            RecordInfoCommentVC *commentVC = [[RecordInfoCommentVC alloc] init];
            commentVC.automaticallyAdjustsScrollViewInsets = AutoScrollViewInsetsFlag;
            commentVC.recordID = weakSelf.recordData.recordID;
            commentVC.commentID = commentID;
            commentVC.isHeaderReview = isHeaderReview;
            commentVC.refreshCommentBlock = ^(){
                [weakSelf.rootView startDataRefresh];
            };
            [weakSelf.navigationController pushViewController:commentVC animated:NO];
    };
    
    //纸条
    self.rootView.noteBlock = ^(NSString *hxName, NSString *hxID){
        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:hxID isGroup:NO];
        chatVC.delelgate = weakSelf;
        chatVC.title = hxName;
        [weakSelf.navigationController pushViewController:chatVC animated:NO];
    };
    
    //观看视频
    self.rootView.playVideoBlock = ^(){
        SeedPlayer *seedVC = [[SeedPlayer alloc] init];
        seedVC.movieUrl    = weakSelf.recordData.videoURL;
        seedVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [weakSelf presentViewController:seedVC animated:YES completion:nil];
    };
}

#pragma mark    代理
- (NSString *)avatarWithChatter:(NSString *)chatter
{
    if ([chatter isEqualToString:[[UserManager manager] userHxid]]) {
        return [[[UserManager manager] userData] userIcon];
    }else{
        return self.recordData.userIcon;
    }
}

- (NSString *)nickNameWithChatter:(NSString *)chatter
{
    if ([chatter isEqualToString:[[UserManager manager] userHxid]]) {
        return [[[UserManager manager] userData] userName];
    }else{
        return self.recordData.userName;
    }
}

#pragma mark    方法
- (void)loadData{
    [self.rootView loadData:self.array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setConversationList:(NSString *)toUserHxid{ //withResult:(void(^)(BOOL isSuccess))result{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameters setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameters setValue:toUserHxid forKey:@"toUserHxid"];
    
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_conversation"] parameters:parameters success:^(id responseObject) {
        NSLog(@"responseObject:%@", responseObject);
        if (publishProtocol(responseObject) == 0) {
//            result(YES);
        }else{
//            result(NO);
        }
    } failure:^(NSError *error) {
//        result(NO);
        APPLog(@"%@", error);
    }];
}

- (void)popCurrentPageAction{
    [self.navigationController popViewControllerAnimated:NO];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
