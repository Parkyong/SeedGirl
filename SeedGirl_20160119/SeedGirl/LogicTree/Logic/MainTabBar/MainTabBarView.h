//
//  MainTabBarView.h
//  SeedGirl
//  功能描述 - 底部标签视图
//  Created by Admin on 15/11/18.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedIndexBlock)(NSInteger index);

@interface MainTabBarView : UIView

@property (nonatomic, copy) SelectedIndexBlock selectedBlock;

//设置默认索引
- (void)setDefaultSelectedIndex:(NSInteger)index;
//设置选择索引
- (void)setSelectedIndex:(NSInteger)index;

//显示视频请求新消息提醒
- (void)showNewVideoRequestMessage:(BOOL)status;
//显示纸条新消息提醒
- (void)showNewNoteMessage:(BOOL)status;

@end
