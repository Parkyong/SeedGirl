//
//  FilterSelectView.h
//  SeedGirl
//
//  Created by ParkHunter on 15/10/11.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FilterBlockType) (NSInteger);
@interface FilterSelectView : UIView
@property (nonatomic, copy) FilterBlockType filterBlock;
@end
