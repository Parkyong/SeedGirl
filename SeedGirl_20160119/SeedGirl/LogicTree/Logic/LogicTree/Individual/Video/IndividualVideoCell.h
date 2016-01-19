//
//  IndividualVideoCell.h
//  SeedGirl
//  功能描述 - 视频列表cell
//  Created by Admin on 16/1/11.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndividualVideoCell : UITableViewCell
//设置显示图片及标题
- (void)setShowPic:(UIImage *)image Title:(NSString *)title;
//显示视频新消息提醒
- (void)showRequestNewMessage:(BOOL)status;
@end
