//
//  VideoRequestView.h
//  SeedGirl
//  功能描述 - 视频请求列表
//  Created by Admin on 15/10/15.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoRequestData;

typedef void(^RequestSelectedBlock)(VideoRequestData *data);

@interface VideoRequestView : UITableView

@property (nonatomic, copy) RequestSelectedBlock selectedblock;
@property (nonatomic, copy) RequestSelectedBlock deleteBlock;

//首次加载
- (void)firstLoad;
//开始刷新
- (void)startDataRefresh;
@end
