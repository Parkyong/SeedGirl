//
//  VideoManagementCell.h
//  SeedGirl
//  功能描述 - 视频管理列表cell
//  Created by Admin on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SystemVideoData;

@interface VideoManagementCell : UITableViewCell

//添加block
@property (nonatomic, copy) dispatch_block_t addBlock;
//修改block
@property (nonatomic, copy) dispatch_block_t modifyBlock;
//删除block
@property (nonatomic, copy) dispatch_block_t deleteBlock;

//设置显示数据
- (void)setShowData:(SystemVideoData *)data;

@end
