//
//  SquareVideoViewLayout.h
//  SeedGirl
//  功能描述 - 广场视频试图layout
//  Created by Admin on 15/11/5.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SquareVideoViewLayoutDelegate <UICollectionViewDelegateFlowLayout>
@required
#pragma mark - 自定义
//列数量
- (NSInteger)collectionView:(UICollectionView *)collectionView
                     layout:(UICollectionViewLayout *)layout
   numberOfColumnsInSection:(NSInteger)section;

@end

@interface SquareVideoViewLayout : UICollectionViewLayout

@property (weak, nonatomic) id<SquareVideoViewLayoutDelegate> delegate;

@end
