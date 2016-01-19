//
//  OptionTagItemCell.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeedTagData.h"
//@protocol OptionTagItemCellProtocol;
@interface OptionTagItemCell : UICollectionViewCell
//@property (nonatomic, assign) id <OptionTagItemCellProtocol> delegate;
@property (nonatomic, strong) UILabel             *tagLabel;
@property (nonatomic, strong) NSIndexPath *indexPath;
- (void)setData:(SeedTagData *)data;
@end
//@protocol OptionTagItemCellProtocol <NSObject>
//- (void)OptionTagItemCellTapAction:(OptionTagItemCell *)cell withIndex:(NSIndexPath *)indexPath;
//@end