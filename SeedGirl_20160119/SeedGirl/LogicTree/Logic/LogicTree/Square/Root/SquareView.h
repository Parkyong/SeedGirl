//
//  SquareView.h
//  SeedGirl
//  功能描述 - 广场根试图
//  Created by Admin on 15/10/29.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecordData,VideoData;

typedef void(^DynamicBlock)(RecordData *recordData);
typedef void(^VideoBlock)(VideoData *videoData);
typedef void(^ScrollBlock)(NSInteger index);

@interface SquareView : UIScrollView
//滑动block
@property (nonatomic, copy) ScrollBlock scrollBlock;
//动态block
@property (nonatomic, copy) DynamicBlock dynamicBlock;
//视频block
@property (nonatomic, copy) VideoBlock videoBlock;

//显示指定视图
- (void)showSubViewAtIndex:(NSInteger)_index;
//更新广场数据
- (void)updateSquareData;

@end
