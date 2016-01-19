//
//  SelectCoverScrollView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/10/16.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CoverBlockType) (UIImage *);
@interface SelectCoverScrollView : UIView
@property (nonatomic, copy) CoverBlockType coverBlock;
-(void)setCoverImages:(NSArray *)images;
@end
