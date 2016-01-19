//
//  TellStoryCell.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/17.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TellStoryCellProtocol;
@interface TellStoryCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView         *headImageView;
@property (nonatomic, strong) NSIndexPath             *indexPath;
@property (nonatomic, assign) id <TellStoryCellProtocol>delegate;
- (void)setDeleteButtonHidden:(BOOL)isHidden;
@end
@protocol TellStoryCellProtocol <NSObject>
- (void)deleteImageWithCell:(TellStoryCell *)cell withIndex:(NSIndexPath *)index;
@end