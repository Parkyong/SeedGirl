//
//  SelectCoverView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/10/16.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCoverView : UIView
@property (nonatomic, strong) UIButton  *returnButton;
//@property (nonatomic, strong) UIButton  *finishButton;
@property (nonatomic, weak) UIImage*       coverImage;

- (void)setShowImage:(UIImage *)showImage;
- (void)setCoverScrollViewWithImages:(NSArray *)images;
@end
