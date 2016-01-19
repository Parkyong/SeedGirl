//
//  AlbumItemCell.h
//  RecordingTest
//
//  Created by ParkHunter on 15/8/7.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AlbumItemCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, assign) BOOL isPhotoImageSelected;
- (void)setImageCover:(BOOL)isAddingCover;
@end
