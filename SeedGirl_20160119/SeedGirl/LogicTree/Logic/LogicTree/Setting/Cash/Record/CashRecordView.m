//
//  RecordView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/11/26.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "CashRecordView.h"
#import "CashRecordCell.h"
#import "CashRecordData.h"

#import "UIScrollView+OwnRefresh.h"

@interface CashRecordView () <UITableViewDataSource,UITableViewDelegate>
//头部视图
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *l_headerTip;

//记录列表
@property (strong, nonatomic) NSMutableArray *recordList;
//记录列表数量
@property (assign) NSInteger recordListCount;
//一页列表最大数量
@property (assign, nonatomic) NSInteger pageMaxCount;
//当前页码索引
@property (assign, nonatomic) NSInteger currentPageIndex;
@end

@implementation CashRecordView

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
    [self.headerView addSubview:self.l_headerTip];
}

//属性布局
- (void)attributeLayout {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self registerClass:[CashRecordCell class] forCellReuseIdentifier:NSStringFromClass([CashRecordCell class])];
    self.dataSource = self;
    self.delegate = self;
}

//设置刷新
- (void)setDataRefresh {
    _currentPageIndex = 0;
    _pageMaxCount = 10;
    _recordList = nil;
    _recordListCount = 0;
    
    WeakSelf;
    //下拉刷新
    [self addHeaderWithRefreshingBlock:^{
        if ([weakSelf isFooterRefreshing]) {
            [weakSelf headerEndRefreshing];
            return ;
        }
        [weakSelf footerResetNoMoreData];
        
        weakSelf.currentPageIndex = 0;
        weakSelf.recordListCount = 0;
        //添加测试数据
        [weakSelf cashRecordNetworkDataWithOverrideStatus:YES];
    }];
    
    //上拉刷新
    [self addFooterWithRefreshingBlock:^{
        if([weakSelf isHeaderRefreshing]) {
            [weakSelf footerEndRefreshing];
            return ;
        }
        
        weakSelf.currentPageIndex ++;
        //添加测试数据
        [weakSelf cashRecordNetworkDataWithOverrideStatus:NO];
    }];
}

#pragma mark - Main
//首次加载
- (void)firstLoad {
    _recordList = [[CacheDataManager sharedInstance] cashRecordList];
    _recordListCount = _recordList.count;
    
    if (_recordList == nil || _recordList == 0) {
        NSLog(@"record first load");
        //开始刷新
        [self startDataRefresh];
    } else {
        [self reloadData];
    }
}
//设置网络数据
- (void)cashRecordNetworkDataWithOverrideStatus:(BOOL)isOverride {
    [self net_cashRecordWithOverrideStatus:isOverride completion:^(BOOL isSuccess) {
        if (isSuccess) {
            self.recordList = [[CacheDataManager sharedInstance] cashRecordList];
            self.recordListCount = self.recordList.count;
            [self reloadData];
            
            if(self.recordListCount == 0 || self.recordListCount < ((self.currentPageIndex+1) * self.pageMaxCount)) {
                [self footerNoMoreData];
                
                if (self.recordListCount == 0) {
                    [self showTipMessage:@"您暂时还没有进行过提现操作"];
                } else if (self.currentPageIndex > 0) {
                    [self showTipMessage:@"暂无更多提现记录"];
                }
            }
        } else {
            [self showTipMessage:@"获取数据失败，请重试"];
        }
        [self stopDataRefresh];
    }];
}
//显示提示信息
- (void)showTipMessage:(NSString *)message{
    OwnProgressHUD *progressHUD = [OwnProgressHUD showAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
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
    return _recordListCount;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CashRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CashRecordCell class]) forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    CashRecordData *recordData = [_recordList objectAtIndex:indexPath.row];
    if (recordData != nil) {
        [cell setShowData:recordData];
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - lazyload
//头部视图
- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 30.0f)];
        _headerView.backgroundColor = RGBA(0, 0, 0, 0.5);
    }
    return _headerView;
}
- (UILabel *)l_headerTip {
    if (_l_headerTip == nil) {
        _l_headerTip = [[UILabel alloc] initWithFrame:self.headerView.bounds];
        _l_headerTip.backgroundColor = [UIColor clearColor];
        _l_headerTip.textAlignment = NSTextAlignmentCenter;
        _l_headerTip.textColor = [UIColor whiteColor];
        _l_headerTip.font = [UIFont systemFontOfSize:14.0f];
        _l_headerTip.lineBreakMode = NSLineBreakByTruncatingTail;
        _l_headerTip.text = @"提现金额将在7工作日内到账，请注意查收";
    }
    return _l_headerTip;
}

#pragma mark - Network Interface
//获取记录列表
- (void)net_cashRecordWithOverrideStatus:(BOOL)isOverride
                              completion:(void(^)(BOOL isSuccess))completion{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[NSNumber numberWithInteger:self.currentPageIndex] forKey:@"page_number"];
    [parameter setValue:[NSNumber numberWithInteger:self.pageMaxCount] forKey:@"limit_number"];
    [parameter setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameter setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_cash_record"]
                            parameters:parameter
                               success:^(id responseObject) {
                                   if (cashRecordProtocol(isOverride, responseObject)) {
                                       completion(YES);
                                   } else {
                                       completion(NO);
                                   }
                               } failure:^(NSError *error) {
                                   NSLog(@"cashRecord error is %@",error.localizedDescription);
                                   completion(NO);
                               }];
}

@end
