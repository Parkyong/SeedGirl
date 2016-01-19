//
//  VideoManagementView.m
//  SeedGirl
//
//  Created by Admin on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoManagementView.h"
#import "VideoManagementSummaryView.h"
#import "VideoManagementHeaderView.h"
#import "VideoManagementFooterView.h"
#import "VideoManagementCell.h"

#import "SystemVideoData.h"
#import "UIScrollView+OwnRefresh.h"

@interface VideoManagementView () <UITableViewDataSource, UITableViewDelegate>
//概括头视图
@property (nonatomic, strong) VideoManagementSummaryView *summaryHeaderView;
//管理视频头视图
@property (nonatomic, strong) VideoManagementHeaderView *videoHeaderView;
//管理视频底视图
@property (nonatomic, strong) VideoManagementFooterView *videoFooterView;
//概括头视图高度
@property (nonatomic, assign) CGFloat summaryHeaderViewHeight;
//管理视频头高度
@property (nonatomic, assign) CGFloat videoHeaderViewHeight;
//底视图高度
@property (nonatomic, assign) CGFloat videoFooterViewHeight;

//视频数据
@property (strong, nonatomic) NSMutableArray *videoList;
//视频数据数量
@property (assign) NSInteger videoListCount;

@end

@implementation VideoManagementView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //设置顶部底部视图
        [self setHeaderFooterView];
        //属性布局
        [self attributeLayout];
        //设置刷新
        [self setDataRefresh];
    }
    return self;
}

//设置顶部底部视图
- (void)setHeaderFooterView {
    _summaryHeaderViewHeight = [self.summaryHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    _videoHeaderViewHeight = [self.videoHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    _videoFooterViewHeight = [self.videoFooterView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    CGRect footerRect = self.videoFooterView.frame;
    footerRect.size.height = _videoFooterViewHeight;
    [self.videoFooterView setFrame:footerRect];
    
    self.tableFooterView = self.videoFooterView;
}
//属性布局
- (void)attributeLayout {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self registerClass:[VideoManagementCell class] forCellReuseIdentifier:NSStringFromClass([VideoManagementCell class])];
    self.dataSource = self;
    self.delegate = self;
}
//设置刷新
- (void)setDataRefresh {
    _videoList = nil;
    _videoListCount = 0;
    
    WeakSelf;
    //下拉刷新
    [self addHeaderWithRefreshingBlock:^{
        [weakSelf managementNetworkData];
    }];
}

#pragma mark    刷新页面
- (void)refreshView{
    [self managementNetworkData];
}

#pragma mark - Main
//首次加载
- (void)firstLoad {
    //设置概括数据
    [self.summaryHeaderView setShowData:[[CacheDataManager sharedInstance] individualVideoSummaryData]];
    _videoList = [[CacheDataManager sharedInstance] individualVideoManagementList];
    _videoListCount = _videoList.count;

    if (_videoList == nil || _videoList.count == 0) {
        NSLog(@"video management first load");
        [self startDataRefresh];
    } else {
        [self reloadData];
    }
}
//设置网络数据
- (void)managementNetworkData {
    [self net_managementCompletion:^(BOOL isSuccess) {
        if (isSuccess) {
            //设置概括数据
            [self.summaryHeaderView setShowData:[[CacheDataManager sharedInstance] individualVideoSummaryData]];
            self.videoList = [[CacheDataManager sharedInstance] individualVideoManagementList];
            self.videoListCount = self.videoList.count;
            [self reloadData];
            
            if(self.videoListCount == 0) {
                [self showTipMessage:@"暂时没有制式视频列表"];
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

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return _videoListCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoManagementCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VideoManagementCell class])];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [cell addShadowEffect];
    
    SystemVideoData *data = [_videoList objectAtIndex:indexPath.row];
    if (data != nil) {
        [cell setShowData:data];
        typeof(cell)weakCell = cell;
        cell.addBlock = ^{
            if (data.videoStatus == 0) {
                if (self.viewDelegate != nil &&
                    [self.viewDelegate respondsToSelector:@selector(addMovieWithCell:withIndexPath:withData:)]) {
                    [self.viewDelegate addMovieWithCell:weakCell withIndexPath:indexPath withData:data];
                }
            }
        };
        
        cell.modifyBlock = ^{
            if (data.videoStatus == 1) {
                if (self.viewDelegate != nil &&
                    [self.viewDelegate respondsToSelector:@selector(modifyMovieWithCell:withIndexPath:withData:)]) {
                    [self.viewDelegate modifyMovieWithCell:weakCell withIndexPath:indexPath withData:data];
                }
            }
        };
        
        cell.deleteBlock = ^{
            if (data.videoStatus == 1) {
                if (self.viewDelegate != nil &&
                    [self.viewDelegate respondsToSelector:@selector(deleteMovieWithCell:withIndexPath:withData:)]) {
                    [self.viewDelegate deleteMovieWithCell:weakCell withIndexPath:indexPath withData:data];
                }
            }
        };
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return _summaryHeaderViewHeight;
    }
    return _videoHeaderViewHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return _summaryHeaderView;
    }
    return _videoHeaderView;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    SystemVideoData *data = [_videoList objectAtIndex:indexPath.row];
    if (data.videoStatus == 0) {
        return;
    }
    
    if (self.viewDelegate != nil &&
        [self.viewDelegate respondsToSelector:@selector(playMoviewWithMoviePath:)]) {
        SystemVideoData *data = [_videoList objectAtIndex:indexPath.row];
        [self.viewDelegate playMoviewWithMoviePath:data.videoURL];
    }
}

#pragma mark - lazyload
//概括头视图
- (VideoManagementSummaryView *)summaryHeaderView {
    if (_summaryHeaderView == nil) {
        _summaryHeaderView = [[VideoManagementSummaryView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 0)];
        _summaryHeaderView.backgroundColor = RGB(240, 242, 245);
    }
    return _summaryHeaderView;
}
//视频头视图
- (VideoManagementHeaderView *)videoHeaderView {
    if (_videoHeaderView == nil) {
        _videoHeaderView = [[VideoManagementHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 0)];
        _videoHeaderView.backgroundColor = RGB(240, 242, 245);
    }
    return _videoHeaderView;
}
//视频底视图
- (VideoManagementFooterView *)videoFooterView {
    if (_videoFooterView == nil) {
        _videoFooterView = [[VideoManagementFooterView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 0)];
        _videoFooterView.backgroundColor = RGB(240, 242, 245);
    }
    return _videoFooterView;
}

#pragma mark - Network Interface
//获取制式视频列表
- (void)net_managementCompletion:(void(^)(BOOL isSuccess))completion{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameter setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameter setValue:[NSNumber numberWithInteger:1] forKey:@"type"];
    
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
