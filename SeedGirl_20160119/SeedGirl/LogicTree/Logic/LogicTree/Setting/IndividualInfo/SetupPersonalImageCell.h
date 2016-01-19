//
//  SetupPersonalImageCell.h
//  SeedGirl
//
//  Created by ParkHunter on 15/9/28.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SetupPersonalImageCellProtocol;
@interface SetupPersonalImageCell : UICollectionViewCell
@property (nonatomic, strong) NSIndexPath     *indexPath;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, assign) BOOL                isEdit;
@property (nonatomic, assign) id <SetupPersonalImageCellProtocol> delegate;
- (void)startShakeView;
- (void)stopShakeView;
@end

@protocol SetupPersonalImageCellProtocol <NSObject>
@optional
- (void)setupPersonalImageCellTapAction:(SetupPersonalImageCell *)cell withIndex:(NSIndexPath *)indexPath;
- (void)setupPersonalImageCellLongPressAction:(SetupPersonalImageCell *)cell withIndex:(NSIndexPath *)indexPath withGesture:(UILongPressGestureRecognizer *)longGR;
- (void)setupPersonalImageCellDeleteAction:(SetupPersonalImageCell *)cell withIndex:(NSIndexPath *)indexPath;
@end
