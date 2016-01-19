//
//  SquareVideoView.h
//  SeedGirl
//  功能描述 - 广场视频试图
//  Created by Admin on 15/10/29.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoData;

typedef void(^VideoSelectedBlock)(VideoData *videoData);

@interface SquareVideoView : UICollectionView
//动态选择block
@property (nonatomic, copy) VideoSelectedBlock selectedBlock;

//首次加载
- (void)firstLoad;

@end
