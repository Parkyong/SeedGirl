//
//  VideoRequestCell.h
//  SeedGirl
//  功能描述 - 视频请求列表cell
//  Created by Admin on 15/10/14.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoRequestData;

@interface VideoRequestCell : UITableViewCell
//查看block
@property (nonatomic, copy) dispatch_block_t showBlock;
//删除block
@property (nonatomic, copy) dispatch_block_t deleteBlock;

//设置显示数据
- (void)setShowData:(VideoRequestData *)data;
//显示视频新消息提醒
- (void)showRequestNewMessage:(BOOL)status;

@end
