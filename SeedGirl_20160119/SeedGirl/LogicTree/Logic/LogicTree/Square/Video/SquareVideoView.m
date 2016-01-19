//
//  SquareVideoView.m
//  SeedGirl
//
//  Created by Admin on 15/10/29.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "SquareVideoView.h"
#import "SquareVideoViewLayout.h"
#import "SquareVideoViewCell.h"

#import "VideoData.h"
#import "RecordData.h"
#import "UIScrollView+OwnRefresh.h"

@interface SquareVideoView () <SquareVideoViewLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
//section边距
@property (nonatomic, assign) UIEdgeInsets sectionInsets;
//列数量
@property (nonatomic, assign) NSInteger columnCount;
//cell子对象间距
@property (nonatomic, assign) CGFloat minItemSpacing;
//列宽度
@property (nonatomic, assign) CGFloat columnWidth;

//视频列表
@property (nonatomic, strong) NSMutableArray *dataList;
//视频列表总数
@property (nonatomic, assign) NSInteger dataListCount;
//一页列表最大数量
@property (nonatomic, assign) NSInteger pageMaxCount;
//当前页码索引
@property (nonatomic, assign) NSInteger currentPageIndex;

@end

@implementation SquareVideoView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        //属性布局
        [self attributeLayout];
        //设置刷新
        [self setDataRefresh];
    }
    return self;
}

//属性布局
- (void)attributeLayout {
    //section边距
    _sectionInsets = UIEdgeInsetsMake(8.0f, 8.0f, 8.0f, 8.0f);
    //列数量
    _columnCount = 2;
    //cell子对象间距
    _minItemSpacing = 6.0f;
    //列宽度
    _columnWidth = (CGRectGetWidth(self.bounds)-16.0f-_minItemSpacing)/_columnCount;
    
    SquareVideoViewLayout *layout = (SquareVideoViewLayout *)self.collectionViewLayout;
    layout.delegate = self;
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self registerClass:[SquareVideoViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SquareVideoViewCell class])];
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
        [weakSelf videoNetworkDataWithOverrideStatus:YES];
    }];
    
    //上拉刷新
    [weakSelf addFooterWithRefreshingBlock:^{
        if([weakSelf isHeaderRefreshing]) {
            [weakSelf footerEndRefreshing];
            return ;
        }
        
        weakSelf.currentPageIndex ++;
        //添加测试数据
        [weakSelf videoNetworkDataWithOverrideStatus:NO];
    }];
}

#pragma mark - Main
//首次加载
- (void)firstLoad {
    _dataList = [[CacheDataManager sharedInstance] squareVideoList];
    _dataListCount = _dataList.count;
    
    if (_dataList == nil || _dataListCount == 0) {
        NSLog(@"video first load");
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
- (void)videoNetworkDataWithOverrideStatus:(BOOL)isOverride {
    [self net_squareVideoWithOverrideStatus:isOverride completion:^(BOOL isSuccess) {
        if (isSuccess) {
            self.dataList = [[CacheDataManager sharedInstance] squareVideoList];
            self.dataListCount = self.dataList.count;
            [self reloadData];
            
            if(self.dataListCount == 0 || self.dataListCount < ((self.currentPageIndex+1) * self.pageMaxCount)) {
                [self footerNoMoreData];

                if (self.dataListCount == 0) {
                    [self showTipMessage:@"暂无视频"];
                } else if (self.currentPageIndex > 0) {
                    [self showTipMessage:@"暂无更多视频"];
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
//获取子元素高度
- (CGFloat)getCollectionViewCellHeightAtWidth:(CGFloat)_width ByIndex:(NSInteger)_index {
    if (_dataListCount == 0) {
        return 0;
    }
    
    CGFloat height = 0;
    VideoData *data = [_dataList objectAtIndex:_index];
    if (data != nil) {
        height = (float)data.videoHeight/data.videoWidth*_width + 40.0f;
    }
    return height;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)layout numberOfColumnsInSection:(NSInteger)section {
    return _columnCount;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return _sectionInsets;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_columnWidth, [self getCollectionViewCellHeightAtWidth:_columnWidth ByIndex:indexPath.row]);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return _minItemSpacing;
}

#pragma mark - UICollection DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataListCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SquareVideoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SquareVideoViewCell class]) forIndexPath:indexPath];
    [cell addShadowEffect];
    
    VideoData *data = [_dataList objectAtIndex:indexPath.row];
    if (data != nil) {
        [cell setShowData:data];
    }
    return cell;
}

#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    VideoData *data = [_dataList objectAtIndex:indexPath.row];
    if (data != nil && self.selectedBlock) {
        self.selectedBlock(data);
    }
}

#pragma mark - Network Interface
//获取广场视频列表
- (void)net_squareVideoWithOverrideStatus:(BOOL)isOverride
                               completion:(void(^)(BOOL isSuccess))completion{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[[UserManager manager] userID] forKey:@"user_id"];
    [parameter setValue:[[UserManager manager] userSessionToken] forKey:@"session_token"];
    [parameter setValue:[NSNumber numberWithInteger:self.currentPageIndex] forKey:@"page_number"];
    [parameter setValue:[NSNumber numberWithInteger:self.pageMaxCount] forKey:@"limit_number"];
    [parameter setValue:[NSNumber numberWithInteger:0] forKey:@"type"];
    
    [[NetworkHTTPManager manager] POST:[[[NetworkHTTPManager manager] networkUrl] stringByAppendingString:@"user_square_video"]
                            parameters:parameter
                               success:^(id responseObject) {
                                   if (squareVideoProtocol(isOverride, responseObject)) {
                                       completion(YES);
                                   } else {
                                       completion(NO);
                                   }
                               } failure:^(NSError *error) {
                                   NSLog(@"squareVideo error is %@",error.localizedDescription);
                                   completion(NO);
                               }];
}

@end
