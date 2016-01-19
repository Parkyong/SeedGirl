//
//  ProgressBar.h
//  RecordingTest
//
//  Created by ParkHunter on 15/8/14.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressBar : UIView
typedef enum {
    ProgressBarProgressStyleNormal,
    ProgressBarProgressStyleDelete,
} ProgressBarProgressStyle;

#pragma mark    Action
+ (ProgressBar *)getInstance;

//添加progress分段片
- (void)addProgressView;

//删除progress分段片
- (void)deleteLastProgress;

//设置最后分段片的状态
- (void)setLastProgressToStyle:(ProgressBarProgressStyle)style;

//设置最后分段片的长度
- (void)setLastProgressToWidth:(CGFloat)width;

//指示灯开启
- (void)startShining;

//指示灯关闭
- (void)stopShining;
@end
