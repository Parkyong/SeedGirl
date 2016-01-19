//
//  SetupLookFunsView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/9/25.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SetupLookFunsView.h"
#import "SetupLookFunsCell.h"
#import "SetupLookFunsHeader.h"
#import "UIScrollView+OwnRefresh.h"

@interface SetupLookFunsView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SetupLookFunsHeader *headerView;
@property (strong, nonatomic) NSMutableArray        *fansList;           //动态列表
@property (assign, nonatomic) NSInteger         fansListCount;           //动态列表总数
@property (assign, nonatomic) NSInteger          pageMaxCount;           //一页列表最大数量
@property (assign, nonatomic) NSInteger      currentPageIndex;           //当前页码索引
@property (strong, nonatomic) FansData                  *data;           //暂存数据

@end
@implementation SetupLookFunsView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self setParameters];
    [self addRefreshing];
}

#pragma mark    设置参数
- (void)setParameters{
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
}

#pragma mark - Main
//首次加载
- (void)firstLoad {
    if (_fansList == nil || _fansListCount == 0) {
        NSLog(@"fans first load");
        //开始刷新
        [self startDataRefresh];
    }
}

#pragma mark    添加刷新
- (void)addRefreshing{
    _currentPageIndex = 0;
    _pageMaxCount     = 10;
    _fansList         = [[NSMutableArray alloc] initWithCapacity:_pageMaxCount];
    _fansListCount    = 0;
    
    WeakSelf;
    //下拉刷新
    [self.tableView addHeaderWithRefreshingBlock:^{
        if ([weakSelf.tableView isFooterRefreshing]) {
            [weakSelf.tableView headerEndRefreshing];
            return ;
        }
        [weakSelf.tableView footerResetNoMoreData];
        weakSelf.currentPageIndex = 0;
        [weakSelf.fansList removeAllObjects];
        //添加测试数据
        [weakSelf addTestData];
    }];
    
    //上拉刷新
    [self.tableView addFooterWithRefreshingBlock:^{
        if([weakSelf.tableView isHeaderRefreshing]) {
            [weakSelf.tableView footerEndRefreshing];
            return ;
        }
        weakSelf.currentPageIndex ++;
        //添加测试数据
        [weakSelf addTestData];
    }];
}

//开始刷新
- (void)startDataRefresh {
    [self.tableView headerBeginRefreshing];
}

//停止刷新
- (void)stopDataRefresh {
    if([self.tableView isHeaderRefreshing]) {
        [self.tableView headerEndRefreshing];
    }
    
    if([self.tableView isFooterRefreshing]) {
        [self.tableView footerEndRefreshing];
    }
}

#pragma mark    添加数据
- (void)addTestData{
    [self getUserFansDataWithResultBlock:^(BOOL isSuccess, id netData) {
        if (isSuccess) {
            if (netData != nil) {
                for (NSDictionary *recordlistItem in netData) {
                    FansData *data = [[FansData alloc] init];
                    [data setData:recordlistItem];
                    [_fansList addObject:data];
                }
            }
            _fansListCount = _fansList.count;
            [self.tableView reloadData];
        }
        [self stopDataRefresh];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _fansListCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [Adaptor returnAdaptorValue:38];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [Adaptor returnAdaptorValue:79];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SetupLookFunsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetupLookFunsCell"];
    if (cell == nil) {
        cell = [[SetupLookFunsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SetupLookFunsCell"];
    }
    FansData *data = [self.fansList objectAtIndex:indexPath.row];
    [cell setCellData:data];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectedBlock != nil) {
        FansData *data = [_fansList objectAtIndex:indexPath.row];
        self.data = data;
        self.selectedBlock(data);
    }
}

#pragma mark    代理
- (NSString *)avatarWithChatter:(NSString *)chatter
{
    if ([chatter isEqualToString:[[UserManager manager] userHxid]]) {
        return [[[UserManager manager] userData] userIcon];
    }else{
        return self.data.fansIcon;
    }
}

- (NSString *)nickNameWithChatter:(NSString *)chatter
{
    if ([chatter isEqualToString:[[UserManager manager] userHxid]]) {
        return [[[UserManager manager] userData] userName];
    }else{
        return self.data.fansName;
    }
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = RGB(240, 242, 245);
    }
    return _tableView;
}

- (SetupLookFunsHeader *)headerView{
    if (_headerView == nil) {
        _headerView = [[SetupLookFunsHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [Adaptor returnAdaptorValue:38])];
        _headerView.backgroundColor = RGB(240, 242, 245);
    }
    return _headerView;
}

#pragma mark    数据请求
- (void)getUserFansDataWithResultBlock:(void(^)(BOOL isSuccess, id netData))result{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[NSNumber numberWithInteger:_currentPageIndex] forKey:@"page_number"];
    [parameter setValue:[NSNumber numberWithInteger:_pageMaxCount] forKey:@"limit_number"];
    [parameter setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameter setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl]
                                        stringByAppendingString:@"user_fans_rank"]
                            parameters:parameter success:^(id responseObject) {
                                [self.headerView setData:[[responseObject objectForKey:@"fansCount"] integerValue]];
                                if (publishProtocol(responseObject) == 0) {
                                    NSArray *fansList = [responseObject objectForKey:@"fansList"];
                                    result(YES, fansList);
                                }else{
                                    result(NO, nil);
                                }
                            } failure:^(NSError *error) {
                                result(NO, nil);
                            }];
}
@end