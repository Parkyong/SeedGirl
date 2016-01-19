//
//  UIScrollView+OwnRefresh.h
//  SeedSocial
//
//  Created by Admin on 15/7/14.
//  Copyright (c) 2015年 yulei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (OwnRefresh)

//添加下拉刷新
- (void)addHeaderWithRefreshingBlock:(void (^)())block;
//下拉刷新状态
- (BOOL)isHeaderRefreshing;
//下拉刷新
- (void)headerBeginRefreshing;
//下拉停止刷新
- (void)headerEndRefreshing;

//添加上拉刷新
- (void)addFooterWithRefreshingBlock:(void (^)())block;
//上拉刷新状态
- (BOOL)isFooterRefreshing;
//上拉刷新
- (void)footerBeginRefreshing;
//上拉停止刷新
- (void)footerEndRefreshing;
//上拉刷新忽略值
- (void)footIgnoredScrollViewContentInsetBottom:(CGFloat)height;

//上拉刷新重置无更多数据
- (void)footerResetNoMoreData;
//上拉刷新无更多数据
- (void)footerNoMoreData;

@end
