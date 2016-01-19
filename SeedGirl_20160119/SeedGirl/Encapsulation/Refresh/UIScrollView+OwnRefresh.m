//
//  UIScrollView+OwnRefresh.m
//  SeedSocial
//
//  Created by Admin on 15/7/14.
//  Copyright (c) 2015年 yulei. All rights reserved.
//

#import "UIScrollView+OwnRefresh.h"
#import "MJRefresh.h"

@implementation UIScrollView (OwnRefresh)

//添加下拉刷新
- (void)addHeaderWithRefreshingBlock:(void (^)())block {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        block();
    }];
    //设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}

//下拉刷新状态
- (BOOL)isHeaderRefreshing {
    return [self.mj_header isRefreshing];
}

//下拉刷新
- (void)headerBeginRefreshing {
    [self.mj_header beginRefreshing];
}

//下拉停止刷新
- (void)headerEndRefreshing {
    [self.mj_header endRefreshing];
}

//添加上拉刷新
- (void)addFooterWithRefreshingBlock:(void (^)())block {
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        block();
    }];
    //设置自动隐藏
    footer.automaticallyHidden = YES;
    self.mj_footer = footer;
}

//上拉刷新状态
- (BOOL)isFooterRefreshing {
    return [self.mj_footer isRefreshing];
}

//上拉刷新
- (void)footerBeginRefreshing {
    [self.mj_footer beginRefreshing];
}

//上拉停止刷新
- (void)footerEndRefreshing {
    [self.mj_footer endRefreshing];
}

//上拉刷新忽略值
- (void)footIgnoredScrollViewContentInsetBottom:(CGFloat)height {
    if ([self.mj_footer isKindOfClass:[MJRefreshBackNormalFooter class]]) {
        self.mj_footer.ignoredScrollViewContentInsetBottom = height;
    }
}

//上拉刷新重置无更多数据
- (void)footerResetNoMoreData {
    [self.mj_footer resetNoMoreData];
}

//上拉刷新无更多数据
- (void)footerNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

//获取footer高度
- (CGFloat)footerHeight {
    return MJRefreshFooterHeight;
}

@end
