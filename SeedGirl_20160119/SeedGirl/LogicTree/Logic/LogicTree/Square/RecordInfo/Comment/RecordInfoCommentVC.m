//
//  RecordInfoCommentVC.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/9.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "RecordInfoCommentVC.h"
#import "RecordInfoCommentView.h"

@interface RecordInfoCommentVC ()
@property (nonatomic, strong) RecordInfoCommentView *rootView;
@end

@implementation RecordInfoCommentVC
- (void)loadView{
    self.rootView = [[RecordInfoCommentView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view     = self.rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setRightBarButton];
}
- (void)setRightBarButton{
    //rightbarButtonitem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self action:@selector(uploadReviewAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

#pragma mark    上传意见
- (void)uploadReviewAction{
    if (self.isHeaderReview) {
        [self headerReviewAction];
    }else{
        [self contentReviewAction];
    }
}

#pragma mark    一级评论
- (void)headerReviewAction{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameters setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameters setValue:self.recordID forKey:@"record_id"];
    [parameters setValue:[NSNumber numberWithInteger:0] forKey:@"from_user"];
    [parameters setValue:self.rootView.commentTextView.text forKey:@"text"];
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_comment"] parameters:parameters success:^(id responseObject) {
        APPLog(@"%@", responseObject);
        if (publishProtocol(responseObject) == 0) {
            APPLog(@"评论成功");
            [self popCurrentPageAction];
        }else{
            APPLog(@"评论失败");
        }
    } failure:^(NSError *error) {
        APPLog(@"%@", error);
    }];
}

#pragma mark    二级评论
- (void)contentReviewAction{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameters setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameters setValue:self.recordID forKey:@"record_id"];
    [parameters setValue:[NSNumber numberWithInteger:0] forKey:@"from_user"];
    [parameters setValue:self.rootView.commentTextView.text forKey:@"text"];
    [parameters setValue:self.commentID forKey:@"comment_id"];
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_sub_comment"] parameters:parameters success:^(id responseObject) {
        APPLog(@"%@", responseObject);
        if (publishProtocol(responseObject) == 0) {
            APPLog(@"评论成功");
            [self popCurrentPageAction];
        }else{
            APPLog(@"评论失败");
        }
    } failure:^(NSError *error) {
        APPLog(@"%@", error);
    }];
}

#pragma mark    退出
- (void)popCurrentPageAction{
    if (self.refreshCommentBlock != nil) {
        self.refreshCommentBlock();
    }
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
