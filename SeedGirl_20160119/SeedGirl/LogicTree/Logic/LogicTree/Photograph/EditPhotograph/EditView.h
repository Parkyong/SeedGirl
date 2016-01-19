//
//  EditView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/10/11.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditView : UIView
@property (nonatomic, strong) UIImage                 *showImage;
@property (nonatomic, strong) NSMutableArray     *imageContainer;
@property (nonatomic, strong) UIButton             *returnButton;
@property (nonatomic, strong) UIButton             *finishButton;
- (void)setShowImageViewsImage:(UIImage *)image;
@end
