//
//  VideoRequestView.m
//  SeedGirl
//
//  Created by Admin on 15/10/15.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoRequestView.h"
#import "VideoRequestHeaderView.h"
#import "VideoRequestCell.h"
#import "VideoRequestData.h"
#import "PushNotificationManager.h"

#import "UIScrollView+OwnRefresh.h"

@interface VideoRequestView () <UITableViewDataSource, UITableViewDelegate>
//顶部视图
@property (nonatomic, strong) VideoRequestHeaderView *headerView;
//顶部视图高度
@property (nonatomic, assign) CGFloat headerViewHeight;

//请求数据
@property (strong, nonatomic) NSMutableArray *dataList;
//请求数据数量
@property (assign) NSInteger dataListCount;
//一页列表最大数量
@property (assign, nonatomic) NSInteger pageMaxCount;
//当前页码索引
@property (assign, nonatomic) NSInteger currentPageIndex;

@end

@implementation VideoRequestView

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
    _headerViewHeight = [self.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    [self.headerView setShowData:[[CacheDataManager sharedInstance] individualVideoSummaryData]];
}

//属性布局
- (void)attributeLayout {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self registerClass:[VideoRequestCell class] forCellReuseIdentifier:NSStringFromClass([VideoRequestCell class])];
    self.delegate = self;
    self.dataSource = self;
}

//设置刷新
- (void)setDataRefresh {
    _currentPageIndex = 0;
    _pageMaxCount = 10;
    _dataList = nil;
    _dataListCount = 0;
    
    WeakSelf;
    //下拉刷新
    [self addHeaderWithRefreshingBlock:^{
        if ([weakSelf isFooterRefreshing]) {
            [weakSelf headerEndRefreshing];
            return ;
        }
        [weakSelf footerResetNoMoreData];
        
        weakSelf.currentPageIndex = 0;
        weakSelf.dataListCount = 0;
        //添加测试数据
        [weakSelf requestNetworkDataWithOverrideStatus:YES];
    }];
    
    //上拉刷新
    [self addFooterWithRefreshingBlock:^{
        if([weakSelf isHeaderRefreshing]) {
            [weakSelf footerEndRefreshing];
            return ;
        }
        
        weakSelf.currentPageIndex ++;
        //添加测试数据
        [weakSelf requestNetworkDataWithOverrideStatus:NO];
    }];
}

#pragma mark - main
//首次加载
- (void)firstLoad {
    _dataList = [[CacheDataManager sharedInstance] individualVideoRequestList];
    _dataListCount = _dataList.count;
    
    if (_dataList == nil || _dataListCount == 0) {
        NSLog(@"request first load");
        //开始刷新
        [self startDataRefresh];
    } else {
        _currentPageIndex = _dataListCount%_pageMaxCount==0?_dataListCount/_pageMaxCount:_dataListCount/_pageMaxCount+1;
        if(_dataListCount < ((_currentPageIndex+1) * _pageMaxCount)) {
            [self footerNoMoreData];
        }
        
        [self reloadData];
    }
}
//设置网络数据
- (void)requestNetworkDataWithOverrideStatus:(BOOL)isOverride {
    [self net_requestWithOverrideStatus:isOverride completion:^(BOOL isSuccess) {
        if (isSuccess) {
            self.dataList = [[CacheDataManager sharedInstance] individualVideoRequestList];
            self.dataListCount = self.dataList.count;
            [self reloadData];
            
            if(self.dataListCount == 0 || self.dataListCount < ((self.currentPageIndex+1) * self.pageMaxCount)) {
                [self footerNoMoreData];
                
                if (self.dataListCount == 0) {
                    [self showTipMessage:@"您暂时没有视频请求"];
                }
//                else if (self.currentPageIndex > 0) {
//                    [self showTipMessage:@"暂无更多视频请求"];
//                }
            }
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
//选择
- (void)requestSelectedWithData:(VideoRequestData *)data {
    if (self.selectedblock) {
        self.selectedblock(data);
    }
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataListCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoRequestCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VideoRequestCell class]) forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    VideoRequestData *data = [_dataList objectAtIndex:indexPath.row];
    if (data != nil) {
        [cell setShowData:data];

        //新消息提醒
        BOOL status_newRequest = [[PushNotificationManager manager] isNewVideoRequest:data.requestID];
        [cell showRequestNewMessage:status_newRequest];
        
        cell.showBlock = ^(){
            [self requestSelectedWithData:data];
        };
        if (data.requestStatus != 0) {
            cell.deleteBlock = ^(){
                [self net_requestDeleteWithRequestID:data.requestID completion:^(BOOL isSuccess) {
                    if (isSuccess) {
                        [_dataList removeObjectAtIndex:indexPath.row];
                        _dataListCount = _dataList.count;
                        [self reloadData];
                    }
                }];
            };
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _headerViewHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    VideoRequestData *data = [_dataList objectAtIndex:indexPath.row];
    if (data != nil) {
        [self requestSelectedWithData:data];
    }
}

#pragma mark - lazyload
- (VideoRequestHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[VideoRequestHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 0)];
        _headerView.backgroundColor = RGB(240, 242, 245);
    }
    return _headerView;
}

#pragma mark - Network Interface
//获取视频请求列表
- (void)net_requestWithOverrideStatus:(BOOL)isOverride
                           completion:(void(^)(BOOL isSuccess))completion {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[NSNumber numberWithInteger:_currentPageIndex] forKey:@"page_number"];
    [parameter setValue:[NSNumber numberWithInteger:_pageMaxCount] forKey:@"limit_number"];
    [parameter setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameter setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    NSLog(@"parameter is %@",parameter);
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_personal_request"]
                            parameters:parameter
                               success:^(id responseObject) {
                                   if (individualVideoRequestProtocol(isOverride, responseObject)) {
                                       completion(YES);
                                   } else {
                                       completion(NO);
                                   }
                               } failure:^(NSError *error) {
                                   NSLog(@"individual video request error is %@",error.localizedDescription);
                                   completion(NO);
                               }];
}
//删除视频请求
- (void)net_requestDeleteWithRequestID:(NSString *)requestID
                            completion:(void(^)(BOOL isSuccess))completion {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:requestID forKey:@"requestID"];
    [parameter setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameter setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_personal_reqdel"]
                            parameters:parameter
                               success:^(id responseObject) {
                                   if (publishProtocol(responseObject) == 0) {
                                       completion(YES);
                                   } else {
                                       completion(NO);
                                   }
                               } failure:^(NSError *error) {
                                   NSLog(@"individual video request delete error is %@",error.localizedDescription);
                                   completion(NO);
                               }];
}

@end
