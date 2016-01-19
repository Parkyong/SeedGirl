//
//  IndividualVideoView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/19.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "IndividualVideoView.h"
#import "IndividualVideoHeaderView.h"
#import "IndividualVideoCell.h"
#import "VideoSummaryData.h"
#import "PushNotificationManager.h"

#import "UIScrollView+OwnRefresh.h"

@interface IndividualVideoView () <UITableViewDataSource, UITableViewDelegate>
//概括视图
@property (nonatomic, strong) IndividualVideoHeaderView *headerView;
//概括数据
@property (nonatomic, strong) VideoSummaryData *summaryData;
//是否有视频请求新消息
@property (assign, nonatomic) BOOL hasNewVideoRequestMessage;
@end

@implementation IndividualVideoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //设置顶部视图
        [self setHeaderView];
        //属性布局
        [self attributeLayout];
        //设置刷新
        [self setDataRefresh];
    }
    return self;
}

//设置顶部视图
- (void)setHeaderView {
    CGFloat headerViewHeight = [self.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    //设置frame
    CGRect headerFrame = self.headerView.frame;
    headerFrame.size.height = headerViewHeight;
    [self.headerView setFrame:headerFrame];
    
    self.tableHeaderView = self.headerView;
    [self.headerView setShowDefaultData];
}
//属性布局
- (void)attributeLayout {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.scrollsToTop = NO;
    [self registerClass:[IndividualVideoCell class] forCellReuseIdentifier:NSStringFromClass([IndividualVideoCell class])];
    self.dataSource = self;
    self.delegate = self;
}
//设置刷新
- (void)setDataRefresh {
    _summaryData = nil;
    WeakSelf;
    //下拉刷新
    [self addHeaderWithRefreshingBlock:^{
        //设置网络数据
        [weakSelf managementNetworkData];
    }];
}

#pragma mark - Main
//首次加载
- (void)firstLoad {
    if ([[PushNotificationManager manager] hasNewVideoRequestMessage]) {
        [self showNewVideoRequestMessage:YES];
    } else {
        [self showNewVideoRequestMessage:NO];
    }
    
    _summaryData = [[CacheDataManager sharedInstance] individualVideoSummaryData];
    if (_summaryData == nil) {
        NSLog(@"video first load");
        [self startDataRefresh];
    } else {
        [self.headerView setShowData:_summaryData];
    }
}
//显示视频请求新消息提醒
- (void)showNewVideoRequestMessage:(BOOL)status {
    if (status == self.hasNewVideoRequestMessage) {
        return ;
    }
    
    self.hasNewVideoRequestMessage = status;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    NSArray *indexPaths = @[indexPath];
    [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}
//设置网络数据
- (void)managementNetworkData {
    [self net_managementCompletion:^(BOOL isSuccess) {
        if (isSuccess) {
            //设置概括数据
            self.summaryData = [[CacheDataManager sharedInstance] individualVideoSummaryData];
            [self.headerView setShowData:self.summaryData];
        } else {
            [self showTipMessage:@"获取数据失败，请重试"];
        }
        [self stopDataRefresh];
    }];
}
//显示提示信息
- (void)showTipMessage:(NSString *)message {
    OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:self.superview animated:YES];
    [progressHUD showText:message];
    [progressHUD hide:YES afterDelay:2];
}
//开始刷新
- (void)startDataRefresh {
    [self headerBeginRefreshing];
}
//停止刷新
- (void)stopDataRefresh {
    if([self isHeaderRefreshing]) {
        [self headerEndRefreshing];
    }
    if([self isFooterRefreshing]) {
        [self footerEndRefreshing];
    }
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndividualVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IndividualVideoCell class]) forIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell addShadowEffect];
    
    switch (indexPath.section) {
        case 0:
            [cell setShowPic:[UIImage imageWithContentOfFile:@"video_cell_management.png"] Title:@"管理制式视频"];
            [cell showRequestNewMessage:NO];
            break;
        case 1:
            [cell setShowPic:[UIImage imageWithContentOfFile:@"video_cell_request.png"] Title:@"视频请求"];
            [cell showRequestNewMessage:self.hasNewVideoRequestMessage];
            break;
    }
    
    NSLog(@"path is %@",indexPath);
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 25.0f;
    }
    return 10.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectedBlock) {
        self.selectedBlock(indexPath.section);
    }
}

#pragma mark - lazyload
- (IndividualVideoHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[IndividualVideoHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 0)];
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
}

#pragma mark - Network Interface
//获取制式视频列表
- (void)net_managementCompletion:(void(^)(BOOL isSuccess))completion{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameter setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameter setValue:[NSNumber numberWithInteger:0] forKey:@"type"];
    
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_personal_video"]
                            parameters:parameter
                               success:^(id responseObject) {
                                   if (individualVideoManagementProtocol(responseObject)) {
                                       completion(YES);
                                   } else {
                                       completion(NO);
                                   }
                               } failure:^(NSError *error) {
                                   NSLog(@"individual video management error is %@",error.localizedDescription);
                                   completion(NO);
                               }];
}

@end