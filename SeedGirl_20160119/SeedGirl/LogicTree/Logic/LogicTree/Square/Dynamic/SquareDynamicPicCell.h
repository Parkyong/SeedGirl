//
//  SquareDynamicPicCell.h
//  SeedGirl
//
//  Created by Admin on 15/11/25.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquareDynamicPicCell : UICollectionViewCell
//设置图片数据以及是否是视频
- (void)setShowPic:(NSString *)data isVideo:(BOOL)status;
//设置图片总数量
- (void)setPicMaxCount:(NSInteger)count;
@end
