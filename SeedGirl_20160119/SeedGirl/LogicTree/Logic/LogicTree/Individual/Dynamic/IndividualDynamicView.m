//
//  IndividualDynamicView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/19.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "IndividualDynamicView.h"
#import "IndividualDynamicCell.h"
#import "RecordData.h"

#import "UIScrollView+OwnRefresh.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface IndividualDynamicView () <UITableViewDataSource,UITableViewDelegate>
//动态列表
@property (strong, nonatomic) NSMutableArray *dataList;
//动态列表总数
@property (assign) NSInteger dataListCount;
//一页列表最大数量
@property (assign, nonatomic) NSInteger pageMaxCount;
//当前页码索引
@property (assign, nonatomic) NSInteger currentPageIndex;

@end

@implementation IndividualDynamicView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //属性布局
        [self attributeLayout];
        //设置刷新
        [self setDataRefresh];
    }
    return self;
}

//添加观察者
- (void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(viewReloadData)
                                                 name:kUserLogout object:nil];
}

//删除观察者
- (void)removeObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kUserLogout
                                                  object:nil];
}

//刷新数据
- (void)viewReloadData{
    [_dataList removeAllObjects];
    _dataListCount = _dataList.count;
    [self reloadData];
}

//属性布局
- (void)attributeLayout {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self registerClass:[IndividualDynamicCell class] forCellReuseIdentifier:NSStringFromClass([IndividualDynamicCell class])];
    self.dataSource = self;
    self.delegate = self;
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
        [weakSelf dynamicNetworkDataWithOverrideStatus:YES];
    }];
    
    //上拉刷新
    [self addFooterWithRefreshingBlock:^{
        if([weakSelf isHeaderRefreshing]) {
            [weakSelf footerEndRefreshing];
            return ;
        }
        
        weakSelf.currentPageIndex ++;
        //添加测试数据
        [weakSelf dynamicNetworkDataWithOverrideStatus:NO];
    }];
}

#pragma mark - Main
//首次加载
- (void)firstLoad {
    _dataList = [[CacheDataManager sharedInstance] individualDynamicList];
    _dataListCount = _dataList.count;
    
    if (_dataList == nil || _dataListCount == 0) {
        NSLog(@"dynamic first load");
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
//获取网络数据
- (void)dynamicNetworkDataWithOverrideStatus:(BOOL)isOverride {
    [self net_dynamicWithOverrideStatus:isOverride completion:^(BOOL isSuccess) {
        if (isSuccess) {
            self.dataList = [[CacheDataManager sharedInstance] individualDynamicList];
            self.dataListCount = self.dataList.count;
            [self reloadData];
            
            if(self.dataListCount == 0 || self.dataListCount < ((self.currentPageIndex+1) * self.pageMaxCount)) {
                [self footerNoMoreData];
                
                if (self.dataListCount == 0) {
                    [self showTipMessage:@"您暂时还没有发表过动态"];
                } else if (self.currentPageIndex > 0) {
                    [self showTipMessage:@"暂无更多动态"];
                }
            }
        } else {
            [self showTipMessage:@"获取数据失败，请重试"];
        }
        [self stopDataRefresh];
    }];
}
//动态奖励网络数据
- (void)dynamicRewardNetworkDataWithIndexPath:(NSIndexPath *)indexPath
                                     recordData:(RecordData *)recordData {
    [self net_dynamicRewardWithReocrdID:recordData.recordID completion:^(BOOL isSuccess, NSInteger count) {
        if (isSuccess) {
            [self showTipMessage:[NSString stringWithFormat:@"钻石数+%ld",(long)count]];
            recordData.hasReward = YES;
            
            NSArray *indexPaths = @[indexPath];
            [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            [self showTipMessage:@"领取钻石失败"];
        }
    }];
}
//显示提示信息
- (void)showTipMessage:(NSString *)message {
    OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:self animated:YES];
    [progressHUD setCenterYOffset:self.contentOffset.y];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataListCount;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([IndividualDynamicCell class]) cacheByIndexPath:indexPath configuration:^(IndividualDynamicCell *cell) {
        RecordData *recordData = [_dataList objectAtIndex:indexPath.row];
        if (recordData != nil) {
            [cell setShowData:recordData];
        }
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IndividualDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IndividualDynamicCell class]) forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    RecordData *recordData = [_dataList objectAtIndex:indexPath.row];
    if (recordData != nil) {
        [cell setShowData:recordData];

        cell.rewardBlock = ^(BOOL status) {
            if (status) {
                [self dynamicRewardNetworkDataWithIndexPath:indexPath recordData:recordData];
            } else {
                [self showTipMessage:@"本条动态赞的数量未达到5，无法领取钻石"];
            }
        };
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 8.0f;
    }
    return 0.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RecordData *recordData = [_dataList objectAtIndex:indexPath.row];
    if (recordData != nil && self.selectedBlock) {
        self.selectedBlock(recordData);
    }
}

#pragma mark - Network Interface
//获取个人动态列表
- (void)net_dynamicWithOverrideStatus:(BOOL)isOverride
                                 completion:(void(^)(BOOL isSuccess))completion {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameter setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameter setValue:[NSNumber numberWithInteger:self.currentPageIndex] forKey:@"page_number"];
    [parameter setValue:[NSNumber numberWithInteger:self.pageMaxCount] forKey:@"limit_number"];
    [parameter setValue:[NSNumber numberWithInteger:1] forKey:@"type"];
    
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_square_dynamic"]
                            parameters:parameter
                               success:^(id responseObject) {
                                   if (individualDynamicProtocol(isOverride, responseObject)) {
                                       completion(YES);
                                   } else {
                                       completion(NO);
                                   }
                               } failure:^(NSError *error) {
                                   NSLog(@"squareDynamic error is %@",error.localizedDescription);
                                   completion(NO);
                               }];
}
//个人动态获取奖励列表
- (void)net_dynamicRewardWithReocrdID:(NSString *)rewardID
                           completion:(void(^)(BOOL isSuccess, NSInteger count))completion {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameter setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameter setValue:rewardID forKey:@"blog_id"];
    NSLog(@"parameter is %@",parameter);
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_get_reward"]
                            parameters:parameter
                               success:^(id responseObject) {
                                   NSLog(@"responseObject is %@",responseObject);
                                   if (publishProtocol(responseObject) == 0) {
                                       NSInteger rewardCount = 0;
                                       id reward_balance = [responseObject objectForKey:@"reward_balance"];
                                       if(reward_balance != nil && reward_balance != [NSNull null]) {
                                           rewardCount = [reward_balance integerValue];
                                           reward_balance = nil;
                                       }
                                       
                                       id user_balance = [responseObject objectForKey:@"user_balance"];
                                       if(user_balance != nil && user_balance != [NSNull null]) {
                                           [UserManager manager].userBalance = [user_balance integerValue];
                                           user_balance = nil;
                                       }
                                       completion(YES,rewardCount);
                                   } else {
                                       completion(NO,0);
                                   }
                               } failure:^(NSError *error) {
                                   NSLog(@"dynamic reward error is %@",error.localizedDescription);
                                   completion(NO,0);
                               }];
}

@end