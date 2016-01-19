//
//  IndividualVideoView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/19.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^VideoSelectedBlock)(NSInteger index);

@interface IndividualVideoView : UITableView

//视频选择block
@property (nonatomic, copy) VideoSelectedBlock selectedBlock;

@property (nonatomic, strong) UIViewController  *parentsViewController;

//首次加载
- (void)firstLoad;
//显示视频请求新消息提醒
- (void)showNewVideoRequestMessage:(BOOL)status;

@end
