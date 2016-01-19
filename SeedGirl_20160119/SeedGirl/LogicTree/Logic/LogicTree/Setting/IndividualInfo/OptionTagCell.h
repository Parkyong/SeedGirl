//
//  OptionTagCell.h
//  SeedGirl
//
//  Created by ParkHunter on 15/11/13.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OptionTagCellProtocol;
@interface OptionTagCell : UITableViewCell
@property (nonatomic, assign) id <OptionTagCellProtocol>delegate;
- (void)setDataWithCell:(OptionTagCell *)cell withData:(NSArray *)data;

- (CGFloat)getHeigth;
@end

@protocol OptionTagCellProtocol <NSObject>
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end
