//
//  VideoManagementView.h
//  SeedGirl
//  功能描述 - 视频管理视图
//  Created by Admin on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoManagementCell.h"

@protocol VideoManagementViewProtocol <NSObject>
#pragma mark    增加视频
- (void)addMovieWithCell:(VideoManagementCell *)cell
           withIndexPath:(NSIndexPath *)indexPath
                withData:(SystemVideoData*)data;

#pragma mark    修改视频
- (void)modifyMovieWithCell:(VideoManagementCell *)cell
              withIndexPath:(NSIndexPath *)indexPath
                   withData:(SystemVideoData*)data;

#pragma mark    删除视频
- (void)deleteMovieWithCell:(VideoManagementCell *)cell
              withIndexPath:(NSIndexPath *)indexPath
                   withData:(SystemVideoData*)data;

#pragma mark    播放视频
- (void)playMoviewWithMoviePath:(NSString*)moviePath;
@end

@interface VideoManagementView : UITableView
@property (nonatomic, assign) id <VideoManagementViewProtocol>viewDelegate;


- (void)firstLoad;          //首次加载

- (void)refreshView;        //刷新页面

- (void)startDataRefresh;   //更新数据
@end
