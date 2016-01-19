//
//  FilterCell.h
//  SeedGirl
//
//  Created by ParkHunter on 15/10/11.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, FilterCellType){
    FilterCellNormal,
    FilterCellSelected
};

@interface FilterCell : UIView
@property (nonatomic, copy)     NSString         *name;
@property (nonatomic, strong)   UIImage         *image;
@property (nonatomic, assign)   FilterCellType    type;
@end
