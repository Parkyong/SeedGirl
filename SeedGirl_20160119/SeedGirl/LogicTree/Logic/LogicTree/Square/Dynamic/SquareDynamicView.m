//
//  SquareDynamicView.m
//  SeedGirl
//
//  Created by Admin on 15/10/29.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "SquareDynamicView.h"
#import "SquareDynamicCell.h"
#import "RecordData.h"

#import "UIScrollView+OwnRefresh.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface SquareDynamicView () <UITableViewDataSource,UITableViewDelegate>
//动态列表
@property (strong, nonatomic) NSMutableArray *dataList;
//动态列表总数
@property (assign, nonatomic) NSInteger dataListCount;
//一页列表最大数量
@property (assign, nonatomic) NSInteger pageMaxCount;
//当前页码索引
@property (assign, nonatomic) NSInteger currentPageIndex;

@end

@implementation SquareDynamicView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //属性布局
        [self attributeLayout];
        //设置刷新
        [self setDataRefresh];
    }
    return self;
}

//属性布局
- (void)attributeLayout {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self registerClass:[SquareDynamicCell class] forCellReuseIdentifier:NSStringFromClass([SquareDynamicCell class])];
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
        //设置网络数据
        [weakSelf dynamicNetworkDataWithOverrideStatus:YES];
    }];
    
    //上拉刷新
    [self addFooterWithRefreshingBlock:^{
        if([weakSelf isHeaderRefreshing]) {
            [weakSelf footerEndRefreshing];
            return ;
        }
        
        weakSelf.currentPageIndex ++;
        //设置网络数据
        [weakSelf dynamicNetworkDataWithOverrideStatus:NO];
    }];
}

#pragma mark - Main
//首次加载
- (void)firstLoad {
    _dataList = [[CacheDataManager sharedInstance] squareDynamicList];
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
//设置网络数据
- (void)dynamicNetworkDataWithOverrideStatus:(BOOL)isOverride {
    [self net_dynamicWithOverrideStatus:isOverride completion:^(BOOL isSuccess) {
        if (isSuccess) {
            self.dataList = [[CacheDataManager sharedInstance] squareDynamicList];
            self.dataListCount = self.dataList.count;
            [self reloadData];
            
            
            //
            if(self.dataListCount == 0 || self.dataListCount < ((self.currentPageIndex+1) * self.pageMaxCount)) {
                [self footerNoMoreData];
                
                if (self.dataListCount == 0) {
                    [self showTipMessage:@"暂无动态"];
                }
//                else if (self.currentPageIndex > 0) {
//                    [self showTipMessage:@"暂无更多动态"];
//                }
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
    return _dataListCount;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([SquareDynamicCell class]) cacheByIndexPath:indexPath configuration:^(SquareDynamicCell *cell) {
        RecordData *recordData = [_dataList objectAtIndex:indexPath.row];
        if (recordData != nil) {
            [cell setShowData:recordData];
        }
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SquareDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SquareDynamicCell class]) forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    RecordData *recordData = [_dataList objectAtIndex:indexPath.row];
    if (recordData != nil) {
        [cell setShowData:recordData];
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
//获取广场动态列表
- (void)net_dynamicWithOverrideStatus:(BOOL)isOverride
                           completion:(void(^)(BOOL isSuccess))completion {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[NSNumber numberWithInteger:self.currentPageIndex] forKey:@"page_number"];
    [parameter setValue:[NSNumber numberWithInteger:self.pageMaxCount] forKey:@"limit_number"];
    [parameter setValue:[NSNumber numberWithInteger:0] forKey:@"type"];
    
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_square_dynamic"]
                            parameters:parameter
                               success:^(id responseObject) {
                                   if (squareDynamicProtocol(isOverride, responseObject)) {
                                       completion(YES);
                                   } else {
                                       completion(NO);
                                   }
    } failure:^(NSError *error) {
        NSLog(@"squareDynamic error is %@",error.localizedDescription);
        completion(NO);
    }];
}

@end