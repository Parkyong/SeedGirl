//
//  SquareVideoViewCell.h
//  SeedGirl
//  功能描述 - 广场视频试图cell
//  Created by Admin on 15/11/2.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoData;

@interface SquareVideoViewCell : UICollectionViewCell

//设置数据
- (void)setShowData:(VideoData *)_data;

@end
